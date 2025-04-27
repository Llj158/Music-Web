package com.example.music.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.music.model.Result;
import com.example.music.mapper.SingerMapper;
import com.example.music.mapper.SongMapper;
import com.example.music.model.domain.Singer;
import com.example.music.model.domain.Song;
import com.example.music.model.request.SingerRequest;
import com.example.music.service.SingerService;
import com.example.music.utils.OssUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class SingerServiceImpl extends ServiceImpl<SingerMapper, Singer> implements SingerService {

    @Autowired
    private SingerMapper singerMapper;
    
    @Autowired
    private SongMapper songMapper;

    @Override
    public Result updateSingerMsg(SingerRequest updateSingerRequest) {
        Singer singer = new Singer();
        BeanUtils.copyProperties(updateSingerRequest, singer);
        if (singerMapper.updateById(singer) > 0) {
            return Result.success("修改成功");
        } else {
            return Result.error("修改失败");
        }
    }

    @Override
    public Result updateSingerPic(MultipartFile avatorFile, int id) {
        Singer singer = singerMapper.selectById(id);
        String oldUrl = singer.getPic();
        
        try {
            // 如果存在旧文件，则删除
            if (oldUrl != null && !oldUrl.isEmpty() && !oldUrl.equals("img/avatorImages/singer.jpg")) {
                String objectName = oldUrl.substring(oldUrl.lastIndexOf("/") + 1);
                OssUtil.deleteSingerImage(objectName);
            }
            
            String url = OssUtil.uploadSingerImage(avatorFile);
            if (url.startsWith("Error")) {
                return Result.error("图片上传失败");
            }
            
            singer.setId(id);
            singer.setPic(url);
            
            if (singerMapper.updateById(singer) > 0) {
                return Result.success("上传成功", url);
            } else {
                return Result.error("上传失败");
            }
        } catch (Exception e) {
            return Result.error("图片处理失败: " + e.getMessage());
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Result deleteSinger(Integer id) {
        try {
            Singer singer = singerMapper.selectById(id);
            if (singer == null) {
                return Result.error("歌手不存在");
            }

            // 获取歌手的头像URL
            String pic = singer.getPic();
            
            // 获取该歌手的所有歌曲
            QueryWrapper<Song> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("singer_id", id);
            List<Song> songs = songMapper.selectList(queryWrapper);

            // 删除数据库记录（会级联删除歌曲）
            if (singerMapper.deleteById(id) <= 0) {
                throw new RuntimeException("删除歌手记录失败");
            }

            // 删除歌曲相关的文件
            for (Song song : songs) {
                // 删除歌曲文件
                if (song.getUrl() != null && !song.getUrl().isEmpty()) {
                    String songObjectName = song.getUrl().substring(song.getUrl().lastIndexOf("/") + 1);
                    OssUtil.deleteSongFile(songObjectName);
                }
                
                // 删除歌曲图片（非默认图片）
                if (song.getPic() != null && !song.getPic().isEmpty() && !song.getPic().equals("img/songPic/tubiao.jpg")) {
                    String picObjectName = song.getPic().substring(song.getPic().lastIndexOf("/") + 1);
                    OssUtil.deleteSongImage(picObjectName);
                }
            }
            

            
            // 删除歌手头像（非默认头像）
            if (pic != null && !pic.isEmpty() && !pic.equals("img/avatorImages/singer.jpg")) {
                String objectName = pic.substring(pic.lastIndexOf("/") + 1);
                OssUtil.deleteSingerImage(objectName);
            }
            
            return Result.success("删除成功");
        } catch (Exception e) {
            throw new RuntimeException("删除歌手失败: " + e.getMessage());
        }
    }

    @Override
    public Result allSinger() {
        return Result.success(null, singerMapper.selectList(null));
    }

    @Override
    public Result addSinger(SingerRequest addSingerRequest) {
        Singer singer = new Singer();
        BeanUtils.copyProperties(addSingerRequest, singer);
        String pic = "img/avatorImages/singer.jpg";
        singer.setPic(pic);
        if (singerMapper.insert(singer) > 0) {
            return Result.success("添加成功");
        } else {
            return Result.error("添加失败");
        }
    }

    @Override
    public Result singerOfName(String name) {
        QueryWrapper<Singer> queryWrapper = new QueryWrapper<>();
        queryWrapper.like("LOWER(name)", name.toLowerCase());
        return Result.success(null, singerMapper.selectList(queryWrapper));
    }

    @Override
    public Result singerOfSex(Integer sex) {
        QueryWrapper<Singer> queryWrapper = new QueryWrapper<>();
        queryWrapper.like("sex", sex);
        return Result.success(null, singerMapper.selectList(queryWrapper));
    }

    @Override
    public Result singerOfSongName(String songName) {
        QueryWrapper<Singer> queryWrapper = new QueryWrapper<>();
        queryWrapper.inSql("id", "SELECT singer_id FROM song WHERE name LIKE '" + songName.replace("'", "''") + "'");
        return Result.success(null, singerMapper.selectList(queryWrapper));
    }

    
    @Override
    public Result singerOfSongId(Integer id) {
        QueryWrapper<Singer> queryWrapper = new QueryWrapper<>();
        queryWrapper.inSql("id", "SELECT singer_id FROM song WHERE id = " + id);
        return Result.success(null, singerMapper.selectList(queryWrapper));
    }
}
