package com.trinhquycong.controller.user;

import java.util.Calendar;
import java.util.List;
import java.util.Locale;

import javax.persistence.PersistenceException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.trinhquycong.component.Constants;
import com.trinhquycong.component.OnRegistrationCompleteEvent;
//import com.trinhquycong.component.OnRegistrationCompleteEvent;
import com.trinhquycong.component.Utilities;
import com.trinhquycong.controller.common.BaseController;
import com.trinhquycong.dto.UserSearchModel;
import com.trinhquycong.entity.ForgetPasswordToken;
import com.trinhquycong.entity.Province;
import com.trinhquycong.entity.Role;
import com.trinhquycong.entity.User;
import com.trinhquycong.entity.VerificationToken;
//import com.trinhquycong.entity.VerificationToken;
import com.trinhquycong.service.CheckoutService;
import com.trinhquycong.service.ForgetPasswordTokenService;
import com.trinhquycong.service.PagerData;
import com.trinhquycong.service.RoleService;
import com.trinhquycong.service.UserService;
import com.trinhquycong.service.VerificationTokenService;

/**
 * đăng ký - đăng nhập user
 * @author trinh
 *
 */
@Controller
public class UserController extends BaseController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private RoleService roleService;
	
	@Autowired
	private CheckoutService checkoutService;
	
	@Autowired
	private VerificationTokenService verificationTokenService;
	
	@Autowired
	private ForgetPasswordTokenService passwordTokenService;
	
	@Autowired
	private ApplicationEventPublisher eventPublisher;
	
	@Autowired
	private JavaMailSender mailSender;

	/**
	 * Đăng ký - GET
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "register", method = RequestMethod.GET)
	public String getRegisterPage(Model model) {
		
		User user = new User();
		
		model.addAttribute("user", user);
		
		return "user/register";
	}
	
	/**
	 * Đăng ký - POST - Xử lý form
	 * validate trùng email -username
	 * @param model
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String processSubmit(Model model, HttpServletRequest request, @ModelAttribute("user") User user) {
		
		Role userRole = roleService.findByRoleName(Constants.ROLE_CUSTOMER);
		
		String message = null;
		
		if (userRole!=null ) {
			try {
				User registeredUser = userService.createUser(user, userRole);
				
				String appUrl = request.getContextPath();
				
				eventPublisher.publishEvent(new OnRegistrationCompleteEvent(registeredUser, 
				          request.getLocale(), appUrl));
				
				message = "Tin nhắn kích hoạt tài khoản đã được gửi vào địa chỉ mail của bạn, kích tài khoản ngay nào";
			}
			// lỗi khi trùng username/email
			catch (PersistenceException e) {
				// lấy ra tất cả message lỗi trong exception object
				List<String> detailMessages = Utilities.getExceptionMessageChain(e);
				String finalErrorMessage = detailMessages.get(detailMessages.size()-1); // lấy msg cuối
				
				if (finalErrorMessage.contains("email")) {
					message = "Email này đã tồn tại";
				}else if (finalErrorMessage.contains("username")) {
					message = "Username này đã tồn tại";
				}
				
				model.addAttribute("errorMessage", message);
				
				// reset password trước khi đẩy về view
				user.setPassword(null);
				user.setConfirmedPassword(null);
				// trả về trang đăng ký kèm tbao lỗi
				return "user/register";
			}
			catch (Exception e) {
				message = "Đăng ký thất bại, hệ thống gặp lỗi";				
				// reset password trước khi đẩy về view
				user.setPassword(null);
				user.setConfirmedPassword(null);
				// trả về trang đăng ký kèm tbao lỗi
				return "user/register";
			}
			// thông báo thành công vào session
			request.getSession()
				.setAttribute("registerSuccessfullyMessage", message);
			
		}
		
		return "redirect:/login";
	}
	
	/**
	 * Quên mật khẩu - bước 1: hiển thị trang nhập email 
	 */
	@RequestMapping(value = "/forget-password", method = RequestMethod.GET)
	public String getForgetPasswordPage() {
		return "user/forgetPassword";
	}
	
	/**
	 * Quên mật khẩu - bước 2 : nhận địa chỉ email lên controller và gửi về tin nhắn gmail cho người dùng 
	 */
	@RequestMapping(value = "/forget-password", method = RequestMethod.POST)
	public String sendForgetPasswordEmail(Model model, @RequestParam("email") String email, @Value("${website.localName}") String appUrl) {
		
		UserSearchModel searchModel = new UserSearchModel();
		searchModel.setEmail(email);
		PagerData<User> pagerData = userService.search(searchModel);
		User user = null;
		
		if (pagerData.getData()!=null && pagerData.getData().size()>0) {
			user = pagerData.getData().get(0);
		}
		
		if (user!=null) {
		
			// tạo token hoặc update
			ForgetPasswordToken token = passwordTokenService.saveOrUpdateForgetPasswordToken(user);
			
			
			// gửi email kèm token
			String confirmUrl = appUrl + "/change-password?token=" + token.getToken();
			
			SimpleMailMessage mailMessage = new SimpleMailMessage();
			mailMessage.setTo(email);
			mailMessage.setSubject("Change password");
			mailMessage.setText("Bấm vào link ngay bên dưới để đến trang đổi mật khẩu:\n"+ confirmUrl);
			
			mailSender.send(mailMessage);
			
			model.addAttribute("successfulMessage", "Tin nhắn đổi mật khẩu đã được gửi vào địa chỉ mail của bạn");
		} else {
			model.addAttribute("errorMessage", "Không tìm thấy tài khoản với email: " + email);
		}		
		
		return "user/forgetPassword";
	}
	
	/**
	 * Quên mật khẩu - bước 3 : nhận lại token, check token valid và chưa hết hạn, trả về trang nhập mk mới
	 */
	@RequestMapping(value = "/change-password", method = RequestMethod.GET)
	public String checkForgetPasswordToken(Model model, @RequestParam("token") String token) {
		
		ForgetPasswordToken passwordToken = passwordTokenService.findByToken(token);
		
		User user = passwordToken.getUser();
		
		if (passwordToken==null || user==null) {
			model.addAttribute("errorMessage", "Invalid token");
			return "common/badUser";
		}
		
		Calendar cal = Calendar.getInstance();
		if (passwordToken.getExpiryDate().before(cal.getTime())) {
			model.addAttribute("errorMessage", "Token expired");
			return "common/badUser";
		}
		
		model.addAttribute("userId", user.getId());
		
		return "user/enterNewPassword";
	}
	
	/**
	 * Quên mật khẩu - bước 4 : nhận mk mới, thực hiện đổi mk cho người dùng, trả lại trang đổi mk thành công.
	 */
	@RequestMapping(value = "/change-password", method = RequestMethod.POST)
	public String changePassword(Model model, @RequestParam("password") String newPassword, @RequestParam("id") Integer userId) {
		
		if (userId!=null) {
			
			User user = userService.getById(userId);
			
			String hashedPassword = userService.getEncodedPassword(newPassword);
			user.setPassword(hashedPassword);
			userService.saveOrUpdate(user);
			
			model.addAttribute("message", "Chúc mừng, bạn đã đổi mật khẩu thành công");
			return "common/successful";
		} else {
			model.addAttribute("errorMessage", "Đổi mật khẩu không thành công, vui lòng thử lại");
			return "user/enterNewPassword";
		}
		
	}
	
	/**
	 * xác nhận activate user 
	 */
	@RequestMapping(value = "/regitrationConfirm", method = RequestMethod.GET)
	public String confirmRegistration(HttpServletRequest request, @RequestParam("token") String token) {
		Locale locale = request.getLocale();
		
		VerificationToken verificationToken = null;
		try {
			verificationToken = verificationTokenService.findByToken(token);
		}catch (RuntimeException e) {
			request.getSession().setAttribute("errorMessage", "Invalid token");
			return "redirect:/login-error";
		}
		
		if (verificationToken == null) {
	        request.getSession().setAttribute("errorMessage", "Invalid token");
	        return "redirect:/login-error";
	    }
		
		User user = verificationToken.getUser();
		
		Calendar cal = Calendar.getInstance();
		if ((verificationToken.getExpiryDate().getTime() - cal.getTime().getTime()) <= 0) {
	        request.getSession().setAttribute("errorMessage", "Expired token");
	        request.getSession().setAttribute("expired", true);
	        request.getSession().setAttribute("token", verificationToken.getToken());
	        return "redirect:/login-error";
	    } 
		
		user.setStatus(true);
		userService.saveOrUpdate(user);
		
		return "redirect:/activated-account-successfully?lang=" + locale.getLanguage(); 
	}
	
	@RequestMapping(value = "/resendToken", method = RequestMethod.GET)
	public String resendToken(@RequestParam("token") String currentToken, HttpServletRequest request, @Value("${website.localName}") String appUrl) {
		
		VerificationToken newToken = verificationTokenService.generateNewVerificationToken(currentToken);
		
		User user = newToken.getUser();
		
		
		SimpleMailMessage message = constructResendVerificationTokenEmail(appUrl, newToken, user);

		
		mailSender.send(message);
		
		return "common/activatedSuccessfully";
	}
	
	private SimpleMailMessage constructResendVerificationTokenEmail(String appUrl, VerificationToken newToken,
			User user) {
		
		String confirmUrl = appUrl + "/regitrationConfirm?token=" + newToken.getToken();
		
		SimpleMailMessage mailMessage = new SimpleMailMessage();
		mailMessage.setTo(user.getEmail());
		mailMessage.setSubject("Resend confirmation registration");
		mailMessage.setText("Bấm vào link ngay bên dưới để xác nhận đăng ký tài khoản:\n"+ confirmUrl);
		
		return mailMessage;
	}


	/**
	 * user info - trang thông tin cá nhân của người dùng
	 * validate trùng...
	 * ----------- doạn auth liệu có thể bỏ, hoặc thay đổi securitycontextholder..?
	 */
	@RequestMapping(value = "/user/account", method = RequestMethod.GET)
	public String getUserAccountPage(Model model,  Authentication auth) {
	
		User user = (User) auth.getPrincipal();
		
		
		List<Province> provinces = checkoutService.getAllProvince();
		
		
		model.addAttribute("user", user);
		model.addAttribute("provinces", provinces);
		
		return "user/account";
	}
	
	/**
	 * Cập nhật user
	 * @param user
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/user/account", method = RequestMethod.POST)
	public String processUpdate(@ModelAttribute("user") User user, HttpServletRequest request) {
		
		userService.updateUser(user, request);
		
		return "user/account";
	}
}
