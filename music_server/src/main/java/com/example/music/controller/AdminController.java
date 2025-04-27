package com.example.music.controller;

import com.example.music.model.Result;
import com.example.music.model.request.AdminRequest;
import com.example.music.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 管理员
 */
@RestController
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private AdminService adminService;

    @PostMapping("/login/status")
    public Result loginStatus(@RequestBody AdminRequest adminRequest) {
        return adminService.verityPasswd(adminRequest);
    }

    @GetMapping("/detail")
    public Result getAdminDetail(@RequestParam("id") Integer id) {
        return adminService.getAdminDetail(id);
    }
}
