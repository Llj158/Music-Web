package com.example.music.model.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import org.apache.commons.lang3.builder.ToStringBuilder;

import java.util.Date;

@TableName(value = "collect")
@Data
public class Collect {
    @TableId(type = IdType.INPUT)
    private Integer id;

    private Integer userId;

    private Byte type;

    private Integer songId;

    @TableField(fill = FieldFill.INSERT)
    private Date createTime;


    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

}
