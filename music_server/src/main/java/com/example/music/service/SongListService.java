package com.example.music.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.music.model.Result;
import com.example.music.model.domain.SongList;
import com.example.music.model.request.SongListRequest;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface SongListService extends IService<SongList> {

    Result addSongList(SongListRequest addSongListRequest);

    Result updateSongListMsg(SongListRequest updateSongListRequest);

    Result updateSongListImg(MultipartFile avatorFile, int id);

    Result deleteSongList(Integer id);

    Result allSongList();

    Result likeTitle(String title);

    Result likeStyle(String style);

    ResponseEntity<Resource> exportSongListExcel() throws IOException;
}
