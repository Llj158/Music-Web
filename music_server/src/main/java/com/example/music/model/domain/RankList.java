package com.example.music.model.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

@TableName(value = "rank_list")
@Data
public class RankList implements Serializable {

    @TableId(type = IdType.INPUT)
    private Integer id;

    private Long songListId;

    private Long consumerId;

    private Integer score;

}
