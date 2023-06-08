package com.spring.ex.notice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.ex.notice.model.NoticeBean;
import com.spring.ex.notice.model.NoticeDao;

@Controller
public class NoticeDetailController {
	
	private final String command = "/notice/all/detail.no";
	private final String getPage = "/notice/noticeDetailView";
	
	@Autowired
	NoticeDao ndao;
	
	
	//noticeList.jsp(글제목 클릭) -> detail.no 요청 -> noticeDetailView.jsp로 이동
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String detail(@RequestParam("num") int num, 
			@RequestParam("pageNumber") int pageNumber, Model model) {		
		
		int cnt = ndao.updateCount(num); //글 클릭하면 조회수 1 증가하도록
				
		NoticeBean notice = ndao.getNoticeByNum(num);
		model.addAttribute("notice", notice);
		model.addAttribute("pageNumber",pageNumber);
		
		return getPage;
	}
	
}
