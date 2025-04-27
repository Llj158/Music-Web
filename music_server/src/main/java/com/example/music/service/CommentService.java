package com.example.music.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.music.model.Result;
import com.example.music.model.domain.Comment;
import com.example.music.model.request.CommentRequest;

public interface CommentService extends IService<Comment> {

    Result addComment(CommentRequest addCommentRequest);

    Result updateCommentMsg(CommentRequest upCommentRequest);

    Result deleteComment(Integer id);

    Result commentOfSongId(Integer songId);

    Result commentOfSongListId(Integer songListId);

}
