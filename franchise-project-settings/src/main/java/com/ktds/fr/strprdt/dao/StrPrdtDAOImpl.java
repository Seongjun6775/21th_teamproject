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
	public int update(StrPrdtVO strPrdtVO) {
		return getSqlSession().update("StrPrdt.update", strPrdtVO);
	}

	@Override
	public int deletePrdtId(String prdtId) {
		return getSqlSession().update("StrPrdt.delete", prdtId);
	}

	@Override
	public int deletePrdtList(List<String> PrdtList) {
		return getSqlSession().update("StrPrdt.deletePrdtList", PrdtList);
	}

	@Override
	public int deleteStrId(String srtId) {
		return getSqlSession().update("StrPrdt.deleteStrId", srtId);
	}

	@Override
	public int deleteStrList(List<String> StrList) {
		return getSqlSession().update("StrPrdt.deleteStrList", StrList);
	}

	
	
}
