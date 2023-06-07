package com.spring.ex.crew.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("CrewDao")
public class CrewDao {
	//private final String namespace = "crew.CrewBean";
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int checkCrewname(String input_name) {
		int cnt = -1;
		//cnt = sqlSessionTemplate.selectOne(namespace+".CheckCrewname", input_name);
		cnt = sqlSessionTemplate.selectOne("CheckCrewname", input_name);
		return cnt;
	}

	public int insertCrew(CrewBean cb) {
		int cnt = -1;
		//cnt = sqlSessionTemplate.insert(namespace+".InsertCrew", cb);
		cnt = sqlSessionTemplate.insert("InsertCrew", cb);
		return cnt;
	}

	public List<CrewBean> getCrewById(String loginid) {
		List<CrewBean> cb = new ArrayList<CrewBean>();
		//cb = sqlSessionTemplate.selectList(namespace+".GetCrewById", loginid);
		cb = sqlSessionTemplate.selectList("GetCrewById", loginid);
		return cb;
	}

	public int updateCrew(CrewBean cb) {
		int cnt = -1;
		//cnt = sqlSessionTemplate.update(namespace+".UpdateCrew", cb);
		cnt = sqlSessionTemplate.update("UpdateCrew", cb);
		return cnt;
	}
	
	
}
