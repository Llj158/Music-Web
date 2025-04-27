// 解析日期
export function getBirth(value) {
  if (value == null || value == "") return "";
  const date = new Date(value);
  const year = date.getFullYear();
  const month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
  const day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
  return year + "-" + month + "-" + day;
}

/**
 * 表格时间格式化
 */
export function formatDate(cellValue) {
  if (cellValue == null || cellValue == "") return "";
  const date = new Date(cellValue);
  const year = date.getFullYear();
  const month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
  const day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
  const hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
  const minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
  const seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
  return year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;
}

// 解析歌词
export function parseLyric(text) {
  if (!text) return [];
  let lines = text.split("\n");
  const pattern = /\[\d{2}:\d{2}.(\d{3}|\d{2})\]/g;
  const result = [];

  // 对于歌词格式不对的特殊处理
  if (!/\[.+\]/.test(text)) {
    return [[0, text]];
  }

  while (!pattern.test(lines[0])) {
    lines = lines.slice(1);
  }

  lines[lines.length - 1].length === 0 && lines.pop();
  for (const item of lines) {
    const time = item.match(pattern); // 存前面的时间段
    const value = item.replace(pattern, "").trim(); // 存歌词并去除首尾空格
    if (!value) continue; // 跳过空行

    // 检查是否包含中英文混合
    const hasEnglish = /[a-zA-Z]/.test(value);
    const hasChinese = /[\u4e00-\u9fa5]/.test(value);

    if (hasEnglish && hasChinese) {
      // 将英文和中文部分分开
      // 使用正则表达式匹配连续的英文或数字，以及连续的中文
      const parts = value.match(/[a-zA-Z0-9][a-zA-Z0-9\s\-.,!?'":;]*|[\u4e00-\u9fa5]+/g) || [value];

      // 分离英文和中文部分
      const englishParts = parts.filter(part => /[a-zA-Z]/.test(part));
      const chineseParts = parts.filter(part => /[\u4e00-\u9fa5]/.test(part));

      // 为每个部分添加时间戳
      for (const item1 of time) {
        const t = item1.slice(1, -1).split(":");
        const timeValue = parseInt(t[0], 10) * 60 + parseFloat(t[1]);

        // 先添加英文部分（主歌词）
        englishParts.forEach((part, index) => {
          result.push([timeValue, part.trim(), 'original']); // 标记为原始歌词
        });

        // 再添加中文部分（翻译）
        chineseParts.forEach((part, index) => {
          result.push([timeValue + 0.5, part.trim(), 'translation']); // 标记为翻译歌词，时间戳加0.5秒
        });
      }
    } else {
      for (const item1 of time) {
        const t = item1.slice(1, -1).split(":");
        if (value !== "") {
          // 根据内容类型标记
          const type = /[a-zA-Z]/.test(value) ? 'original' : 'translation';
          result.push([parseInt(t[0], 10) * 60 + parseFloat(t[1]), value, type]);
        }
      }
    }
  }
  result.sort((a, b) => a[0] - b[0]);
  return result;
}

// 解析播放时间
export function formatSeconds(value: number): string {
  let theTime = Math.floor(value);
  let theTime1 = 0;
  let theTime2 = 0;
  if (theTime > 60) {
    theTime1 = Math.floor(theTime / 60);
    theTime = Math.floor(theTime % 60);
    if (theTime1 > 60) {
      theTime2 = Math.floor(theTime1 / 60);
      theTime1 = Math.floor(theTime1 % 60);
    }
  }
  let result = (theTime < 10 ? "0" : "") + theTime;
  if (theTime1 > 0) {
    result = (theTime1 < 10 ? "0" : "") + theTime1 + ":" + result;
  } else {
    result = "00:" + result;
  }
  if (theTime2 > 0) {
    result = (theTime2 < 10 ? "0" : "") + theTime2 + ":" + result;
  }
  return result;
}

/**
 * 滚动到页面顶部
 * @param smooth 是否使用平滑滚动
 */
export function scrollToTop(smooth = true) {
  if (smooth) {
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  } else {
    window.scrollTo(0, 0);
  }
}

