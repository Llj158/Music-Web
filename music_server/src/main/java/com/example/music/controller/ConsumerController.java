package com.example.music.controller;

import com.example.music.model.Result;
import com.example.music.model.request.ResetPasswordRequest;
import com.example.music.model.request.ConsumerRequest;
import com.example.music.service.ConsumerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


@RestController
@RequestMapping("/user")
public class ConsumerController {

    @Autowired
    private ConsumerService consumerService;

    /**
     * 用户注册
     */
    @PostMapping("/add")
    public Result addUser(@RequestBody ConsumerRequest registryRequest) {
        return consumerService.addUser(registryRequest);
    }

    /**
     * 登录
     */
    @PostMapping("/login/status")
    public Result loginStatus(@RequestBody ConsumerRequest loginRequest) {
        return consumerService.loginStatus(loginRequest);
    }
    /**
     * email登录
     */
    @PostMapping("/email/status")
    public Result loginEmailStatus(@RequestBody ConsumerRequest loginRequest) {
        return consumerService.loginEmailStatus(loginRequest);
    }

    /**
     * 忘记密码
     */

    @PostMapping("/resetPassword")
    public Result resetPassword(@RequestBody ResetPasswordRequest passwordRequest) {
        return consumerService.resetPassword(passwordRequest);
    }

    /**
     * 发送验证码功能
     */
    @GetMapping("/sendVerificationCode")
    public Result sendCode(@RequestParam String email) {
        return consumerService.sendVerificationCode(email);
    }
    /**
     * 管理员
     * 返回所有用户
     */
    @GetMapping
    public Result allUser() {
        return consumerService.allUser();
    }


    /**
     * 返回指定 ID 的用户
     */
    @GetMapping("/detail")
    public Result userOfId(@RequestParam int id) {
        return consumerService.userOfId(id);
    }

    /**
     * 删除用户
     */
    @GetMapping("/delete")
    public Result deleteUser(@RequestParam int id) {
        return consumerService.deleteUser(id);
    }

    /**
     * 更新用户信息
     */
    @PostMapping("/update")
    public Result updateUserMsg(@RequestBody ConsumerRequest updateRequest) {
        return consumerService.updateUserMsg(updateRequest);
    }

    /**
     * 更新用户密码
     */
    @PostMapping("/updatePassword")
    public Result updatePassword(@RequestBody ConsumerRequest updatePasswordRequest) {
        return consumerService.updatePassword(updatePasswordRequest);
    }

    /**
     * 更新用户头像
     */
    @PostMapping("/avatar/update")
    public Result updateUserPic(@RequestParam("file") MultipartFile avatorFile, @RequestParam("id") int id) {
        return consumerService.updateUserAvator(avatorFile, id);
    }

}
