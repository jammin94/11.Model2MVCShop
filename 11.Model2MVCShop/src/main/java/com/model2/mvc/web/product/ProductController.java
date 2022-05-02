package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> ȸ������ Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method ���� ����
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml ���� �Ұ�
	//==> �Ʒ��� �ΰ��� �ּ��� Ǯ�� �ǹ̸� Ȯ�� �Ұ�
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping( value="addProduct", method=RequestMethod.GET )
	public String addProduct() throws Exception {

		System.out.println("/product/addProduct : GET");
		
		return "redirect:/product/addProductView.jsp";
	}
	
		
	@RequestMapping( value="addProduct", method=RequestMethod.POST )
	public String addProduct( @ModelAttribute("product") Product product ) throws Exception {

		System.out.println("/product/addProduct : POST");
		//Business Logic
		
		MultipartFile uploadFile = product.getImageFile();
		if(!uploadFile.isEmpty()) {
			String fileName=uploadFile.getOriginalFilename();
			product.setFileName(fileName);
			uploadFile.transferTo(new File("C:\\Users\\bitcamp\\git\\11.Model2MVCShop\\11.Model2MVCShop\\src\\main\\webapp\\images\\"+fileName));
			
		}
		
		productService.addProduct(product);
		int prodNo=productService.getProductNo(product.getProdName());
		
		return "redirect:/product/getProduct/"+prodNo;
	}
	
	
	@RequestMapping( value="getProduct/{prodNo}", method=RequestMethod.GET )
	public String getProduct(@PathVariable String prodNo,HttpServletRequest request,HttpServletResponse response, Model model ) throws Exception {
	
		System.out.println("/product/getProduct : GET");
		//Business Logic
		Product product = productService.getProduct(Integer.parseInt(prodNo));
		model.addAttribute(product);
		
		//Cookie �ذ�
		Cookie cookie = null;
		Cookie[] cookies = request.getCookies();
		
		if (cookies!=null && cookies.length > 0) {
			for (Cookie c : cookies) {
				if (c.getName().equals("history")) {
					cookie=new Cookie("history",c.getValue()+"!"+prodNo);
					System.out.println(cookie.getName());
					System.out.println(cookie.getValue());
				}	
			}
			
			if(cookie==null) {
				cookie=new Cookie("history",prodNo);
			}
		}
		
		response.addCookie(cookie);
		
		return "/product/getProduct.jsp";
		
	}
	
	@RequestMapping( value="updateProduct/{prodNo}", method=RequestMethod.GET )
	public String UpdateProductView( @PathVariable String prodNo, Model model ) throws Exception {

		System.out.println("/product/updateProduct : GET");
		//Business Logic
		Product product=productService.getProduct(Integer.parseInt(prodNo));
		
		model.addAttribute(product);

		return "/product/updateProductView.jsp";
	}
	
	@RequestMapping( value="updateProduct", method=RequestMethod.POST )
	public String UpdateProduct( @ModelAttribute("product") Product product ) throws Exception {

		System.out.println("/product/updateProduct : POST");
		//Business Logic
		MultipartFile uploadFile = product.getImageFile();
		if(!uploadFile.isEmpty()) {
			String fileName=uploadFile.getOriginalFilename();
			System.out.println(fileName);
			product.setFileName(fileName);
			uploadFile.transferTo(new File("C:\\Users\\bitcamp\\git\\11.Model2MVCShop\\11.Model2MVCShop\\src\\main\\webapp\\images\\"+fileName));
			
		}
		productService.updateProduct(product);

		return "redirect:/product/getProduct/"+productService.getProductNo(product.getProdName());
	}
	
	@RequestMapping("/listProduct")
	public String listProudct( @ModelAttribute("search") Search search , Model model) throws Exception{
		
		System.out.println("/product/listProduct : GET/POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}
	
}