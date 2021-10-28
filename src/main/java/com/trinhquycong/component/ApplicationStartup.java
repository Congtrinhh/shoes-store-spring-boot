package com.trinhquycong.component;

import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;


@Component
public class ApplicationStartup implements ApplicationListener<ApplicationReadyEvent> {
	//@Autowired// inject 1 bean vào trong 1 bean khác
	//private CategoryService categoryService;
	
	/**
	 * khi ứng dụng chạy xong sẽ chạy vào hàm này.
	 */
	@Override
	public void onApplicationEvent(final ApplicationReadyEvent event) {
		
	}
	
}
