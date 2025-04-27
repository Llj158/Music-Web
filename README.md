
# Music-Web 音乐网站

一个基于Vue + SpringBoot的音乐网站项目，包含用户端和管理端。

## 项目介绍

本项目是一个在线音乐播放平台，采用前后端分离架构：
- 前端：Vue.js + TypeScript + Element UI
- 后端：Spring Boot + MyBatis Plus + MySQL
- 文件存储：阿里云OSS
- 缓存：Redis



### 后端启动
1. 创建MySQL/Oracle数据库并导入sql文件


2. 修改application.yml配置
```yaml
spring:
  datasource:
    # Oracle数据库连接URL
    url: jdbc:oracle:thin:@localhost:1521:orcl?characterEncoding=UTF-8&serverTimezone=Asia/Shanghai
    # 数据库用户名
    username: music_db
    # 数据库密码
    password: 123456
    # Oracle数据库驱动类
    driver-class-name: oracle.jdbc.OracleDriver

# 阿里云OSS配置
aliyun:
  oss:
    # OSS服务地址
    endpoint: 
    # 访问密钥ID
    access-key-id: 
    # 访问密钥密码
    access-key-secret: 
    # OSS存储桶名称
    bucket-name: 

# 邮件服务配置
mail:
  # 邮件服务器地址
  host: smtp.163.com
  # 邮件服务器端口
  port: 465
  # 发件人邮箱
  username: 发送方邮箱
  # 邮箱授权码
  password: 邮箱的授权码
```



3. 启动项目
```bash
cd music_server
mvn spring-boot:run
```

### 前端启动
1. 安装依赖
```bash
# 用户端
cd music_client
npm install

# 管理端
cd music_manage
npm install
```

2. 启动开发服务器
```bash
# 用户端
npm run serve

# 管理端
npm run serve
```

## 部署说明

### 后端部署
1. 打包
```bash
mvn clean package
```

2. 运行
```bash
java -jar music_server.jar
```

### 前端部署
1. 构建
```bash
npm run build
```

2. 将dist目录下的文件部署到Web服务器

## 配置说明

### 必要配置
1. 数据库配置（application.yml）
2. Redis配置
3. 阿里云OSS配置
4. 邮箱服务配置

### 可选配置
1. 跨域配置
2. JWT密钥配置
3. 文件上传限制

## 常见问题

1. 数据库连接失败
- 检查数据库服务是否启动
- 验证用户名密码是否正确

2. 文件上传失败
- 检查OSS配置是否正确
- 确认文件大小是否超出限制
