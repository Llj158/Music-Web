package com.example.music.model.request;

import lombok.Data;

import java.util.Date;


@Data
public class CollectRequest {
    private Integer id;

    private Integer userId;

    private Byte type;

    private Integer songId;

    private Date createTime;
}
