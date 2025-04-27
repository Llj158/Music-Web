package com.example.music.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.music.model.Result;
import com.example.music.mapper.SongMapper;
import com.example.music.model.domain.Song;
import com.example.music.model.request.SongRequest;
import com.example.music.service.SongService;
import com.example.music.utils.OssUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.List;

@Service
public class SongServiceImpl extends ServiceImpl<SongMapper, Song> implements SongService {

    @Autowired
    private SongMapper songMapper;

    
    @Override
    @Cacheable(value = "Song", key = "'allSongs'")
    public Result allSong() {
        System.out.println("未经过缓存");
        return Result.success(null, songMapper.selectList(null));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Result addSong(SongRequest addSongRequest, MultipartFile lrcfile, MultipartFile mpfile, MultipartFile picfile) {
        try {
            Song song = new Song();
            BeanUtils.copyProperties(addSongRequest, song);
            
            // 处理图片文件
            String pic;
            if (picfile != null && !picfile.isEmpty()) {
                pic = OssUtil.uploadSongImage(picfile);
                if (pic.startsWith("Error")) {
                    throw new RuntimeException("图片上传失败");
                }
            } else {
                pic = "/img/songPic/tubiao.jpg";
            }
            
            // 上传音乐文件并获取URL
            String url;
            if (mpfile != null && !mpfile.isEmpty()) {
                url = OssUtil.uploadSongFile(mpfile);
                if (url.startsWith("Error")) {
                    throw new RuntimeException("音乐文件上传失败");
                }
            } else {
                url = "";
            }
            
            song.setCreateTime(new Date());
            song.setUpdateTime(new Date());
            song.setPic(pic);
            song.setUrl(url);

            // 处理歌词：优先使用歌词文件，如果没有则使用手动输入的歌词
            if (!lrcfile.isEmpty()) {
                byte[] fileContent = lrcfile.getBytes();
                String content = new String(fileContent, "UTF-8");
                song.setLyric(content);
            }
            else if (song.getLyric() != null && !song.getLyric().trim().isEmpty()) {
                // 保留手动输入的歌词
            }
            else {
                song.setLyric("[00:00:00]暂无歌词");
            }

            if (songMapper.insert(song) > 0) {
                return Result.success("上传成功", url);
            } else {
                throw new RuntimeException("数据库插入失败");
            }
        } catch (Exception e) {
            throw new RuntimeException("添加歌曲失败: " + e.getMessage());
        }
    }

    @Override
    public Result updateSongMsg(SongRequest updateSongRequest) {
        Song song = new Song();
        BeanUtils.copyProperties(updateSongRequest, song);
        if (songMapper.updateById(song) > 0) {
            return Result.success("修改成功");
        } else {
            return Result.error("修改失败");
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Result updateSongUrl(MultipartFile urlFile, int id) {
        try {
            Song song = songMapper.selectById(id);
            String oldUrl = song.getUrl();
            
            // 如果存在旧文件，则删除
            if (oldUrl != null && !oldUrl.isEmpty()) {
                String objectName = oldUrl.substring(oldUrl.lastIndexOf("/") + 1);
                OssUtil.deleteSongFile(objectName);
            }
            
            // 上传新文件
            String newUrl = OssUtil.uploadSongFile(urlFile);
            if (newUrl.startsWith("Error")) {
                throw new RuntimeException("文件上传失败");
            }
            
            song.setId(id);
            song.setUrl(newUrl);
            
            if (songMapper.updateById(song) > 0) {
                return Result.success("更新成功", newUrl);
            } else {
                throw new RuntimeException("数据库更新失败");
            }
        } catch (Exception e) {
            throw new RuntimeException("更新歌曲失败: " + e.getMessage());
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Result updateSongPic(MultipartFile urlFile, int id) {
        try {
            Song song = songMapper.selectById(id);
            String oldUrl = song.getPic();
            
            // 如果存在旧文件，则删除
            if (oldUrl != null && !oldUrl.isEmpty() && !oldUrl.equals("/img/songPic/tubiao.jpg")) {
                String objectName = oldUrl.substring(oldUrl.lastIndexOf("/") + 1);
                OssUtil.deleteSongImage(objectName);
            }
            
            String url = OssUtil.uploadSongImage(urlFile);
            if (url.startsWith("Error")) {
                throw new RuntimeException("图片上传失败");
            }
            
            song.setId(id);
            song.setPic(url);
            
            if (songMapper.updateById(song) > 0) {
                return Result.success("上传成功", url);
            } else {
                throw new RuntimeException("数据库更新失败");
            }
        } catch (Exception e) {
            throw new RuntimeException("更新图片失败: " + e.getMessage());
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Result deleteSong(Integer id) {
        try {
            Song song = songMapper.selectById(id);
            if (song == null) {
                return Result.error("歌曲不存在");
            }
            
            String url = song.getUrl();
            String pic = song.getPic();
            
            // 删除数据库记录
            if (songMapper.deleteById(id) <= 0) {
                throw new RuntimeException("数据库删除失败");
            }
            
            // 删除文件
            if (url != null && !url.isEmpty()) {
                String objectName = url.substring(url.lastIndexOf("/") + 1);
                OssUtil.deleteSongFile(objectName);
            }
            
            // 删除非默认图片
            if (pic != null && !pic.isEmpty() && !pic.equals("/img/songPic/tubiao.jpg")) {
                String objectName = pic.substring(pic.lastIndexOf("/") + 1);
                OssUtil.deleteSongImage(objectName);
            }
            
            return Result.success("删除成功");
        } catch (Exception e) {
            throw new RuntimeException("删除歌曲失败: " + e.getMessage());
        }
    }

    @Override
    public Result songOfSingerId(Integer singerId) {
        QueryWrapper<Song> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("singer_id", singerId);
        return Result.success(null, songMapper.selectList(queryWrapper));
    }

    @Override
    public Result songOfId(Integer id) {
        QueryWrapper<Song> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("id", id);
        return Result.success(null, songMapper.selectList(queryWrapper));
    }

    @Override
    public Result songOfName(String name) {
        QueryWrapper<Song> queryWrapper = new QueryWrapper<>();
        queryWrapper.like("LOWER(name)", name.toLowerCase());
        List<Song> songs = songMapper.selectList(queryWrapper);
        if (songs.isEmpty()) {
            return Result.error("未找到相关歌曲");
        }
        return Result.success("搜索成功", songs);
    }

    @Override
    public Result songOfSingerName(String name) {
        QueryWrapper<Song> queryWrapper = new QueryWrapper<>();
        queryWrapper.inSql("singer_id", "SELECT id FROM singer WHERE name LIKE '" + name.replace("'", "''") + "'");
        List<Song> songs = songMapper.selectList(queryWrapper);
        if (songs.isEmpty()) {
            return Result.error("未找到该歌手的歌曲");
        }
        return Result.success("搜索成功", songs);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Result updateSongLrc(MultipartFile lrcFile, int id) {
        try {
            Song song = songMapper.selectById(id);
            if (song == null) {
                return Result.error("歌曲不存在");
            }
            
            if (lrcFile != null && !(song.getLyric().equals("[00:00:00]暂无歌词"))) {
                byte[] fileContent = lrcFile.getBytes();
                String content = new String(fileContent, "UTF-8");
                song.setLyric(content);
            }
            
            if (songMapper.updateById(song) > 0) {
                return Result.success("更新成功");
            } else {
                throw new RuntimeException("数据库更新失败");
            }
        } catch (Exception e) {
            throw new RuntimeException("更新歌词失败: " + e.getMessage());
        }
    }
}
