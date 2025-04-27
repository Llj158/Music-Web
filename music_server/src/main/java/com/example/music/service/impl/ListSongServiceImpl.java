package com.example.music.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.music.model.Result;
import com.example.music.mapper.ListSongMapper;
import com.example.music.model.domain.ListSong;
import com.example.music.model.request.ListSongRequest;
import com.example.music.service.ListSongService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ListSongServiceImpl extends ServiceImpl<ListSongMapper, ListSong> implements ListSongService {

    @Autowired
    private ListSongMapper listSongMapper;



    @Override
    public Result updateListSongMsg(ListSongRequest updateListSongRequest) {
        ListSong listSong = new ListSong();
        BeanUtils.copyProperties(updateListSongRequest, listSong);
        if (listSongMapper.updateById(listSong) > 0) {
            return Result.success("修改成功");
        } else {
            return Result.error("修改失败");
        }
    }

    @Override
    public Result deleteListSong(Integer songId) {
        QueryWrapper<ListSong> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("song_id",songId);
        if (listSongMapper.delete(queryWrapper) > 0) {
            return Result.success("删除成功");
        } else {
            return Result.error("删除失败");
        }
    }

    @Override
    public Result addListSong(ListSongRequest addListSongRequest) {
        try {
            if (addListSongRequest.getSongId() == null || addListSongRequest.getSongListId() == null) {
                return Result.error("歌曲ID和歌单ID不能为空");
            }

            // 检查是否已存在相同的歌曲
            QueryWrapper<ListSong> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("song_id", addListSongRequest.getSongId())
                       .eq("song_list_id", addListSongRequest.getSongListId());
            
            Long count = listSongMapper.selectCount(queryWrapper);
            if (count > 0) {
                return Result.error("该歌曲已存在于歌单中");
            }

            ListSong listSong = new ListSong();
            BeanUtils.copyProperties(addListSongRequest, listSong);
            
            int rows = listSongMapper.insert(listSong);
            if (rows > 0) {
                return Result.success("添加成功");
            } else {
                return Result.error("添加失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("添加歌曲时发生错误：" + e.getMessage());
        }
    }

    @Override
    public Result listSongOfSongId(Integer songListId) {
        QueryWrapper<ListSong> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("song_list_id",songListId);
        return Result.success("查询成功", listSongMapper.selectList(queryWrapper));
    }

}
