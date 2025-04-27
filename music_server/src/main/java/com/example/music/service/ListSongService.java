package com.example.music.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.music.model.Result;
import com.example.music.model.domain.ListSong;
import com.example.music.model.request.ListSongRequest;

public interface ListSongService extends IService<ListSong> {

    Result addListSong(ListSongRequest addListSongRequest);

    Result updateListSongMsg(ListSongRequest updateListSongRequest);

    Result deleteListSong(Integer songId);


    Result listSongOfSongId(Integer songListId);
}
