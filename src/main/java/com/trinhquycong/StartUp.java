package com.trinhquycong;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@SpringBootApplication
public class StartUp {
	public static void main(String[] args) {
		
		//System.out.println(new BCryptPasswordEncoder(4).encode("sam123"));
		SpringApplication.run(StartUp.class, args);
	}
	
	// thêm nút quên mk trong trang user account
	
	/**  thu debug khi chay tren pagekite
	 * - trang mà mình bị tự hủy vì không gia hạn - 30 ngày - e.. https://jelastic.com/
	 * 
	 *  aws-verification@amazon.com
	 * Crud manager(dành cho admin) -> done
	 * Crud user (dành cho admin) - read/list/delete -> done
	 * Sửa thông tin admin/manager -> done
	 * Giới hạn số admin là 5 -> done
	 * Gửi email confirm đơn hàng -> done
	 * nối 2 bảng userid -> done
	 * 
	 * Activate registration --> done
	 * Quên MK --> done
	 * 
	 * Thêm loader cho (thanh toán) , (đăng ký), (quên mk), (kích hoạt), (gửi token xác nhận mk) vì load quá 1s --> done
	 * Filter admin - status + hiển thị tổng số sp của query --> done 
	 * phân trang admin - script bên dưới : 5item/trang --> done
	 * Tạo trang contact --> done
	 * Format giá tiền - trong file js ajax --> done
	 * Tạo biến cho một số thứ như: email address,.. --> done
	 * 
	 * Responsive trang product list --> done
	 * Tạo trang search --> done
	 * Thông báo khi thêm hàng thành công (alert, toast) --> done
	 * 
	 * Tính toán giá hàng: bỏ priceSale, tính bằng %sale -->done
	 * 
	 * hiển thị sp trang chủ: chỉ lấy sp có size -> như trong product category --> done
	 * 
	 * Khi đơn hàng hủy -> hoàn lại số lượng sp :(( --> sẽ mở rộng sau :))
	 */
}