package com.example.music.controller;

import com.example.music.model.Result;
import com.example.music.model.request.CommentRequest;
import com.example.music.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/comment")
public class CommentController {
    @Autowired
    private CommentService commentService;


    // 提交评论
    @PostMapping("/add")
    public Result addComment(@RequestBody CommentRequest addCommentRequest) {
        return commentService.addComment(addCommentRequest);
    }

    // 删除评论
    @GetMapping("/delete")
    public Result deleteComment(@RequestParam Integer id) {
        return commentService.deleteComment(id);
    }

    // 获得指定歌曲 ID 的评论列表
    @GetMapping("/song/detail")
    public Result commentOfSongId(@RequestParam Integer songId) {
        return commentService.commentOfSongId(songId);
    }

    // 获得指定歌单 ID 的评论列表
    @GetMapping("/songList/detail")
    public Result commentOfSongListId(@RequestParam Integer songListId) {
        return commentService.commentOfSongListId(songListId);
    }

    // 点赞
    @PostMapping("/like")
    public Result commentOfLike(@RequestBody CommentRequest upCommentRequest) {
        return commentService.updateCommentMsg(upCommentRequest);
    }
}
