package com.example.music.model.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

@TableName(value = "user_support")
@Data
public class UserSupport implements Serializable {

    @TableId(type = IdType.INPUT)
    private Integer id;

    private Integer commentId;

    private Integer userId;

    private static final long serialVersionUID = 1L;

}