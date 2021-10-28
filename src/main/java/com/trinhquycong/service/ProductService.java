package com.trinhquycong.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.trinhquycong.component.Utilities;
import com.trinhquycong.dto.ProductSearchModel;
import com.trinhquycong.entity.Brand;
import com.trinhquycong.entity.Category;
import com.trinhquycong.entity.Product;
import com.trinhquycong.entity.ProductImage;

@Service
public class ProductService extends BaseService<Product> {

	@Autowired
	private ProductService productService;

	@Autowired
	private BrandService brandService;

	@Autowired
	private CategoryService categoryService;

	@Override
	protected Class<Product> clazz() {
		// TODO Auto-generated method stub
		return Product.class;
	}

	public void create(Product product, MultipartFile avatar, MultipartFile[] images, String imgBasePath)
			throws IllegalStateException, IOException {

		// lưu ảnh và avatar và disk

		// chuẩn bị thư mục
		String avatarPath = imgBasePath + "product/avatar/";
		String imagePath = imgBasePath + "product/image/";
		File avatarDir = new File(avatarPath);
		if (!avatarDir.exists()) {
			avatarDir.mkdirs();
		}
		File imageDir = new File(imagePath);
		if (!imageDir.exists()) {
			imageDir.mkdirs();
		}

		// lưu avt
		if (avatar != null && !avatar.getOriginalFilename().isEmpty()) {
			String fileName = new Date().getTime() + "_" + avatar.getOriginalFilename();
			File avtFileDir = new File(avatarPath + fileName);
			avatar.transferTo(avtFileDir);

			// set avatar path cho product
			product.setAvatar(avatarPath + fileName);
		}

		if (images != null && images.length > 0) {
			for (MultipartFile img : images) {
				if (img != null && !img.getOriginalFilename().isEmpty()) {
					String fileName = new Date().getTime() + "_" + img.getOriginalFilename();
					File imgFileDir = new File(imagePath + fileName);
					img.transferTo(imgFileDir);

					// thêm image vào product để upload lên DB
					ProductImage productImg = new ProductImage();
					productImg.setPath(imagePath + fileName);
					productImg.setName(
							img.getOriginalFilename().substring(0, img.getOriginalFilename().lastIndexOf(".") - 1));

					product.addProductImage(productImg);
				}
			}
		}

		Brand brand = brandService.getById(product.getBrand().getId());
		Category category = categoryService.getById(product.getCategory().getId());

		product.setSeo(Utilities.slugify(product.getName()));
		product.setBrand(brand);
		product.setCategory(category);
		product.setCreatedDate(new Date());

		productService.saveOrUpdate(product);
	}

	public void update(Product product, MultipartFile avatar, MultipartFile[] images, String imgBasePath)
			throws IllegalStateException, IOException {

		// chuẩn bị thư mục
		String avatarPath = imgBasePath + "product/avatar/";
		String imagePath = imgBasePath + "product/image/";
		File avatarDir = new File(avatarPath);
		if (!avatarDir.exists()) {
			avatarDir.mkdirs();
		}
		File imageDir = new File(imagePath);
		if (!imageDir.exists()) {
			imageDir.mkdirs();
		}

		// lấy ra product từ DB, vì:
		// cần 1 số property như: avatar
		Product productInDB = productService.getById(product.getId());

		// nếu avatar mới được upload
		if (!isEmptyFile(avatar)) {
			// xóa avt cũ trong disk
			String avatarPathDB = productInDB.getAvatar();
			if (avatarPathDB != null) {
				File oldAvatarFileDir = new File(avatarPathDB);
				if (oldAvatarFileDir != null) {
					if (oldAvatarFileDir.delete()) {
						System.out.println("Xoa thanh cong avt");
					} else {
						System.out.println("Xoa that bai avt");
					}
				}
			}

			// lưu avt mới và set lại avt path cho product
			String fileName = new Date().getTime() + "_" + avatar.getOriginalFilename();
			File newAvatarFileDir = new File(avatarPath + fileName);
			avatar.transferTo(newAvatarFileDir);

			product.setAvatar(avatarPath + fileName);
		} else {
			product.setAvatar(productInDB.getAvatar());
		}

		// nếu image mới được upload
		if (images != null && images.length > 0 && !isEmptyFile(images[0])) {
			// xóa hết image trong disk
			// xóa hết image trong product
			for (ProductImage oldImg : productInDB.getProductImages()) {
				File imgDir = new File(oldImg.getPath());
				if (imgDir.delete()) {
					System.out.println("Xoa img thanh cong: " + oldImg.getPath());
				} else {
					System.out.println("Xoa img that bai");
				}

				product.deleteProductImage(oldImg);
			}

			// thêm image vào disk
			// them image vào product
			for (MultipartFile imgToUpload : images) {
				String fileName = new Date().getTime() + "_" + imgToUpload.getOriginalFilename();
				File imgDir = new File(imagePath + fileName);
				imgToUpload.transferTo(imgDir);

				ProductImage productImg = new ProductImage();
				productImg.setPath(imagePath + fileName);
				productImg.setName(imgToUpload.getOriginalFilename());
				product.addProductImage(productImg);
			}
		} else {
			product.setProductImages(productInDB.getProductImages());
		}

		// cần set brand, category cho product, vì lúc này brand và category gửi lên từ
		// spring form = null, chỉ có id
		Brand brand = brandService.getById(product.getBrand().getId());
		Category category = categoryService.getById(product.getCategory().getId());

		product.setSeo(Utilities.slugify(product.getName())); // auto tạo slug
		product.setBrand(brand);
		product.setCategory(category);
		product.setUpdatedDate(new Date());

		productService.saveOrUpdate(product);
	}

	public boolean isEmptyFile(MultipartFile part) {
		return part == null || part.getOriginalFilename().length() <= 0 ? true : false;
	}
	
	@Transactional
	public Integer deleteWithFileSystem(Integer id) {

		Product product = productService.getById(id);

		// vì còn ràng buộc với các bảng con, chỉ cập nhật status cho product, chứ không
		// xóa
		if (product.getProductImages().size() > 0 || product.getProductSizes().size() > 0) {
			product.setStatus(false);
			productService.saveOrUpdate(product);
			return 201; // item inactivated
		}

		// nếu không ràng buộc, xóa trong db và disk
		Set<ProductImage> images = product.getProductImages();

		// xóa avt trong disk
		new File(product.getAvatar()).delete();
		// xóa imgs trong disk
		for (ProductImage img : images) {
			new File(img.getPath()).delete();
		}

		productService.deleteById(id);
		return 200; // item removed completely
	}

	public List<Brand> getBrands() {
		return brandService.findAll();
	}

	public List<Category> getCategories() {
		return categoryService.findAll();
	}

	/**
	 * Dùng search để get product (cả admin và user)
	 */
	public PagerData<Product> search(ProductSearchModel searchModel) {
		// Khởi tạo câu lệnh Sql
		String sql = "select * from product p where 1=1";

		if (searchModel != null) {

			// Tìm kiếm theo categoryId
			if (searchModel.getCategoryId() != null) {
				sql += " and category_id=" + searchModel.getCategoryId();
			}

			// Tìm kiếm theo keyword
			if (searchModel.getKeyword() != null) {
				sql += " and (name like '%" + searchModel.getKeyword() + "%'" + " or short_description like '%"
						+ searchModel.getKeyword() + "%'" + " or detail_description like '%" + searchModel.getKeyword()
						+ "%')";
			}

			// theo seo
			if (searchModel.getSeo() != null) {
				sql += " and seo='" + searchModel.getSeo() + "'";
			}

			// theo hãng - brand
			if (searchModel.getBrandId() != null) {
				sql += " and brand_id=" + searchModel.getBrandId();
			}

			// sản phẩm hot
			if (searchModel.getIsHot() != null) {
				if (searchModel.getIsHot().equals(true))
					sql += " and is_hot=true";
				else
					sql += " and is_hot=false";
			}

			// theo khoảng giá
			if (searchModel.getMinPrice() != null && searchModel.getMaxPrice() != null) {
				sql += " and price between " + searchModel.getMinPrice() + " and " + searchModel.getMaxPrice();
			}

			// theo trang thai
			if (searchModel.getStatus() != null) {
				if (searchModel.getStatus().equals(true))
					sql += " and status=true";
				else 
					sql += " and status=false";
			}
			
			// theo giới tính
			if (searchModel.getGender() != null) {
				if (searchModel.getGender().equals(true)) {
					sql += " and gender=true";					
				} else {
					sql += " and gender=false";
				}
			}
			
			// -------------------------------- từ đây là sort --------------------------------
			// -------------------------------- từ đây là sort --------------------------------
			sql += " order by created_by";
			
			// mới nhất (new arrivals)
			if (searchModel.getNewest() != null && searchModel.getNewest() == true) {
				sql += " ,created_date desc";
			}
			
			// giá tăng dần hoặc giảm dần
			if (searchModel.getPriceSort()!=null) {
				if (searchModel.getPriceSort().equals(true)) {
					sql += " ,price asc";
				}else {
					sql += " ,price desc";
				}
			}

		}

		return runTransactQuerySQL(sql, searchModel == null ? 0 : searchModel.getPage(),
				searchModel == null ? null : searchModel.getSop());
	}

	/*
	 * cho phần front-end (user)
	 */
	public List<Product> getOnlyProductsContainSize(List<Product> list){
		List<Product> products = new ArrayList<>();
		for (Product p : list) {
			if (p.getProductSizes()!=null && p.getProductSizes().size()>0) {
				products.add(p);	
			}
		}
		return products;
	}

}

/*
 * get list entity theo sql query
 * 
 */