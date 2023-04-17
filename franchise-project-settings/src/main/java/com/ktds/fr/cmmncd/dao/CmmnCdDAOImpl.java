package com.ktds.fr.cmmncd.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.cmmncd.vo.CmmnCdVO;

@Repository
public class CmmnCdDAOImpl extends SqlSessionDaoSupport implements CmmnCdDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public List<CmmnCdVO> readCategory(String codeId) {
		return getSqlSession().selectList("CmmnCd.readCategory",codeId);
	}

}
