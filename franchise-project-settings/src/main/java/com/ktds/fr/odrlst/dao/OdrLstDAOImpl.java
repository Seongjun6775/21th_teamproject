package com.ktds.fr.odrlst.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.odrdtl.vo.OdrDtlVO;

@Repository
public class OdrLstDAOImpl extends SqlSessionDaoSupport implements OdrLstDAO {
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
//	@Override
//	public List<OdrDtlVO> readAllOdrDtlByOdrLstId(String odrLstId) {
//		return null;
//	}
	
}
