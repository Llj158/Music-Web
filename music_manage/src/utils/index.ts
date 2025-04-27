// 解析日期
export function getBirth(cellValue) {
  if (cellValue == null || cellValue == "") return "";
  const date = new Date(cellValue);
  const year = date.getFullYear();
  const month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
  const day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
  return year + "-" + month + "-" + day;
}

// 解析歌词
export function parseLyric(text) {
  if (!text) return [];
  const lines = text.split("\n");
  const pattern = /\[\d{2}:\d{2}.(\d{3}|\d{2})\]/g;
  const result = [];

  // 对于歌词格式不对的特殊处理
  if (!/\[.+\]/.test(text)) {
    // 检查是否包含中英文混合
    const lines = text.split("\n");
    return lines.reduce((acc, line) => {
      // 检查一行中是否同时包含英文和中文
      const hasEnglish = /[a-zA-Z]/.test(line);
      const hasChinese = /[\u4e00-\u9fa5]/.test(line);

      if (hasEnglish && hasChinese) {
        // 将英文和中文部分分开
        // 使用正则表达式匹配连续的英文或数字，以及连续的中文
        const parts = line.match(/[a-zA-Z0-9][a-zA-Z0-9\s]*|[\u4e00-\u9fa5]+/g) || [line];
        // 去除空白项并添加到结果中
        parts.filter(part => part.trim()).forEach(part => acc.push(part.trim()));
      } else {
        acc.push(line);
      }
      return acc;
    }, []);
  }

  // 处理带时间标记的LRC歌词
  for (const item of lines) {
    if (pattern.test(item)) {
      const value = item.replace(pattern, "").trim(); // 存歌词并去除首尾空格
      if (!value) continue; // 跳过空行

      // 检查是否包含中英文混合
      const hasEnglish = /[a-zA-Z]/.test(value);
      const hasChinese = /[\u4e00-\u9fa5]/.test(value);

      if (hasEnglish && hasChinese) {
        // 将英文和中文部分分开
        // 使用正则表达式匹配连续的英文或数字，以及连续的中文
        const parts = value.match(/[a-zA-Z0-9][a-zA-Z0-9\s]*|[\u4e00-\u9fa5]+/g) || [value];
        // 去除空白项并添加到结果中
        parts.filter(part => part.trim()).forEach(part => result.push(part.trim()));
      } else {
        result.push(value);
      }
    }
  }
  return result;
}
