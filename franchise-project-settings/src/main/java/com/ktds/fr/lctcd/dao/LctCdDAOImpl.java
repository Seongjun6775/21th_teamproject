package com.ktds.fr.lctcd.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.lctcd.vo.LctCdVO;

@Repository
public class LctCdDAOImpl extends SqlSessionDaoSupport implements LctCdDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public List<LctCdVO> readCategory(LctCdVO lctCdVO) {
		return getSqlSession().selectList("LctCd.readCategory",lctCdVO);
	}

}
