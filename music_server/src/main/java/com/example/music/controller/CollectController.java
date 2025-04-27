package com.example.music.controller;

import com.example.music.model.Result;
import com.example.music.model.request.CollectRequest;
import com.example.music.service.CollectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/collection")
public class CollectController {

    @Autowired
    private CollectService collectService;


    // 添加收藏的歌曲
    @PostMapping("/add")
    public Result addCollection(@RequestBody CollectRequest addCollectRequest) {
        return collectService.addCollection(addCollectRequest);
    }

    // 取消收藏的歌曲
    @DeleteMapping("/delete")
    public Result deleteCollection(@RequestParam Integer userId, @RequestParam Integer songId) {
        return collectService.deleteCollect(userId, songId);
    }

    // 是否收藏歌曲
    @PostMapping("/status")
    public Result isCollection(@RequestBody CollectRequest isCollectRequest) {
        return collectService.existSongId(isCollectRequest);

    }

    // 返回的指定用户 ID 收藏的列表
    @GetMapping("/detail")
    public Result collectionOfUser(@RequestParam Integer userId) {
        return collectService.collectionOfUser(userId);
    }
}
