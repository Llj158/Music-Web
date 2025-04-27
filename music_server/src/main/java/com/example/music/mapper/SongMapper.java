package com.example.music.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.music.model.domain.Song;
import org.springframework.stereotype.Repository;

@Repository
public interface SongMapper extends BaseMapper<Song> {

}
