package com.trinhquycong.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.trinhquycong.component.Constants;
import com.trinhquycong.component.CustomAuthenticationFailureHandler;
import com.trinhquycong.component.MySimpleUrlAuthenticationSuccessHandler;

@Configuration	
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Autowired 
	private UserDetailsService userDetailsService;
	
	@Override
	protected void configure(final HttpSecurity http) throws Exception {
		http.csrf().disable().authorizeRequests() // bắt đầu cấu hình tất cả các request từ trình duyệt đều được bắt vào hàm này
		
		// cho phép các request static resources không bị ràng buộc (permitAll)
		.antMatchers("/js/**", "/css/**", "/images/**").permitAll()
		
		// quy định những role nào vào được những đâu
		// để quản lý user, bạn phải là role ADMIN
		.antMatchers("/admin/user/**").hasAnyAuthority(Constants.ROLE_ADMIN)
		
		// để vào trang admin, bạn có thể là ADMIN, MANAGER
		.antMatchers("/admin/**").hasAnyAuthority(Constants.ROLE_MANAGER, Constants.ROLE_ADMIN)
		
		// để vào trang cá nhân của khách hàng, bạn phải là CUSTOMER
		.antMatchers("/user/**").hasAuthority(Constants.ROLE_CUSTOMER)
		
		.and()
		
		// cấu hình trang đăng nhập
		.formLogin().loginPage("/login").loginProcessingUrl("/perform-login")
		.successHandler(this.myAuthenticationSuccessHandler())
		.failureHandler(this.authenticationFailureHandler())
		.permitAll()
		
		.and()
			
		.logout().logoutUrl("/logout").logoutSuccessUrl("/")
		.invalidateHttpSession(true)
		.deleteCookies("JSESSIONID")
		.permitAll()
		
		// cookie remember me - 5 tiếng available
		.and()
		.rememberMe().key("keyForLoginCookie").tokenValiditySeconds(3600*5);
		
	}
	
	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		
		auth.userDetailsService(userDetailsService).passwordEncoder(new BCryptPasswordEncoder(10));
	}
	
	@Bean
	public AuthenticationSuccessHandler myAuthenticationSuccessHandler(){
	    return new MySimpleUrlAuthenticationSuccessHandler();
	}
	
	@Bean
	public AuthenticationFailureHandler authenticationFailureHandler(){
	    return new CustomAuthenticationFailureHandler();
	}
}
