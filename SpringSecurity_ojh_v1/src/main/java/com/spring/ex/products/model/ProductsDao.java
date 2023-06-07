package com.spring.ex.products.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ProductsDao {
	//private final String namespace ="products.ProductsBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public int insertProducts(ProductsBean pb) {
		int cnt = -1;
		//cnt = sqlSessionTemplate.insert(namespace+".InsertProducts", pb);
		cnt = sqlSessionTemplate.insert("InsertProducts", pb);
		return cnt;
	}
	
}
