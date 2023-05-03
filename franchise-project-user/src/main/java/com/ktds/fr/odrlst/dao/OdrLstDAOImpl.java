package com.ktds.fr.odrlst.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.odrlst.vo.OdrLstVO;

@Repository
public class OdrLstDAOImpl extends SqlSessionDaoSupport implements OdrLstDAO {
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public List<OdrLstVO> getOdrLstIdForRv(String mbrId) {
		return getSqlSession().selectList("OdrLst.getOdrLstIdForRv", mbrId);
	}
	
	@Override
	public int createNewOdrLst(OdrLstVO odrLstVO) {
		return getSqlSession().insert("OdrLst.createNewOdrLst", odrLstVO);
	}

	@Override
	public List<OdrLstVO> readAllOdrLst(OdrLstVO odrLstVO) {
		return getSqlSession().selectList("OdrLst.readAllOdrLst", odrLstVO);
	}

	@Override
	public List<OdrLstVO> readAllMyOdrLst(OdrLstVO odrLstVO) {
		return getSqlSession().selectList("OdrLst.readAllMyOdrLst", odrLstVO);
	}

	@Override
	public OdrLstVO readOneOdrLstByOdrLstId(String odrLstId) {
		return getSqlSession().selectOne("OdrLst.readOneOdrLstByOdrLstId", odrLstId);
	}

	@Override
	public int updateOneOdrLstByOdrLstId(OdrLstVO odrLstVO) {
		return getSqlSession().update("OdrLst.updateOneOdrLstByOdrLstId", odrLstVO);
	}

	@Override
	public int deleteOneOdrLstByOdrLstId(OdrLstVO odrLstVO) {
		return getSqlSession().update("OdrLst.deleteOneOdrLstByOdrLstId", odrLstVO);
	}
	
	
}
