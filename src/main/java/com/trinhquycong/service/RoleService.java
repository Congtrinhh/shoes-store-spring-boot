package com.trinhquycong.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.trinhquycong.entity.Role;

@Service
public class RoleService extends BaseService<Role>{

	@Override
	protected Class<Role> clazz() {
		// TODO Auto-generated method stub
		return Role.class;
	}
	
	public Role findByRoleName(String roleName) {
		String sql ="select * from role where name='" + roleName+"'";
		List<Role> roles = runTransactQuerySQL(sql, 0, null).getData();
		
		if (roles!=null && roles.size()>0) {
			return roles.get(0);
		}
		return null;
	}
}
