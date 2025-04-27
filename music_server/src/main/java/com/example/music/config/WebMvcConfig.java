package com.example.music.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 统一拦截
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Bean
    public CorsInterceptor corsInterceptor() {
        return new CorsInterceptor();
    }
    @Autowired
    private LoginCheckInterceptor loginCheckInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(corsInterceptor())
                .addPathPatterns("/**");

        registry.addInterceptor(loginCheckInterceptor)
                .addPathPatterns("/user/**")
                .excludePathPatterns(
                    "/user/login/status",
                    "/user/email/status",
                    "/user/add",
                    "/user/resetPassword",
                    "/user/sendVerificationCode",
                    "/user/detail"
                );
    }

}