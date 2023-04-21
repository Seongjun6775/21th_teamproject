package com.ktds.fr.odrdtl.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.odrdtl.vo.OdrDtlVO;

@Repository
public class OdrDtlDAOImpl extends SqlSessionDaoSupport implements OdrDtlDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public int createNewOdrDtl(OdrDtlVO odrDtlVO) {
		return getSqlSession().insert("OdrDtl.createNewOdrDtl", odrDtlVO);
	}
	
	@Override
	public List<OdrDtlVO> readAllOdrDtlByOdrLstId(String mbrId) {
		return getSqlSession().selectList("OdrDtl.readAllOdrDtlByOdrLstId", mbrId);
	}

	@Override
	public OdrDtlVO readOneOdrDtlByOdrDtlId(String odrDtlId) {
		return getSqlSession().selectOne("OdrDtl.readOneOdrDtlByOdrDtlId", odrDtlId);
	}

	@Override
	public int updateOneOdrDtlByOdrDtlId(String odrDtlId) {
		return getSqlSession().update("OdrDtl.updateOneOdrDtlByOdrDtlId", odrDtlId);
	}

	@Override
	public int deleteOneOdrDtlByOdrDtlId(String odrDtlId) {
		return getSqlSession().delete("OdrDtl.deleteOneOdrDtlByOdrDtlId", odrDtlId);
	}
	
	
	
}
