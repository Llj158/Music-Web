package com.example.music;

import com.example.music.service.impl.ConsumerServiceImpl;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class MusicApplicationTests {

    @Autowired

    private ConsumerServiceImpl consumerService;

    //@Test
    /*public void imgLoads() throws IOException {
        String filePath = "E:\\Java_web\\music_web\\avatorImages\\1556202365654tou.jpg";
        

        // 不能直接将FileInputStream转换为MultipartFile
        // 需要使用MockMultipartFile来包装FileInputStream
        File file = new File(filePath);
        FileInputStream fileInputStream = new FileInputStream(file);
        MultipartFile multipartFile = new MockMultipartFile(
            "file", 
            file.getName(),
            "image/jpeg",
            IOUtils.toByteArray(fileInputStream)
        );
        OssUtil.uploadAvatar(multipartFile);
    }*/
}
