package com.spring.ex.qna.controller;


import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.ex.qna.model.QnaBean;
import com.spring.ex.qna.model.QnaDao;

@Controller
public class QnaInsertQController {
	
	//요청 값을 담은 변수
	private final String command = "/qna/user/insertq.qna";
	//이동할 jsp 페이지 변수
	private String getPage = "/qna/user/qnaInsertQForm";
	//redirect할 요청 변수
	private String gotoPage = "redirect:/qna/list.qna";
	
	//qnaDao 객체 생성
	@Autowired
	QnaDao qdao;
	
	//uploadPath를 가져오기 위한 ServletContext 객체 생성
	@Autowired
	ServletContext servletContext;
	
	//qna 목록 => 질문하기 버튼 클릭 시
	@RequestMapping(value=command, method=RequestMethod.GET)
	public ModelAndView doAction(HttpSession session) {
		
		//로그인 정보 출력 테스트
		System.out.println(session.getAttribute("loginInfo"));

		//ModelAndView 객체 생성
		ModelAndView mav = new ModelAndView(); 
		
		if(session.getAttribute("loginInfo")==null) {
			//로그인 정보가 없으면
			//로그인 페이지로 넘어가서 다시 insert.qna 요청으로 돌아오도록 세션 설정
			session.setAttribute("destination","redirect:/qna/insertq.qna");
			//로그인 페이지로 이동하도록 뷰 설정
			mav.setViewName("redirect:/login/loginPage.lg");
		}else {
			//로그인 정보가 있으면
			//qna 작성 페이지로 이동
			mav.setViewName(getPage);
		}
		return mav;
	}
	
	//qnaInsertQForm에서 => 질문등록 버튼 클릭시
	@RequestMapping(value=command, method=RequestMethod.POST)
	public ModelAndView doAction(
			@ModelAttribute("qnaBean") @Valid QnaBean qnaBean,
			BindingResult result, HttpSession session
			) {
		
		//ModelAndView 객체 생성
		ModelAndView mav = new ModelAndView(); 
		
		//이미지 파일이 올라갈 경로 변수에 저장, 테스트 출력
		String uploadPath = servletContext.getRealPath("/resources");
		System.out.println("uploadPath:"+uploadPath);
		
		//업로드 경로에 저장된 원본 파일 이름 File 객체 변수에 저장, 테스트 출력
		File destination = new File(uploadPath+File.separator+qnaBean.getUpload().getOriginalFilename());
		System.out.println("destination:"+uploadPath+File.separator+qnaBean.getUpload().getOriginalFilename());
		
		//업로드한 파일의 정보를 담는 MultipartFile 객체 생성
		MultipartFile multi = qnaBean.getUpload();
		
		if(result.hasErrors()) {
			//유효성 검사에 에러가 있으면
			//뷰 설정, 다시 qnaInsertQForm으로 돌아감
			mav.setViewName(getPage);
		} else {
			//유효성 검사에 에러가 없으면
			//qnaBean.setUsersid(session.getAttribute("loginInfo").getUsersid());
			
			//qdao의 insertQ 메서드 결과를 cnt에 저장
			int cnt = qdao.insertQ(qnaBean);
			
			if(cnt > 0) {
				//insert 성공 시
				
				//Byte형태의 데이터를 File객체에 설정한 파일 경로에 전송
				try {
					multi.transferTo(destination);
				} catch(IllegalStateException e) {
					e.printStackTrace();
				} catch(IOException e) {
					e.printStackTrace();
				}//try~catch end
				
				//뷰 설정, list.qna를 다시 요청
				mav.setViewName(gotoPage);
			} else {
				//insert 실패 시
				
				//뷰 설정, 다시 qnaInsertQForm으로 돌아감
				mav.setViewName(getPage);
				
			}//if~else end
		}//if~else end
		    
		//mav 반환
		return mav;
	}
	
}
