package com.example.music.model.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ResetPasswordRequest {
    private String email;
    private String code;
    private String password;
    private String confirmPassword;
}
