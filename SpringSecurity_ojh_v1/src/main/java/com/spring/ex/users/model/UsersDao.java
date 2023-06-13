package com.spring.ex.users.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("UsersDao")
public class UsersDao {
	
	private static final Logger logger = LoggerFactory.getLogger(UsersDao.class);
	private final String NAMESPACE = "users";
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	//getInfo : 로그인한 사용자의 정보가져오기
	public UsersBean getInfo(String userId) {
		UsersBean loginInfo = new UsersBean();
		loginInfo.setUserId(userId);
		loginInfo = sqlSessionTemplate.selectOne(NAMESPACE+".logingetInfo", loginInfo);
		
		return loginInfo;
	}//getInfo

	//insertUser : 회원가입
	public int insertUser(UsersBean userBean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(NAMESPACE+".insertUser", userBean);
		System.out.println("udao insertUser cnt : " + cnt);
		return cnt;
		
	}//insertUser

	//checkDuplicateUserId : 아이디 중복체크
	public int checkDuplicateUserId(String input_userId) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(NAMESPACE+".checkDuplicateUserId", input_userId);
		return cnt;
	}

}//UsersDAO
