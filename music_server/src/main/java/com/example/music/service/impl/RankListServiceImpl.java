package com.example.music.service.impl;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.music.model.Result;
import com.example.music.mapper.RankListMapper;
import com.example.music.model.domain.ListScoreDTO;
import com.example.music.model.domain.RankList;
import com.example.music.model.request.RankListRequest;
import com.example.music.service.RankListService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RankListServiceImpl extends ServiceImpl<RankListMapper, RankList> implements RankListService {


    @Autowired
    private RankListMapper rankMapper;

    @Override
    public Result addRank(RankListRequest rankListAddRequest) {
        RankList rankList = new RankList();
        BeanUtils.copyProperties(rankListAddRequest, rankList);
        // 先查询用户是否已经评分
        Integer userRank = rankMapper.selectUserRank(rankList.getConsumerId(), rankList.getSongListId());
        if (userRank != null) {
            // 已经评分，执行更新
            return updateRank(rankListAddRequest);
        }
        // 未评分，执行新增
        if (rankMapper.insert(rankList) > 0) {
            return Result.success("评价成功");
        } else {
            return Result.error("评价失败");
        }
    }

    @Override
    public Result rankOfSongListId(Long songListId) {
        // 直接获取平均分，避免两次查询
        Double avgScore = rankMapper.selectAvgScore(songListId);
        return Result.success(null, avgScore);
    }

    @Override
    public Result getUserRank(Long consumerId, Long songListId) {
        Integer score = rankMapper.selectUserRank(consumerId, songListId);
        return Result.success(null, score);
    }

    @Override
    public Result updateRank(RankListRequest rankListRequest) {
        // 使用UpdateWrapper构建更新条件
        UpdateWrapper<RankList> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("consumer_id", rankListRequest.getConsumerId())
                    .eq("song_list_id", rankListRequest.getSongListId());
        
        // 创建要更新的实体
        RankList rankList = new RankList();
        rankList.setScore(rankListRequest.getScore());
        rankList.setConsumerId(rankListRequest.getConsumerId());
        rankList.setSongListId(rankListRequest.getSongListId());
        
        if (rankMapper.update(rankList, updateWrapper) > 0) {
            return Result.success("评价成功");
        } else {
            return Result.error("评价失败");
        }
    }

    @Override
    public Result getSongListRankOrder() {
        List<ListScoreDTO> rankOrder = rankMapper.selectSongListRankOrder();
        return Result.success(null,rankOrder);
    }
}
