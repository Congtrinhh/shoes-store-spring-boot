package com.trinhquycong.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.springframework.security.core.GrantedAuthority;

@Entity
@Table(name = "role")
public class Role extends BaseEntity implements GrantedAuthority {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Column(name = "name", nullable = false, length = 100)
	private String name;
	
	@Column(name = "description", nullable = false, length = 100)
	private String description;
	
	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, mappedBy = "roles")
	private Set<User> users = new HashSet<>();
	
	public void addUser(User user) {
		user.getRoles().add(this);
		this.users.add(user);
	}
	
	public void deleteUser(User user) {
		user.getRoles().remove(this);
		this.users.remove(user);
	}
	

	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	
	/**
	 * chính là tên ROLE
	 */
	@Override
	public String getAuthority() {
		// TODO Auto-generated method stub
		return this.name;
	}
}
