package com.spring.ex.users.controller;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.login.controller.LoginController;
import com.spring.ex.users.model.UsersBean;
import com.spring.ex.users.model.UsersDao;

@Controller
public class UsersSignUpController {
	/* 회원가입 컨트롤러 자체는 users 폴더 밑에 위치시키고, 해당 기능에 접근 가능한 URL 경로를 로그인과 관련된 경로로 정의하는 것이 일반적인 구조  
	 * 로그인과 관련된 기능인 회원가입을 /login 경로 아래에 두고, 모든 사용자를 의미하는 all이라는 경로를 사용하여 구분하는 방식
	 */
	private final String command ="/login/all/signUp.lg";
	private String getPage = "/users/signUpPage"; //회원가입 페이지
	private String gotoPage = "/login/loginPage";//로그인 페이지
	
	@Autowired
	UsersDao udao;
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	//loginPage에서 회원가입 클릭 -> command(/login/all/signUp.lg)
	@RequestMapping(value=command, method = RequestMethod.GET)
	public ModelAndView signUpPage() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName(getPage);// /users/signUpPage
		return mav; 
		
	}//signUpPage
	
	//command(/login/all/signUp.lg)에서 회원가입정보 입력 후 submit 클릭했을 때
	@ResponseBody
	@RequestMapping(value=command, method = RequestMethod.POST)
	public ModelAndView signUpPage(@ModelAttribute("userBean") @Valid UsersBean userBean,
			BindingResult result) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("userBean", userBean);
		
		//사용자가 입력한 회원정보에 error 있을 경우
		if(result.hasErrors()) {
			mav.setViewName(getPage);// /users/signUpPage
			//String message = "<script>alert('정보가 올바르지않습니다.');location.href='/login/all/signUp.lg';</script>";
			//mav.addObject("message", message);
			
		}else {
			//사용자가 입력한 회원정보에 error 없을 경우
			int cnt = udao.insertUser(userBean);
			String message = "";
			if(cnt>0) {
				//회원가입 성공
				message = "회원가입에 성공하였습니다. 로그인페이지로 이동합니다.";
				mav.addObject("message", message);
				mav.setViewName(gotoPage); // /login/all/signUp.lg
			}else {
				//회원가입 실패
				message = "회원가입에 실패하였습니다.";
				mav.addObject("message", message);
				mav.setViewName(getPage); // /users/signUpPage
			}
		}
		return mav; 
		
	}//signUpPage
}//UsersSignUpController
