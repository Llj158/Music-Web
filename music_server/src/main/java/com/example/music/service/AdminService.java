package com.example.music.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.music.model.Result;
import com.example.music.model.domain.Admin;
import com.example.music.model.request.AdminRequest;

public interface AdminService extends IService<Admin> {

    Result verityPasswd(AdminRequest adminRequest);

    Result getAdminDetail(Integer id);
}
