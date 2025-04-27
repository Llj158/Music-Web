package com.example.music.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.music.model.Result;
import com.example.music.model.domain.Collect;
import com.example.music.model.request.CollectRequest;

public interface CollectService extends IService<Collect> {

    Result addCollection(CollectRequest addCollectRequest);

    Result existSongId(CollectRequest isCollectRequest);

    Result deleteCollect(Integer userId, Integer songId);

    Result collectionOfUser(Integer userId);
}
