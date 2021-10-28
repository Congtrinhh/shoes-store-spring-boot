package com.trinhquycong.controller.common;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SendEmailController {
	@Autowired
	public JavaMailSender mailSender;
	
	@ResponseBody
	@RequestMapping("/sendSimpleEmail")
	public String sendSimpleEmail() throws MessagingException {
		MimeMessage message = mailSender.createMimeMessage();
		
		boolean multipart = true;
		
		MimeMessageHelper helper = new MimeMessageHelper(message, multipart, "utf-8");
		
		
		String htmlMsg = "<h1>123hlen</h1>";
		
		message.setContent(htmlMsg, "text/html; charset=utf-8");
		
		
		helper.setTo("trinhquycong@gmail.com");
		helper.setSubject("test html");
		
		
		this.mailSender.send(message);
		
		return "sent";
	}
}
