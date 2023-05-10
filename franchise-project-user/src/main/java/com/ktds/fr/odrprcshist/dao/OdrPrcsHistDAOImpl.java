package com.ktds.fr.odrprcshist.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.odrprcshist.vo.OdrPrcsHistVO;

@Repository
public class OdrPrcsHistDAOImpl extends SqlSessionDaoSupport implements OdrPrcsHistDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public int create(OdrPrcsHistVO odrPrcsHistVO) {
		return getSqlSession().insert("OdrPrcsHist.create", odrPrcsHistVO);
	}

}
