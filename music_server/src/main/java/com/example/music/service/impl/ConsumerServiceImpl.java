package com.example.music.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.music.model.Result;
import com.example.music.mapper.ConsumerMapper;
import com.example.music.mapper.UserSupportMapper;
import com.example.music.mapper.CommentMapper;
import com.example.music.model.domain.Consumer;
import com.example.music.model.domain.UserSupport;
import com.example.music.model.domain.Comment;
import com.example.music.model.request.ConsumerRequest;
import com.example.music.model.request.ResetPasswordRequest;
import com.example.music.service.ConsumerService;
import com.example.music.utils.JwtUtils;
import com.example.music.utils.OssUtil;
import com.example.music.utils.RandomUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Service
public class ConsumerServiceImpl extends ServiceImpl<ConsumerMapper, Consumer>
        implements ConsumerService {

    @Autowired
    private ConsumerMapper consumerMapper;

    @Autowired
    private UserSupportMapper userSupportMapper;

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private SimpleOrderManager simpleOrderManager;

    /**
     * 新增用户
     */
    @Override
    public Result addUser(ConsumerRequest registryRequest) {
        if (this.existUser(registryRequest.getUsername())) {
            return Result.warning("用户名已注册");
        }
        Consumer consumer = new Consumer();
        BeanUtils.copyProperties(registryRequest, consumer);
        String password = registryRequest.getPassword();
        consumer.setPassword(password);
        if (StringUtils.isBlank(consumer.getPhoneNum())) {
            consumer.setPhoneNum(null);
        }
        if ("".equals(consumer.getEmail())) {
            consumer.setEmail(null);
        }
        consumer.setAvator("img/avatorImages/user.jpg");
        try {
            QueryWrapper<Consumer> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("email",consumer.getEmail());
            Consumer one = consumerMapper.selectOne(queryWrapper);
            if (one!=null){
                return Result.fatal("邮箱不允许重复");
            }
            if (consumerMapper.insert(consumer) > 0) {
                return Result.success("注册成功");
            } else {
                return Result.error("注册失败");
            }
        } catch (DuplicateKeyException e) {
            return Result.fatal(e.getMessage());
        }
    }

    @Override
    public Result updateUserMsg(ConsumerRequest updateRequest) {
        Consumer consumer = new Consumer();
        BeanUtils.copyProperties(updateRequest, consumer);
        if (consumerMapper.updateById(consumer) > 0) {
            return Result.success("修改成功");
        } else {
            return Result.error("修改失败");
        }
    }

    /**
     * getOldPassword 用处
     * @param updatePasswordRequest
     * @return
     */
    @Override
    public Result updatePassword(ConsumerRequest updatePasswordRequest) {
        // 验证旧密码
        Consumer consumer = this.verityPasswd(updatePasswordRequest.getUsername(), updatePasswordRequest.getOldPassword());
        if (consumer == null) {
            return Result.error("密码输入错误");
        }

        // 更新新密码
        Consumer updateConsumer = new Consumer();
        updateConsumer.setId(updatePasswordRequest.getId());
        String password = updatePasswordRequest.getPassword();
        updateConsumer.setPassword(password);

        if (consumerMapper.updateById(updateConsumer) > 0) {
            return Result.success("密码修改成功");
        } else {
            return Result.error("密码修改失败");
        }
    }

    /**
     * 忘记密码修改密码接口
     * @param updatePasswordRequest
     * @return
     */
    @Override
    public Result updatePassword01(ConsumerRequest updatePasswordRequest) {
        Consumer consumer = new Consumer();
        consumer.setId(updatePasswordRequest.getId());
        String password = updatePasswordRequest.getPassword();
        consumer.setPassword(password);

        if (consumerMapper.updateById(consumer) > 0) {
            return Result.success("密码修改成功");
        } else {
            return Result.error("密码修改失败");
        }
    }


    @Override
    public Result updateUserAvator(MultipartFile avatorFile, int id) {
        Consumer consumer = consumerMapper.selectById(id);
        String oldUrl = consumer.getAvator();
        
        try {
            // 如果存在旧文件，则删除
            if (oldUrl != null && !oldUrl.isEmpty() && !oldUrl.equals("/img/avatorImages/admin.jpg")) {
                String objectName = oldUrl.substring(oldUrl.lastIndexOf("/") + 1);
                OssUtil.deleteAvatar(objectName);
            }
            
            String url = OssUtil.uploadAvatar(avatorFile);
            if (url.startsWith("Error")) {
                return Result.error("头像上传失败");
            }
            
            consumer.setId(id);
            consumer.setAvator(url);
            
            if (consumerMapper.updateById(consumer) > 0) {
                return Result.success("上传成功", url);
            } else {
                return Result.error("上传失败");
            }
        } catch (Exception e) {
            return Result.error("头像处理失败: " + e.getMessage());
        }
    }

    @Override
    public boolean existUser(String username) {
        QueryWrapper<Consumer> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username",username);
        return consumerMapper.selectCount(queryWrapper) > 0;
    }

    /**
     * 验证密码并返回用户对象
     */
    @Override
    public Consumer verityPasswd(String username, String password) {
        QueryWrapper<Consumer> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username)
                   .eq("password", password);
        return consumerMapper.selectOne(queryWrapper);
    }

    @Override
    public Result loginStatus(ConsumerRequest loginRequest) {
        String username = loginRequest.getUsername();
        String password = loginRequest.getPassword();

        Consumer consumer = this.verityPasswd(username, password);
        if (consumer != null) {
            // 创建JWT令牌
            Map<String, Object> claims = new HashMap<>();
            claims.put("username", username);
            claims.put("id", consumer.getId());
            String jwt = JwtUtils.generateJwt(claims);
            
            Map<String, Object> result = new HashMap<>();
            result.put("token", jwt);
            result.put("userInfo", consumer);
            
            return Result.success("登录成功", result);
        } else {
            return Result.error("用户名或密码错误");
        }
    }

    @Override
    public Result loginEmailStatus(ConsumerRequest loginRequest) {
        String email = loginRequest.getEmail();
        String password = loginRequest.getPassword();
        Consumer consumer1 = findByEmail(email);
        if (consumer1 == null) {
            return Result.error("邮箱不存在");
        }
        
        Consumer consumer = this.verityPasswd(consumer1.getUsername(), password);
        if (consumer != null) {
            // 创建JWT令牌
            Map<String, Object> claims = new HashMap<>();
            claims.put("username", consumer.getUsername());
            claims.put("id", consumer.getId());
            String jwt = JwtUtils.generateJwt(claims);
            
            Map<String, Object> result = new HashMap<>();
            result.put("token", jwt);
            result.put("userInfo", consumer);
            
            return Result.success("登录成功", result);
        } else {
            return Result.error("用户名或密码错误");
        }
    }

    @Override
    public Consumer findByEmail(String email) {
        QueryWrapper<Consumer> queryWrapper=new QueryWrapper<>();
        queryWrapper.eq("email",email);
        Consumer consumer = consumerMapper.selectOne(queryWrapper);
        return consumer;
    }

    // 删除用户
    @Override
    @Transactional
    public Result deleteUser(Integer id) {
        try {
            Consumer consumer = consumerMapper.selectById(id);
            if (consumer == null) {
                return Result.error("用户不存在");
            }

            String avator = consumer.getAvator();
            
            // 查找该用户的所有点赞记录
            QueryWrapper<UserSupport> supportQueryWrapper = new QueryWrapper<>();
            supportQueryWrapper.eq("user_id", id);
            List<UserSupport> userSupports = userSupportMapper.selectList(supportQueryWrapper);
            
            // 处理每个点赞记录对应的评论
            for (UserSupport support : userSupports) {
                Comment comment = commentMapper.selectById(support.getCommentId());
                if (comment != null && !comment.getUserId().equals(id)) {
                    // 只有当评论存在且不是用户自己的评论时才减少点赞数
                    comment.setUp(Math.max(0, comment.getUp() - 1));
                    commentMapper.updateById(comment);
                }
            }
            
            // 删除用户数据库记录（会通过外键级联删除相关记录）
            if (consumerMapper.deleteById(id) <= 0) {
                return Result.error("删除失败");
            }
            
            // 删除非默认头像
            if (avator != null && !avator.isEmpty() && !avator.equals("img/avatorImages/user.jpg")) {
                String objectName = avator.substring(avator.lastIndexOf("/") + 1);
                OssUtil.deleteAvatar(objectName);
            }
            
            return Result.success("删除成功");
        } catch (Exception e) {
            return Result.error("删除失败: " + e.getMessage());
        }
    }

    @Override
    public Result allUser() {
        return Result.success(null, consumerMapper.selectList(null));
    }

    @Override
    public Result userOfId(Integer id) {
        QueryWrapper<Consumer> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("id",id);
        return Result.success(null, consumerMapper.selectList(queryWrapper));
    }

    @Override
    public Result resetPassword(ResetPasswordRequest passwordRequest) {
        Consumer user = findByEmail(passwordRequest.getEmail());
        if (user == null) {
            return Result.fatal("用户不存在");
        }
        
        String code = stringRedisTemplate.opsForValue().get(user.getEmail());
        if (code == null || !code.equals(passwordRequest.getCode())) {
            return Result.fatal("验证码不存在或失效");
        }
        
        ConsumerRequest consumerRequest = new ConsumerRequest();
        BeanUtils.copyProperties(user, consumerRequest);
        consumerRequest.setPassword(passwordRequest.getPassword());
        
        Result result = updatePassword01(consumerRequest);
        if (result.getType().equals("success")) {
            return Result.success("密码修改成功");
        }
        return Result.error("密码修改失败");
    }

    @Override
    public Result sendVerificationCode(String email) {
        Consumer user = findByEmail(email);
        if (user == null) {
            return Result.fatal("用户不存在");
        }
        
        String code = RandomUtils.code();
        simpleOrderManager.sendCode(code, email);
        
        // 保存验证码到Redis，5分钟有效期
        stringRedisTemplate.opsForValue().set(email, code, 5, TimeUnit.MINUTES);
        
        return Result.success("发送成功");
    }

}
