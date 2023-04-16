package com.ktds.fr.strprdt.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.strprdt.vo.StrPrdtVO;

@Repository
public class StrPrdtDAOImpl extends SqlSessionDaoSupport implements StrPrdtDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public List<StrPrdtVO> readAll(String strPrdtId) {
		return getSqlSession().selectList("StrPrdt.readAll", strPrdtId);
	}

	@Override
	public int create(List<StrPrdtVO> strPrdtList) {
		return getSqlSession().insert("StrPrdt.create", strPrdtList);
	}

	@Override
	public int delete(String srtPrdtId) {
		return getSqlSession().update("StrPrdt.delete", srtPrdtId);
	}

	
	
}
