package com.example.music.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.music.service.CommentService;
import com.example.music.model.Result;
import com.example.music.mapper.CommentMapper;
import com.example.music.model.domain.Comment;
import com.example.music.model.request.CommentRequest;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements CommentService {
    @Autowired
    private CommentMapper commentMapper;

    @Override
    public Result addComment(CommentRequest addCommentRequest) {
        Comment comment = new Comment();
        BeanUtils.copyProperties(addCommentRequest, comment);
        comment.setType(addCommentRequest.getNowType());
        if (commentMapper.insert(comment) > 0) {
            return Result.success("评论成功");
        } else {
            return Result.error("评论失败");
        }
    }

    /**
     *
     * @param addCommentRequest
     * @return
     */
    @Override
    public Result updateCommentMsg(CommentRequest addCommentRequest) {
        Comment comment = new Comment();
        BeanUtils.copyProperties(addCommentRequest, comment);
        if (commentMapper.updateById(comment) > 0) {
            return Result.success("点赞成功");
        } else {
            return Result.error("点赞失败");
        }
    }

    //    删除评论
    @Override
    public Result deleteComment(Integer id) {
        if (commentMapper.deleteById(id) > 0) {
            return Result.success("删除成功");
        } else {
            return Result.error("删除失败");
        }
    }

    @Override
    public Result commentOfSongId(Integer songId) {
        QueryWrapper<Comment> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("song_id",songId);
        return Result.success(null, commentMapper.selectList(queryWrapper));
    }

    @Override
    public Result commentOfSongListId(Integer songListId) {
        QueryWrapper<Comment> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("song_list_id",songListId);
        return Result.success(null, commentMapper.selectList(queryWrapper));
    }
}
