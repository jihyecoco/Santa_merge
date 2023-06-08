package com.spring.ex.crewcomments.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CrewCommentsDao {
	//private final String namespace = "crewcomments.CrewCommentsBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public int insertCrewComments(CrewCommentsBean cmtb) {
		int cnt = -1;
		//cnt = sqlSessionTemplate.insert(namespace+".InsertCrewComments", cmtb);
		cnt = sqlSessionTemplate.insert("InsertCrewComments", cmtb);
		return cnt;
	}

	public List<CrewCommentsBean> getCrewCommentsByIdx(int idx) {
		List<CrewCommentsBean> comments = new ArrayList<CrewCommentsBean>();
		//comments = sqlSessionTemplate.selectList(namespace+".GetCrewCommentsByIdx", idx);
		comments = sqlSessionTemplate.selectList("GetCrewCommentsByIdx", idx);
		return comments;
	}

	public int replyCrewComments(CrewCommentsBean ccmt_bean) {
		//1. 원래 댓글 re_step 수정
		int cnt = -1;
		//cnt = sqlSessionTemplate.update(namespace+".UpdateOrginComment", ccmt_bean);
		cnt = sqlSessionTemplate.update("UpdateOrginComment", ccmt_bean);
		if(cnt != -1) { // 수정 성공
			//2. 답 댓글 insert
			int re_step = ccmt_bean.getRestep()+1;
			ccmt_bean.setRestep(re_step);
			int re_level = ccmt_bean.getRelevel()+1;
			ccmt_bean.setRelevel(re_level);
			
			//cnt = sqlSessionTemplate.insert(namespace +".InsertReplyCrewComments", ccmt_bean);
			cnt = sqlSessionTemplate.insert("InsertReplyCrewComments", ccmt_bean);
		}
		return cnt;
	}
}
