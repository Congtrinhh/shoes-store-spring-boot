package com.trinhquycong.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;


@Entity
@Table(name = "contact")
public class Contact extends BaseEntity {
	
	
	@Column(name="email", nullable = false, length=100)
	private String email;
	
	@Column(name="message", nullable = false, length=1000)
	private String message ;


	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
}
