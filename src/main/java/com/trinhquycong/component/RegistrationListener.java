package com.trinhquycong.component;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationListener;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

import com.trinhquycong.entity.User;
import com.trinhquycong.service.VerificationTokenService;

@Component
public class RegistrationListener implements ApplicationListener<OnRegistrationCompleteEvent> {
	
	@Autowired
	private VerificationTokenService tokenService;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Value("${website.localName}")
	private String localName;

	@Override
	public void onApplicationEvent(OnRegistrationCompleteEvent event) {
		this.confirmRegistration(event);
	}
	
	
	private void confirmRegistration(OnRegistrationCompleteEvent event) {
		User user = event.getUser();
		
		String token = UUID.randomUUID().toString();
		
		tokenService.createVerificationToken(user, token);
		
		String recipientAddress = user.getEmail();
		
		String subject = Constants.NAME_OF_WEBSITE +  " - Registration Confirmation";
		String confirmationUrl 
        = event.getAppUrl() + "/regitrationConfirm?token=" + token;
		String message = "Xác nhận đăng ký tài khoản\nNếu bạn vừa đăng ký tài khoản với tên đăng nhập " + user.getUsername() +
				" , vui lòng click vào link dưới đây để kích hoạt tài khoản:";
		
		SimpleMailMessage email = new SimpleMailMessage();
		email.setTo(recipientAddress);
		email.setSubject(subject);
		email.setText(message + "\r\n" + localName + confirmationUrl);
		mailSender.send(email);
	}

}
