package com.spring.ex.crewboard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.crewboard.model.CrewBoardBean;
import com.spring.ex.crewboard.model.CrewBoardDao;


@Controller
public class CrewBoardDetailController {
	
	//private final String command = "/detail.bdcr";
	private final String command = "/crewboard/user/detail.bdcr";
	private String getPage = "/crewboard/crewboardDetailView";
	
	@Autowired
	CrewBoardDao cbdao;
	
	//crewboardList.jsp(제목클릭)에서 요청
	//글의 num이 같이 넘어온다.
	@RequestMapping(value=command)
	public ModelAndView doAction(@RequestParam("num") int num) {
		
		ModelAndView mav = new ModelAndView();
		//1. 비회원일때(로그인 페이지로)
		
		//2. 회원일때
		CrewBoardBean cbb = cbdao.getCrewboardByNum(num);
		mav.addObject("cbb", cbb);
		mav.setViewName(getPage);
		return mav;
	}
	
}
