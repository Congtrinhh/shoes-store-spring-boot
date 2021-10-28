package com.trinhquycong.entity;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@Entity
@Table(name = "user")
public class User extends BaseEntity implements UserDetails {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Column(name = "username", nullable = false, length = 100, unique = true)
	private String username;
	
	@Column(name = "full_name")
	private String fullName;
	
	@Column(name = "password", nullable = false, length = 100)
	private String password;
	
	@Column(name = "email", nullable = false, length = 100, unique = true)
	private String email;
	
	@Column(name = "phone")
	private String phone;
	
	@Column(name = "address")
	private String address;
	
	@Transient
	private String confirmedPassword;
	
	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinTable(name = "user_role",
				joinColumns = @JoinColumn(name="user_id"),
				inverseJoinColumns = @JoinColumn(name="role_id"))
	private Set<Role> roles = new HashSet<>();
	
	public void addRole(Role role) {
		role.getUsers().add(this);
		this.roles.add(role);
	}
	
	public void deleteRole(Role role) {
		role.getUsers().remove(this);
		this.roles.remove(role);
	}
	
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private Set<SaleOrder> saleOrders = new HashSet<>();
	
	public void createSaleOrder(SaleOrder saleOrder) {
		this.saleOrders.add(saleOrder);
		saleOrder.setUser(this);
	}
	
	public void deleteSaleOrder(SaleOrder saleOrder) {
		saleOrder.setUser(null);
		this.saleOrders.remove(saleOrder);
	}
	
	@OneToOne(mappedBy = "user")
	private VerificationToken token;
	
	@OneToOne(mappedBy = "user")
	private ForgetPasswordToken passwordToken;
	

	public VerificationToken getToken() {
		return token;
	}

	public void setToken(VerificationToken token) {
		this.token = token;
	}

	
	public ForgetPasswordToken getPasswordToken() {
		return passwordToken;
	}

	public void setPasswordToken(ForgetPasswordToken passwordToken) {
		this.passwordToken = passwordToken;
	}

	public Set<SaleOrder> getSaleOrders() {
		return saleOrders;
	}

	public void setSaleOrders(Set<SaleOrder> saleOrders) {
		this.saleOrders = saleOrders;
	}

	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}

	public String getConfirmedPassword() {
		return confirmedPassword;
	}

	public void setConfirmedPassword(String confirmedPassword) {
		this.confirmedPassword = confirmedPassword;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return this.roles;
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}
	
	
	// set default status: false;
	public User() {
		super();
		this.status = false;
	}
}
