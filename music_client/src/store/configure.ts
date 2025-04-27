export default {
  state: {
    token: false, // 用户是否登录
    showAside: false, // 是否显示侧边栏
    searchWord: "", // 搜索关键词
    searchKeywords: "", // 用于显示在搜索结果页的关键词
    activeNavName: "", // 导航栏名称
  },
  getters: {
    token: (state) => state.token,
    activeNavName: (state) => state.activeNavName,
    showAside: (state) => state.showAside,
    searchWord: (state) => state.searchWord,
    searchKeywords: (state) => state.searchKeywords,
  },
  mutations: {
    setToken: (state, token) => {
      state.token = token;
    },
    setActiveNavName: (state, activeNavName) => {
      state.activeNavName = activeNavName;
    },
    setShowAside: (state, showAside) => {
      state.showAside = showAside;
    },
    setSearchWord: (state, searchWord) => {
      state.searchWord = searchWord;
    },
    setSearchKeywords: (state, searchKeywords) => {
      state.searchKeywords = searchKeywords;
    },
  },
};
