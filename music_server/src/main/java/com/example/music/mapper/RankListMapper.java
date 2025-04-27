package com.example.music.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.music.model.domain.ListScoreDTO;
import com.example.music.model.domain.RankList;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RankListMapper extends BaseMapper<RankList> {

    /**
     * 查总分
     * @param songListId
     * @return
     * （舍弃————直接利用sql语句求avg）
     */
    int selectScoreSum(Long songListId);

    /**
     * 查制定用户评分
     * @param consumerId
     * @param songListId
     * @return
     */
    Integer selectUserRank(@Param("consumer_id") Long consumerId, @Param("song_list_id")  Long songListId);

    /**
     * 查询歌单平均分
     * @param songListId
     * @return
     */
    Double selectAvgScore(@Param("songListId") Long songListId);

    /**
     * 查询所有歌单的平均分并按分数降序排序
     * @return 歌单评分列表
     */
    List<ListScoreDTO> selectSongListRankOrder();
}
