package com.example.music.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.music.model.Result;
import com.example.music.mapper.AdminMapper;
import com.example.music.model.domain.Admin;
import com.example.music.model.request.AdminRequest;
import com.example.music.service.AdminService;
import com.example.music.utils.JwtUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class AdminServiceImpl extends ServiceImpl<AdminMapper, Admin> implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public Result verityPasswd(AdminRequest adminRequest) {
        QueryWrapper<Admin> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("name", adminRequest.getUsername());
        queryWrapper.eq("password", adminRequest.getPassword());
        
        Admin admin = adminMapper.selectOne(queryWrapper);
        if (admin != null) {
            // 创建JWT令牌
            Map<String, Object> claims = new HashMap<>();
            claims.put("username", admin.getName());
            claims.put("id", admin.getId());
            String jwt = JwtUtils.generateJwt(claims);
            
            Map<String, Object> result = new HashMap<>();
            result.put("token", jwt);
            result.put("adminInfo", admin);
            
            return Result.success("登录成功", result);
        }
        return Result.error("用户名或密码错误");
    }

    @Override
    public Result getAdminDetail(Integer id) {
        // 根据id查询管理员信息
        Admin admin = adminMapper.selectById(id);
        if (admin != null) {
            return Result.success("获取管理员信息成功", admin);
        }
        return Result.error("获取管理员信息失败");
    }
}
