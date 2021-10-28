package com.trinhquycong.service;

import java.util.UUID;

import javax.persistence.NoResultException;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.trinhquycong.entity.User;
import com.trinhquycong.entity.VerificationToken;

@Service
@Transactional
public class VerificationTokenService extends BaseService<VerificationToken> {

	@Override
	protected Class<VerificationToken> clazz() {
		// TODO Auto-generated method stub
		return VerificationToken.class;
	}
	
	public VerificationToken findByToken(String token) throws NoResultException {
		String sql = "select * from verification_token where token='" + token + "'";
		VerificationToken rs = (VerificationToken) super.entityManager.createNativeQuery(sql, this.clazz()).getSingleResult();
		return rs;
	}
	
	public VerificationToken createVerificationToken(User user, String token) {
		VerificationToken t = new VerificationToken(token, user);
		t.setExpiryDate();
		
		return super.saveOrUpdate(t);
	}
	
	/**
	 * tạo update mã token 
	 */
	public VerificationToken generateNewVerificationToken(String existingToken) {
		// lấy ra token hiện tại trong DB
		VerificationToken verificationToken = this.findByToken(existingToken);
		
		// set mã token mới + gia hạn expiry date
		verificationToken.updateToken(UUID.randomUUID().toString());
		
		// lưu thay đổi vào DB
		verificationToken = this.saveOrUpdate(verificationToken);
		
		// trả về token đã được update
		return verificationToken;
	}
	
}
