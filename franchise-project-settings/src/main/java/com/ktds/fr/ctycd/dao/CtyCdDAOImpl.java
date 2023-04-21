package com.ktds.fr.ctycd.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.ctycd.vo.CtyCdVO;

@Repository
public class CtyCdDAOImpl extends SqlSessionDaoSupport implements CtyCdDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public List<CtyCdVO> readCategory(CtyCdVO ctyCdVO) {
		return getSqlSession().selectList("Cty.readCategory",ctyCdVO);
	}

}
