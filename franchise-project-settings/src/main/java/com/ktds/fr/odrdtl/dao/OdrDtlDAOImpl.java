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
	public List<OdrDtlVO> readAllOdrDtlByOdrLstIdAndMbrId(OdrDtlVO odrDtlVO) {
		return getSqlSession().selectList("OdrDtl.readAllOdrDtlByOdrLstIdAndMbrId", odrDtlVO);
	}

	@Override
	public OdrDtlVO readOneOdrDtlByOdrDtlId(String odrDtlId) {
		return getSqlSession().selectOne("OdrDtl.readOneOdrDtlByOdrDtlId", odrDtlId);
	}
	
	@Override
	public int updateOneOdrDtlByOdrDtlId(OdrDtlVO odrDtlVO) {
		return getSqlSession().update("OdrDtl.updateOneOdrDtlByOdrDtlId", odrDtlVO);
	}

	@Override
	public int deleteOneOdrDtlByOdrDtlId(String odrDtlId) {
		return getSqlSession().update("OdrDtl.deleteOneOdrDtlByOdrDtlId", odrDtlId);
	}
	
	@Override
	public int deleteAllOdrDtlByOdrLstId(String odrLstId) {
		return getSqlSession().update("OdrDtl.deleteAllOdrDtlByOdrLstId", odrLstId);
	}
	
	@Override
	public int deleteOdrDtlBySelectedDtlId(List<String> odrDtlId) {
		return getSqlSession().update("OdrDtl.deleteOdrDtlBySelectedDtlId", odrDtlId);
	}
	
}
