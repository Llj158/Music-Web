package com.example.music.aspect;

import com.alibaba.fastjson.JSON;
import com.example.music.controller.FileDownloadController;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;

@Aspect
@Component
@Slf4j
public class LogAspect {

    // 定义切点 - 所有controller包下的方法，排除FileDownloadController
    @Pointcut("execution(* com.example.music.controller..*.*(..)) && !within(com.example.music.controller.FileDownloadController)")
    public void controllerPointcut() {}

    // 前置通知：在目标方法执行前执行
    @Before("controllerPointcut()")
    public void doBefore(JoinPoint joinPoint) {
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attributes.getRequest();

        log.info("=========================== 请求开始 ===========================");
        log.info("URL: {}", request.getRequestURL().toString());
        log.info("HTTP Method: {}", request.getMethod());
        log.info("Class Method: {}.{}", joinPoint.getSignature().getDeclaringTypeName(), 
                joinPoint.getSignature().getName());
        log.info("IP: {}", request.getRemoteAddr());
        log.info("Request Args: {}", Arrays.toString(joinPoint.getArgs()));
    }


    // 异常通知：当目标方法出现异常时执行
    @AfterThrowing(pointcut = "controllerPointcut()", throwing = "e")
    public void doAfterThrowing(JoinPoint joinPoint, Throwable e) {
        log.error("发生异常！");
        log.error("异常方法: {}.{}", joinPoint.getSignature().getDeclaringTypeName(), 
                joinPoint.getSignature().getName());
        log.error("异常信息: {}", e.getMessage());
        log.error("异常堆栈: ", e);
    }

    // 后置通知：在目标方法执行后执行
    @After("controllerPointcut()")
    public void doAfter() {
        log.info("=========================== 请求结束 ===========================\n");
    }
} 