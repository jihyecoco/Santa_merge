package com.spring.ex.products.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.products.model.ProductsDao;

@Controller
public class ProductsListController {
	
	//private final String command = "/list.prd";
	private final String command = "product/list.prd";
	private String getPage = "productsList";
	
	@Autowired
	ProductsDao pdao;
	
	@RequestMapping(value=command)
	public ModelAndView doAction() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName(getPage);
		return mav;
	}
}
