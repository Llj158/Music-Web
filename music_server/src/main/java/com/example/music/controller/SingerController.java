package com.example.music.controller;

import com.example.music.model.Result;
import com.example.music.model.request.SingerRequest;
import com.example.music.service.SingerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/singer")
public class SingerController {

    @Autowired
    private SingerService singerService;


    // 添加歌手
    @PostMapping("/add")
    public Result addSinger(@RequestBody SingerRequest addSingerRequest) {
        return singerService.addSinger(addSingerRequest);
    }

    // 删除歌手
    @DeleteMapping("/delete")
    public Result deleteSinger(@RequestParam int id) {
        return singerService.deleteSinger(id);
    }

    // 返回所有歌手
    @GetMapping
    public Result allSinger() {
        return singerService.allSinger();
    }

    // 根据歌手名查找歌手
    @GetMapping("/name/detail")
    public Result singerOfName(@RequestParam String name) {
        return singerService.singerOfName(name);
    }

    // 根据歌手性别查找歌手
    @GetMapping("/sex/detail")
    public Result singerOfSex(@RequestParam int sex) {
        return singerService.singerOfSex(sex);
    }

    // 更新歌手信息
    @PostMapping("/update")
    public Result updateSingerMsg(@RequestBody SingerRequest updateSingerRequest) {
        return singerService.updateSingerMsg(updateSingerRequest);
    }

    // 更新歌手头像
    @PostMapping("/avatar/update")
    public Result updateSingerPic(@RequestParam("file") MultipartFile avatorFile, @RequestParam("id") int id) {
        return singerService.updateSingerPic(avatorFile, id);
    }

    /**
     * 根据歌曲名查找歌手
     */
    @GetMapping("/songName/detail")
    public Result singerOfSongName(@RequestParam String songName) {
        return singerService.singerOfSongName('%' + songName + '%');
    }

    /**
     * 根据歌曲ID查找歌手
     */
    @GetMapping("/songID/detail")
    public Result singerOfId(@RequestParam Integer songId) {
        return singerService.singerOfSongId(songId);
    }


}
