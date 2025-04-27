package com.example.music.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.music.model.Result;
import com.example.music.model.domain.RankList;
import com.example.music.model.request.RankListRequest;

public interface RankListService extends IService<RankList> {

    Result addRank(RankListRequest rankListAddRequest);

    Result rankOfSongListId(Long songListId);

    Result getUserRank(Long consumerId, Long songListId);

    /**
     * 更新用户评分
     */
    Result updateRank(RankListRequest rankListRequest);

    /**
     * 获取歌单评分排名
     */
    Result getSongListRankOrder();

}
