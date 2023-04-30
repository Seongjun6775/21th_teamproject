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
	public int deleteOneOdrDtlByOdrDtlId(OdrDtlVO odrDtlVO) {
		return getSqlSession().update("OdrDtl.deleteOneOdrDtlByOdrDtlId", odrDtlVO);
	}
	
	@Override
	public int deleteAllOdrDtlByOdrLstId(OdrDtlVO odrDtlVO) {
		return getSqlSession().update("OdrDtl.deleteAllOdrDtlByOdrLstId", odrDtlVO);
	}
	
	@Override
	public int deleteOdrDtlBySelectedDtlId(List<String> odrDtlId) {
		return getSqlSession().update("OdrDtl.deleteOdrDtlBySelectedDtlId", odrDtlId);
	}

	@Override
	public List<OdrDtlVO> odrDtlForOdrLst(String odrDtlId) {
		return getSqlSession().selectList("OdrDtl.odrDtlForOdrLst", odrDtlId);
	}
	
}
