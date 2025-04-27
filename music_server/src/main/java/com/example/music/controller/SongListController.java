package com.example.music.controller;

import com.example.music.model.Result;
import com.example.music.model.request.SongListRequest;
import com.example.music.service.SongListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@RestController
public class SongListController {

    @Autowired
    private SongListService songListService;


    // 添加歌单
    @PostMapping("/songList/add")
    public Result addSongList(@RequestBody SongListRequest addSongListRequest) {
        return songListService.addSongList(addSongListRequest);
    }

    // 删除歌单
    @GetMapping("/songList/delete")
    public Result deleteSongList(@RequestParam int id) {
        return songListService.deleteSongList(id);
    }


    // 返回所有歌单
    @GetMapping("/songList")
    public Result allSongList() {
        return songListService.allSongList();
    }

    // 返回标题包含文字的歌单
    @GetMapping("/songList/likeTitle/detail")
    public Result songListOfLikeTitle(@RequestParam String title) {
        return songListService.likeTitle('%' + title + '%');
    }

    // 返回指定类型的歌单
    @GetMapping("/songList/style/detail")
    public Result songListOfStyle(@RequestParam String style) {
        return songListService.likeStyle('%' + style + '%');
    }

    // 更新歌单信息
    @PostMapping("/songList/update")
    public Result updateSongListMsg(@RequestBody SongListRequest updateSongListRequest) {
        return songListService.updateSongListMsg(updateSongListRequest);

    }

    // 更新歌单图片
    @PostMapping("/songList/img/update")
    public Result updateSongListPic(@RequestParam("file") MultipartFile avatorFile, @RequestParam("id") int id) {

        return songListService.updateSongListImg(avatorFile,id);
    }


    //导出歌单
    @GetMapping("/excle")
    public ResponseEntity<Resource> getExcle(HttpServletRequest request) throws IOException {
        return songListService.exportSongListExcel();
    }
}
