package com.spring.ex.qna.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.spring.ex.utility.Paging;

@Component
public class QnaDao {
	
	//Qna namespace
	//private String namespace = "qna.QnaBean";
	
	//Sqlsessiontemplate 객체 생성
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public QnaDao() {
		System.out.println("QnaDao() 생성자");
	}//QnaDao 생성자 end
	
	//튜플 전체 갯수 구하기
	public int getTotalCount(Map<String, String> map) {
		int cnt =1;
		//int cnt = sqlSessionTemplate.selectOne(namespace+".GetTotalCount",map);
		//int cnt = sqlSessionTemplate.selectOne("GetTotalCount",map);
		return cnt;
	}//getTotalCount end

	//튜플 전체 목록 구하기
	public List<QnaBean> getAllQna(Map<String, String> map, Paging pageInfo) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		//List<QnaBean> qnaList = sqlSessionTemplate.selectList(namespace+".GetAllQna",map,rowBounds);
		List<QnaBean> qnaList = sqlSessionTemplate.selectList("GetAllQna",map,rowBounds);
		return qnaList;
	}//getAllQna end

	//새로운 튜플 삽입
	public int insertQ(QnaBean qnaBean) {
		//int cnt = sqlSessionTemplate.insert(namespace+".InsertQ",qnaBean);
		int cnt = sqlSessionTemplate.insert("InsertQ",qnaBean);
		return cnt;
	}//insertQna end
	
	
	
	
}
