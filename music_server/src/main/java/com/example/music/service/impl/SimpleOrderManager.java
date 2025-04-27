package com.example.music.service.impl;
 
import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.example.music.service.OrderManager;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;
/**
 * 邮箱信息的发送
 */

@Service
public class SimpleOrderManager implements OrderManager {

    @Value("${mail.address}")
    private String sendAddress;

    @Autowired
    private JavaMailSender mailSender;



    public void sendCode(String code, String reciveAddress) {
        MimeMessagePreparator preparator = new MimeMessagePreparator() {
            public void prepare(@NotNull MimeMessage mimeMessage) throws Exception {
                mimeMessage.setRecipient(Message.RecipientType.TO,
                        new InternetAddress(reciveAddress));
                mimeMessage.setFrom(new InternetAddress(sendAddress));
                mimeMessage.setSubject("MusicWeb - 验证码");
                
                // HTML格式的邮件内容
                String htmlContent = String.format(
                    "<div style='background-color: #f7f7f7; padding: 20px;'>" +
                    "<div style='max-width: 600px; margin: 0 auto; background-color: #fff; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px rgba(0,0,0,0.1);'>" +
                    "<h2 style='color: #333; text-align: center; margin-bottom: 20px;'>验证码</h2>" +
                    "<p style='color: #666; font-size: 16px; margin-bottom: 20px;'>您好，</p>" +
                    "<p style='color: #666; font-size: 16px; margin-bottom: 20px;'>您正在进行密码重置操作，请使用以下验证码完成操作：</p>" +
                    "<div style='background-color: #f5f5f5; padding: 15px; text-align: center; margin-bottom: 20px; border-radius: 3px;'>" +
                    "<span style='color: #333; font-size: 24px; font-weight: bold; letter-spacing: 5px;'>%s</span>" +
                    "</div>" +
                    "<p style='color: #999; font-size: 14px; margin-bottom: 10px;'>验证码有效期为5分钟，请尽快使用。</p>" +
                    "<p style='color: #999; font-size: 14px;'>如果这不是您的操作，请忽略此邮件。</p>" +
                    "<div style='border-top: 1px solid #eee; margin-top: 20px; padding-top: 20px;'>" +
                    "<p style='color: #999; font-size: 12px; text-align: center; margin: 0;'>此邮件由系统自动发送，请勿回复</p>" +
                    "</div>" +
                    "</div>" +
                    "</div>",
                    code
                );
                
                mimeMessage.setContent(htmlContent, "text/html;charset=UTF-8");
            }
        };
        try {
            this.mailSender.send(preparator);
        } catch (MailException ex) {
            System.err.println(ex.getMessage());
        }
    }
}