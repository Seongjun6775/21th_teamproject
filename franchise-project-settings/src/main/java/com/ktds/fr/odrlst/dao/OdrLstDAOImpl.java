package com.ktds.fr.odrlst.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.odrdtl.vo.OdrDtlVO;
import com.ktds.fr.odrlst.vo.OdrLstVO;

@Repository
public class OdrLstDAOImpl extends SqlSessionDaoSupport implements OdrLstDAO {
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public int checkRemainOdrLst(OdrDtlVO odrDtlVO) {
		return getSqlSession().selectOne("OdrLst.checkRemainOdrLst", odrDtlVO);
	}
	
	@Override
	public OdrLstVO getOdrLstId(OdrDtlVO odrDtlVO) {
		return getSqlSession().selectOne("OdrLst.getOdrLstId", odrDtlVO);
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
	public OdrLstVO getOdrPrcs(String odrLstId) {
		return getSqlSession().selectOne("OdrLst.getOdrPrcs", odrLstId);
	}
	
	/**
	 * 주문서 ID를 기준으로 그 주문서를 생성한 회원의 ID를 받아옵니다.
	 */
	@Override
	public OdrLstVO isThisMyOdrLst(String odrLstId) {
		return getSqlSession().selectOne("OdrLst.isThisMyOdrLst", odrLstId);
	}

	@Override
	public OdrLstVO readOneOdrLstByOdrLstId(String odrLstId) {
		return getSqlSession().selectOne("OdrLst.readOneOdrLstByOdrLstId", odrLstId);
	}

	@Override
	public int updateOdrPrcsToReadyByOdrLstId(String odrLstId) {
		return getSqlSession().update("OdrLst.updateOdrPrcsToReadyByOdrLstId", odrLstId);
	}

	@Override
	public int deleteOneOdrLstByOdrLstId(String odrLstId) {
		return getSqlSession().update("OdrLst.deleteOneOdrLstByOdrLstId", odrLstId);
	}
	
	@Override
	public int deleteOdrLstBySelectedLstId(List<String> odrLstId) {
		return getSqlSession().update("OdrLst.deleteOdrLstBySelectedLstId", odrLstId);
	}

	@Override
	public List<OdrLstVO> readAllOdrLstForStr(OdrLstVO odrLstVO) {
		return getSqlSession().selectList("OdrLst.readAllOdrLstForStr", odrLstVO);
	}

	@Override
	public int updateCheckAll(OdrLstVO odrLstVO) {
		return getSqlSession().update("OdrLst.updateCheckAll", odrLstVO);
	}

	@Override
	public List<OdrLstVO> completeOdrForStr(OdrLstVO odrLstVO) {
		return getSqlSession().selectList("OdrLst.completeOdrForStr", odrLstVO);
	}

	
	
}
