package com.spring.ex.users.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.users.model.UsersDao;

@Controller
public class UsersFindUserIdController {

	private final String command ="/login/all/findUserId.lg";
	private String getPage = "/login/findIdPage"; //아아디 찾기 페이지
	
	@Autowired
	UsersDao udao;
	
	//loginPage에서 회원가입 클릭 -> command(/login/all/signUp.lg)
	@RequestMapping(value=command, method = RequestMethod.GET)
	public ModelAndView findIdPage() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName(getPage);// /login/all/findUserId.lg
		return mav; 
		
	}//signUpPage
}//UsersFindUserIdController
