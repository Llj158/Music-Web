package com.example.music.controller;

import com.example.music.model.Result;
import com.example.music.model.request.RankListRequest;
import com.example.music.service.RankListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/rankList")
public class RankListController {

    @Autowired
    private RankListService rankListService;


    // 提交评分
    @PostMapping("/add")
    public Result addRank(@RequestBody RankListRequest rankListAddRequest) {
        return rankListService.addRank(rankListAddRequest);
    }

    // 获取指定歌单的评分
    @GetMapping
    public Result rankOfSongListId(@RequestParam Long songListId) {
        return rankListService.rankOfSongListId(songListId);
    }

    // 获取指定用户的歌单评分
    @GetMapping("/user")
    public Result getUserRank(@RequestParam(required = false) Long consumerId, @RequestParam Long songListId) {
        Result userRank = rankListService.getUserRank(consumerId, songListId);
        return Result.success("成功",userRank);
    }

        // 获取歌单评分排名
    @GetMapping("/songList/rank")
    public Result getSongListRankOrder() {
        return rankListService.getSongListRankOrder();
    }

}
