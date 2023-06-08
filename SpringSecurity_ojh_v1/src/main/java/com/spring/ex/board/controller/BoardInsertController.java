package com.spring.ex.board.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.board.model.BoardBean;
import com.spring.ex.board.model.BoardDao;

@Controller
public class BoardInsertController {
	
	private final String command = "/board/user/insert.br";
	private final String getPage = "/board/boardInsertForm";
	private final String gotoPage = "redirect:/board/all/list.br";
	
	@Autowired
	BoardDao bdao;
	
	@Autowired
	ServletContext servletContext; 
	
	
	//boardList.jsp(목록에서 글쓰기 버튼 클릭) -> insert.br 요청(get방식) -> boardInsertForm.jsp로 이동
	@RequestMapping(value=command, method = RequestMethod.GET) //폼 요청
	public ModelAndView insert(@RequestParam("pageNumber") String pageNumber, Model model) {
		ModelAndView mav = new ModelAndView();
		model.addAttribute("pageNumber",pageNumber);
		mav.setViewName(getPage);
		return mav;
	}
	
	
	//boardInsertForm.jsp(글쓰기 버튼 클릭) -> detail.br 요청(post방식) -> 삽입성공시 boardList.jsp로 이동
	@RequestMapping(value=command, method = RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute("board") @Valid BoardBean board,
			BindingResult result, HttpServletRequest request) {
		
		String uploadPath = servletContext.getRealPath("/resources");
		System.out.println("uploadPath: "+uploadPath);
		File destination = new File(uploadPath + File.separator + board.getUpload().getOriginalFilename());
		System.out.println("destination: "+destination);
		MultipartFile multi = board.getUpload();
		
		ModelAndView mav = new ModelAndView();
		
		System.out.println("result.hasErrors(): "+result.hasErrors()); 
		if(result.hasErrors()) { //에러 있음
			mav.setViewName(getPage);
		}
		else { //에러 없음
			int cnt = bdao.insertBoard(board);
			System.out.println("cnt: "+cnt);
			
			if(cnt != -1) { //삽입 성공
				try {
					multi.transferTo(destination);
					
				} catch (IllegalStateException e) {				
					e.printStackTrace();
				} catch (IOException e) {				
					e.printStackTrace();
				} 
				mav.setViewName(gotoPage);
			}else { //삽입 실패
				mav.setViewName(getPage);	
			}			
		}//else
		
		return mav;
	}//
	
	
	
}
