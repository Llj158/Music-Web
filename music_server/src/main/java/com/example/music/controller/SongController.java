package com.example.music.controller;

import com.example.music.model.Result;
import com.example.music.model.request.SongRequest;
import com.example.music.service.SongService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/song")
public class SongController {

    @Autowired
    private SongService songService;

    // 添加歌曲
    @PostMapping("/add")
    public Result addSong(SongRequest addSongRequest, @RequestParam("lrcfile") MultipartFile lrcfile, @RequestParam("file") MultipartFile mpfile, @RequestParam(value = "picfile", required = false) MultipartFile picfile) {
        return songService.addSong(addSongRequest, lrcfile, mpfile, picfile);
    }

    // 删除歌曲
    @DeleteMapping("/delete")
    public Result deleteSong(@RequestParam int id) {
        return songService.deleteSong(id);
    }

    // 返回所有歌曲
    @GetMapping
    public Result allSong() {
        return songService.allSong();
    }

    // 返回指定歌曲ID的歌曲
    @GetMapping("/detail")
    public Result songOfId(@RequestParam int id) {
        return songService.songOfId(id);
    }

    // 返回指定歌手ID的歌曲
    @GetMapping("/singer/detail")
    public Result songOfSingerId(@RequestParam int singerId) {
        return songService.songOfSingerId(singerId);
    }


    // 返回指定歌手名的歌曲
    @GetMapping("/singerName/detail")
    public Result songOfSingerName(@RequestParam String name) {
        return songService.songOfSingerName('%' + name + '%');
    }

    // 返回指定歌曲名的歌曲
    @GetMapping("/name/detail")
    public Result songOfName(@RequestParam String name) {
        return songService.songOfName('%' + name + '%');
    }

    // 更新歌曲信息
    @PostMapping("/update")
    public Result updateSongMsg(@RequestBody SongRequest updateSongRequest) {
        return songService.updateSongMsg(updateSongRequest);
    }

    // 更新歌曲图片
    @PostMapping("/img/update")
    public Result updateSongPic(@RequestParam("file") MultipartFile urlFile, @RequestParam("id") int id) {
        return songService.updateSongPic(urlFile, id);
    }

    // 更新歌曲
    @PostMapping("/url/update")
    public Result updateSongUrl(@RequestParam("file") MultipartFile urlFile, @RequestParam("id") int id) {
        return songService.updateSongUrl(urlFile, id);
    }


    //更新歌词
    @PostMapping("/lrc/update")
    public Result updateSongLrc(@RequestParam("file") MultipartFile lrcFile, @RequestParam("id") int id) {
        return songService.updateSongLrc(lrcFile, id);
    }

}
