package com.spring.ex.products.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.products.model.ProductsBean;
import com.spring.ex.products.model.ProductsDao;

@Controller
public class ProductsInsertController {
	
	//private final String command = "/insert.prd";
	private final String command = "/product/user/insert.prd";
	private String getPage = "/product/productsInsertForm";
	private String gotoPage = "redirect:/product/list.prd";
	
	@Autowired
	ProductsDao pdao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public ModelAndView doAction() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName(getPage);
		return mav;
	}
	
	//productsInsertForm.jsp에서 등록버튼 클릭시 요청
	@RequestMapping(value=command, method=RequestMethod.POST)
	public ModelAndView doAction(
			@ModelAttribute("pb") @Valid ProductsBean pb,
			BindingResult result) {
		
		ModelAndView mav = new ModelAndView();
		pb.setSeller("loginId"); // 아이디 챙겨가기
		
		String uploadPath = servletContext.getRealPath("/resources");
		
		File destination = new File(uploadPath + File.separator + pb.getUpload().getOriginalFilename());
		System.out.println("업로드한 파일명 : "+uploadPath + File.separator + pb.getUpload().getOriginalFilename());
		
		MultipartFile multi = pb.getUpload();
		if(result.hasErrors()) {
			mav.setViewName(getPage);
		}else {
			int cnt = pdao.insertProducts(pb);
			if(cnt != -1) { // 상품등록 성공
				try {
					multi.transferTo(destination);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				mav.setViewName(gotoPage);
			}else { // 상품등록 실패
				mav.setViewName(getPage);
			}
		}
		return mav;
	}
}
