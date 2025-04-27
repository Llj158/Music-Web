package com.example.music.controller;

import com.example.music.model.Result;
import com.example.music.model.request.UserSupportRequest;
import com.example.music.service.UserSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 用户点赞
 **/
@RestController
@RequestMapping("/userSupport")
public class UserSupportController {

    @Autowired
    UserSupportService userSupportService;

    /**
     * 判断是否点赞
     * @param userSupportRequest
     * @return
     */
    @PostMapping("/test")
    public Result isUserSupportComment(@RequestBody UserSupportRequest userSupportRequest) {
        return userSupportService.isUserSupportComment(userSupportRequest);
    }

    @PostMapping("/insert")
    public Result insertCommentSupport(@RequestBody UserSupportRequest userSupportRequest) {
        return userSupportService.insertCommentSupport(userSupportRequest);
    }

    @PostMapping("/delete")
    public Result deleteCommentSupport(@RequestBody UserSupportRequest userSupportRequest) {
        return userSupportService.deleteCommentSupport(userSupportRequest);
    }
}
