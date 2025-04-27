package com.example.music.service.impl;

import com.alibaba.excel.EasyExcel;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.music.model.Result;
import com.example.music.mapper.SongListMapper;
import com.example.music.model.domain.SongList;
import com.example.music.model.request.SongListRequest;
import com.example.music.service.SongListService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import com.example.music.utils.OssUtil;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

@Service
public class SongListServiceImpl extends ServiceImpl<SongListMapper, SongList> implements SongListService {

    @Autowired
    private SongListMapper songListMapper;

    @Override
    public Result updateSongListMsg(SongListRequest updateSongListRequest) {
        SongList songList = new SongList();
        BeanUtils.copyProperties(updateSongListRequest, songList);
        if (songListMapper.updateById(songList) > 0) {
            return Result.success("修改成功");
        } else {
            return Result.error("修改失败");
        }
    }

    @Override
    public Result deleteSongList(Integer id) {
        try {
            SongList songList = songListMapper.selectById(id);
            if (songList == null) {
                return Result.error("歌单不存在");
            }

            String pic = songList.getPic();
            
            // 删除数据库记录
            if (songListMapper.deleteById(id) <= 0) {
                return Result.error("删除失败");
            }
            
            // 删除非默认封面
            if (pic != null && !pic.isEmpty() && !pic.equals("img/songListPic/songList.jpg")) {
                String objectName = pic.substring(pic.lastIndexOf("/") + 1);
                OssUtil.deleteSongListImage(objectName);
            }
            
            return Result.success("删除成功");
        } catch (Exception e) {
            return Result.error("删除失败: " + e.getMessage());
        }
    }


    @Cacheable(value = "songList", key = "'list'")
    @Override
    public Result allSongList() {
        System.out.println("未经过缓存");
        return Result.success(null, songListMapper.selectList(null));
    }


    @Override
    public Result likeTitle(String title) {
        QueryWrapper<SongList> queryWrapper = new QueryWrapper<>();
        queryWrapper.like("LOWER(title)",title.toLowerCase());
        return Result.success(null, songListMapper.selectList(queryWrapper));
    }

    @Override
    public Result likeStyle(String style) {
        QueryWrapper<SongList> queryWrapper = new QueryWrapper<>();
        queryWrapper.like("style",style);
        return Result.success(null, songListMapper.selectList(queryWrapper));
    }

    @Override
    public Result addSongList(SongListRequest addSongListRequest) {
        SongList songList = new SongList();
        BeanUtils.copyProperties(addSongListRequest, songList);
        String pic = "img/songListPic/songList.jpg";
        songList.setPic(pic);
        if (songListMapper.insert(songList) > 0) {
            return Result.success("添加成功");
        } else {
            return Result.error("添加失败");
        }
    }

    @Override
    public Result updateSongListImg(MultipartFile avatorFile, @RequestParam("id") int id) {
        SongList songList = songListMapper.selectById(id);
        String oldUrl = songList.getPic();
        
        try {
            // 如果存在旧文件，则删除
            if (oldUrl != null && !oldUrl.isEmpty() && !oldUrl.equals("img/songListPic/songList.jpg")) {
                String objectName = oldUrl.substring(oldUrl.lastIndexOf("/") + 1);
                OssUtil.deleteSongListImage(objectName);
            }
            
            String url = OssUtil.uploadSongListImage(avatorFile);
            if (url.startsWith("Error")) {
                return Result.error("图片上传失败");
            }
            
            songList.setId(id);
            songList.setPic(url);
            
            if (songListMapper.updateById(songList) > 0) {
                return Result.success("上传成功", url);
            } else {
                return Result.error("上传失败");
            }
        } catch (Exception e) {
            return Result.error("图片处理失败: " + e.getMessage());
        }
    }

    @Override
    public ResponseEntity<Resource> exportSongListExcel() throws IOException {
        String fileName = "SongList" + System.currentTimeMillis() + ".xlsx";
        List<SongList> songLists = (List<SongList>) allSongList().getData();
        
        EasyExcel.write(fileName, SongList.class)
                .sheet("模板")
                .doWrite(songLists);
                
        File file = new File(fileName);
        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + fileName);
        
        byte[] content = Files.readAllBytes(file.toPath());
        InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
        
        return ResponseEntity.ok()
                .headers(headers)
                .contentLength(content.length)
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .body(resource);
    }
}
