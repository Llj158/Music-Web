package com.example.music.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.music.model.Result;
import com.example.music.model.domain.Song;
import com.example.music.model.request.SongRequest;
import org.springframework.web.multipart.MultipartFile;

public interface SongService extends IService<Song> {

    Result addSong (SongRequest addSongRequest, MultipartFile lrcfile, MultipartFile mpfile, MultipartFile picfile);

    Result updateSongMsg(SongRequest updateSongRequest);

    Result updateSongUrl(MultipartFile urlFile, int id);

    Result updateSongPic(MultipartFile urlFile, int id);

    Result deleteSong(Integer id);

    Result allSong();

    Result songOfSingerId(Integer singerId);

    Result songOfId(Integer id);

    Result songOfName(String name);

    Result updateSongLrc(MultipartFile lrcFile, int id);

    Result songOfSingerName(String s);
}
