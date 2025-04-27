package com.example.music.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.music.model.Result;
import com.example.music.model.domain.UserSupport;
import com.example.music.model.request.UserSupportRequest;


public interface UserSupportService extends IService<UserSupport> {

    Result isUserSupportComment(UserSupportRequest userSupportRequest);

    Result insertCommentSupport(UserSupportRequest userSupportRequest);

    Result deleteCommentSupport(UserSupportRequest userSupportRequest);
}
