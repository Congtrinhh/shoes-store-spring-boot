package com.trinhquycong.config;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
public class MailConfig {

	@Bean 
	public JavaMailSender getJavaMailSender() {
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		
		mailSender.setDefaultEncoding("UTF-8");
		mailSender.setHost("smtp.gmail.com");
		mailSender.setPort(587);
		
		mailSender.setUsername("congtrinhhbangiay@gmail.com");
		mailSender.setPassword("trinhquycong");
		
		Properties props = mailSender.getJavaMailProperties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.debug", "true");
        
        return mailSender;
	}
}
