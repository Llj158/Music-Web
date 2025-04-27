package com.example.music.utils;

import com.aliyun.oss.OSS;
import com.aliyun.oss.model.OSSObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

@Component
public class OssUtil {

    private static OSS ossClient;
    private static String endpoint;
    private static String bucketName;

    @Autowired
    public void setOssClient(OSS ossClient) {
        OssUtil.ossClient = ossClient;
    }

    @Value("${aliyun.oss.endpoint}")
    public void setEndpoint(String endpoint) {
        OssUtil.endpoint = endpoint;
    }

    @Value("${aliyun.oss.bucket-name}")
    public void setBucketName(String bucketName) {
        OssUtil.bucketName = bucketName;
    }

    /**
     * 生成带UUID的文件名，防止文件覆盖
     */
    private static String generateFileName(String originalFilename) {
        String suffix = originalFilename.substring(originalFilename.lastIndexOf("."));
        return UUID.randomUUID().toString() + suffix;
    }

    /**
     * 获取文件访问URL
     */
    private static String getFileUrl(String objectName) {
        return endpoint.split("//")[0] + "//" + bucketName + "." + endpoint.split("//")[1] + "/" + objectName;
    }

    /**
     * 上传文件到OSS并返回访问URL
     */
    public static String uploadFile(MultipartFile file, String directory) {
        try {
            String fileName = generateFileName(file.getOriginalFilename());
            String objectName = directory + fileName;
            
            InputStream inputStream = file.getInputStream();
            ossClient.putObject(bucketName, objectName, inputStream);
            
            return getFileUrl(objectName);
        } catch (Exception e) {
            e.printStackTrace();
            return "Error uploading file to OSS: " + e.getMessage();
        }
    }

    /**
     * 从OSS下载文件
     */
    public static byte[] downloadFile(String objectName) throws IOException {
        try {
            // 获取文件流
            OSSObject ossObject = ossClient.getObject(bucketName, objectName);
            InputStream inputStream = ossObject.getObjectContent();

            // 读取文件内容
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }

            // 关闭流
            inputStream.close();
            outputStream.close();

            return outputStream.toByteArray();
        } catch (Exception e) {
            throw new IOException("从OSS下载文件失败: " + e.getMessage(), e);
        }
    }

    /**
     * 删除OSS中的文件
     */
    /**
     * 删除普通文件
     */
    public static void deleteSongFile(String fileName) {
        try {
            ossClient.deleteObject(bucketName, "song/" + fileName);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("删除OSS文件失败: " + e.getMessage());
        }
    }

    /**
     * 删除歌手图片
     */
    public static void deleteSingerImage(String fileName) {
        try {
            ossClient.deleteObject(bucketName, "singer/" + fileName);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("删除OSS文件失败: " + e.getMessage());
        }
    }

    /**
     * 删除歌单图片
     */
    public static void deleteSongListImage(String fileName) {
        try {
            ossClient.deleteObject(bucketName, "songlist/" + fileName);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("删除OSS文件失败: " + e.getMessage());
        }
    }

    /**
     * 删除歌曲图片
     */
    public static void deleteSongImage(String fileName) {
        try {
            ossClient.deleteObject(bucketName, "song/img/" + fileName);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("删除OSS文件失败: " + e.getMessage());
        }
    }

    /**
     * 删除头像
     */
    public static void deleteAvatar(String fileName) {
        try {
            ossClient.deleteObject(bucketName, "avatorImages/" + fileName);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("删除OSS文件失败: " + e.getMessage());
        }
    }

    /**
     * 删除任意路径文件(兼容旧代码)
     */
    public static void deleteFile(String objectName) {
        try {
            ossClient.deleteObject(bucketName, objectName);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("删除OSS文件失败: " + e.getMessage());
        }
    }

    /**
     * 上传普通文件
     */
    public static String uploadSongFile(MultipartFile file) {
        return uploadFile(file, "song/");
    }

    /**
     * 上传歌手图片
     */
    public static String uploadSingerImage(MultipartFile file) {
        return uploadFile(file, "singer/");
    }

    /**
     * 上传歌单图片
     */
    public static String uploadSongListImage(MultipartFile file) {
        return uploadFile(file, "songlist/");
    }

    /**
     * 上传歌曲图片
     */
    public static String uploadSongImage(MultipartFile file) {
        return uploadFile(file, "song/img/");
    }

    /**
     * 上传头像
     */
    public static String uploadAvatar(MultipartFile file) {
        return uploadFile(file, "avatorImages/");
    }
} 