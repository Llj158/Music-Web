import { deletes, get, getBaseURL, post } from './request'

const HttpManager = {
    // 获取图片信息
    attachImageUrl: (url) => {
        if (!url) return "https://cube.elemecdn.com/e/fd/0fc7d20532fdaf769a25683617711png.png";
        if (url.startsWith('http')) return url;
        // 处理OSS路径
        return `${getBaseURL()}/${url}`;
    },
    // =======================> 管理员 API 完成
    // 是否登录成功
    getLoginStatus: ({ username, password }) => post(`admin/login/status`, { username, password }),
    // 获取管理员信息
    getAdminOfId: (id) => get(`admin/detail?id=${id}`),

    // =======================> 用户 API 完成
    // 返回所有用户
    getAllUser: () => get(`user`),
    // 返回指定ID的用户
    getUserOfId: (id) => get(`user/detail?id=${id}`),
    // 删除用户
    deleteUser: (id) => get(`user/delete?id=${id}`),
    // 更新用户头像
    updateUserAvatar: (formData) => {
        const config = {
            headers: {
                'Content-Type': 'multipart/form-data'
            }
        };
        return post(`user/avatar/update`, formData, config);
    },
    // =======================> 收藏列表 API 完成
    // 返回的指定用户ID收藏列表
    getCollectionOfUser: (userId) => get(`collection/detail?userId=${userId}`),
    // 删除收藏的歌曲
    deleteCollection: (userId, songId) => deletes(`collection/delete?userId=${userId}&&songId=${songId}`),

    // =======================> 评论列表 API 完成
    // 获得指定歌曲ID的评论列表
    getCommentOfSongId: (songId) => get(`comment/song/detail?songId=${songId}`),
    // 获得指定歌单ID的评论列表
    getCommentOfSongListId: (songListId) => get(`comment/songList/detail?songListId=${songListId}`),
    // 删除评论
    deleteComment: (id) => get(`comment/delete?id=${id}`),

    // =======================> 歌手 API 完成
    // 返回所有歌手
    getAllSinger: () => get(`singer`),
    // 添加歌手
    setSinger: ({ name, sex, birth, location, introduction }) => post(`singer/add`, {
        name,
        sex,
        birth,
        location,
        introduction
    }),
    // 更新歌手信息
    updateSingerMsg: ({ id, name, sex, birth, location, introduction }) => post(`singer/update`, {
        id,
        name,
        sex,
        birth,
        location,
        introduction
    }),
    // 删除歌手
    deleteSinger: (id) => deletes(`singer/delete?id=${id}`),

    // =======================> 歌曲 API  完成
    // 返回所有歌曲
    getAllSong: () => get(`song`),
    // 返回指定歌手ID的歌曲
    getSongOfSingerId: (id) => get(`song/singer/detail?singerId=${id}`),
    // 根据歌曲ID查找歌手
    getSingerOfSongId: (songId) => get(`singer/songID/detail?songId=${songId}`),
    // 根据歌曲名查找歌手
    getSingerOfSongName: (songName) => get(`singer/songName/detail?songName=${songName}`),
    // 返回的指定用户ID收藏列表
    getSongOfId: (id) => get(`song/detail?id=${id}`),
    // 返回指定歌手名的歌曲
    getSongOfSingerName: (name) => get(`song/singerName/detail?name=${name}`),
    // 返回指定歌曲名的歌曲
    getSongOfName: (keywords) => get(`song/name/detail?name=${keywords}`),
    // 更新歌曲信息
    updateSongMsg: ({ id, singerId, name, introduction, lyric }) => post(`song/update`, {
        id,
        singerId,
        name,
        introduction,
        lyric
    }),
    updateSongUrl: (id) => `${getBaseURL()}/song/url/update?id=${id}`,
    updateSongImg: (id) => `${getBaseURL()}/song/img/update?id=${id}`,
    updateSongLrc: (id) => `${getBaseURL()}/song/lrc/update?id=${id}`,
    // 删除歌曲
    deleteSong: (id) => deletes(`song/delete?id=${id}`),

    // =======================> 歌单 API 完成
    // 添加歌单t
    setSongList: ({ title, introduction, style }) => post(`songList/add`, { title, introduction, style }),
    // 获取全部歌单
    getSongList: () => get(`songList`),
    // 更新歌单信息
    updateSongListMsg: ({ id, title, introduction, style }) => post(`songList/update`, { id, title, introduction, style }),
    // 删除歌单
    deleteSongList: (id) => get(`songList/delete?id=${id}`),

    // =======================> 歌单歌曲 API 完成
    // 给歌单添加歌曲
    setListSong: ({ songId, songListId }) => post(`listSong/add`, { songId, songListId }),
    // 返回歌单里指定歌单ID的歌曲
    getListSongOfSongId: (songListId) => get(`listSong/detail?songListId=${songListId}`),
    // 删除歌单里的歌曲
    deleteListSong: (songId) => get(`listSong/delete?songId=${songId}`),

    // =======================> 歌单评分 API
    // 获取歌单评分排名
    getSongListRankOrder: () => get(`rankList/songList/rank`)
}

export { HttpManager }
