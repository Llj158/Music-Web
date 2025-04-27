package com.example.music.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.music.model.Result;
import com.example.music.model.domain.Consumer;
import com.example.music.model.request.ConsumerRequest;
import com.example.music.model.request.ResetPasswordRequest;
import org.springframework.web.multipart.MultipartFile;

public interface ConsumerService extends IService<Consumer> {

    Result addUser(ConsumerRequest registryRequest);

    Result updateUserMsg(ConsumerRequest updateRequest);

    Result updateUserAvator(MultipartFile avatorFile, int id);

    Result updatePassword(ConsumerRequest updatePasswordRequest);

    boolean existUser(String username);

    Consumer verityPasswd(String username, String password);

    Result deleteUser(Integer id);

    Result allUser();

    Result userOfId(Integer id);

    Result loginStatus(ConsumerRequest loginRequest);
    Result loginEmailStatus(ConsumerRequest loginRequest);
    Consumer findByEmail (String email);
    Result updatePassword01(ConsumerRequest updatePasswordRequest);

    Result resetPassword(ResetPasswordRequest passwordRequest);

    Result sendVerificationCode(String email);
}
