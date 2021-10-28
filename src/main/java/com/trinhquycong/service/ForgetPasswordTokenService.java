package com.trinhquycong.service;

import java.util.UUID;

import javax.persistence.NoResultException;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.trinhquycong.entity.ForgetPasswordToken;
import com.trinhquycong.entity.User;

@Service
@Transactional
public class ForgetPasswordTokenService extends BaseService<ForgetPasswordToken> {

	@Override
	protected Class<ForgetPasswordToken> clazz() {
		// TODO Auto-generated method stub
		return ForgetPasswordToken.class;
	}
	
	public ForgetPasswordToken findByToken(String token) throws NoResultException {
		String sql = "select * from forget_password_token where token='" + token + "'";
		ForgetPasswordToken rs = (ForgetPasswordToken) super.entityManager.createNativeQuery(sql, this.clazz()).getSingleResult();
		return rs;
	}
	
	// cập nhật lại token nếu đã tồn tại, ngược lại tạo mới
	public ForgetPasswordToken saveOrUpdateForgetPasswordToken(User user) {
		// tạo mới token
		if (user.getPasswordToken()==null) {
			ForgetPasswordToken token = new ForgetPasswordToken(UUID.randomUUID().toString(), user);
			token.setExpiryDate();
			return this.saveOrUpdate(token);
		}
		// cập nhật token (mã token)
		else {
			ForgetPasswordToken existing = user.getPasswordToken();
			existing.setToken(UUID.randomUUID().toString());
			existing.setExpiryDate();
			return this.saveOrUpdate(existing);
		}
	}
	
	/**
	 * tạo update mã token 
	 */
	public ForgetPasswordToken generateNewForgetPasswordToken(String existingToken) {
		// lấy ra token hiện tại trong DB
		ForgetPasswordToken verificationToken = this.findByToken(existingToken);
		
		// set mã token mới + gia hạn expiry date
		verificationToken.updateToken(UUID.randomUUID().toString());
		
		// lưu thay đổi vào DB
		verificationToken = this.saveOrUpdate(verificationToken);
		
		// trả về token đã được update
		return verificationToken;
	}
	
}
