package com.ktds.fr.odrdtl.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.odrdtl.vo.OdrDtlVO;
import com.ktds.fr.rv.vo.RvVO;

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

	@Override
	public List<OdrDtlVO> forSale(OdrDtlVO odrDtlVO) {
		return getSqlSession().selectList("OdrDtl.forSale", odrDtlVO);
	}

	@Override
	public List<OdrDtlVO> group(OdrDtlVO odrDtlVO) {
		return getSqlSession().selectList("OdrDtl.group", odrDtlVO);
	}
	
	@Override
	public List<OdrDtlVO> groupPrdt(OdrDtlVO odrDtlVO) {
		return getSqlSession().selectList("OdrDtl.groupPrdt", odrDtlVO);
	}
	
	@Override
	public List<OdrDtlVO> groupSrtCdId(OdrDtlVO odrDtlVO) {
		return getSqlSession().selectList("OdrDtl.groupSrtCdId", odrDtlVO);
	}
	
	@Override
	public List<OdrDtlVO> groupStr(OdrDtlVO odrDtlVO) {
		return getSqlSession().selectList("OdrDtl.groupStr", odrDtlVO);
	}

	@Override
	public List<OdrDtlVO> startEnd(OdrDtlVO odrDtlVO) {
		return getSqlSession().selectList("OdrDtl.startEnd", odrDtlVO);
	}
	
	@Override
	public List<OdrDtlVO> oneMonth(OdrDtlVO odrDtlVO) {
		return getSqlSession().selectList("OdrDtl.oneMonth", odrDtlVO);
	}

	@Override
	public List<OdrDtlVO> viewStrPayments(OdrDtlVO odrDtlVO) {
		return getSqlSession().selectList("OdrDtl.viewStrPayments", odrDtlVO);
	}
	
	@Override
	public List<OdrDtlVO> sumMonth(OdrDtlVO odrDtlVO) {
		return getSqlSession().selectList("OdrDtl.sumMonth", odrDtlVO);
	}
	
	@Override
	public List<OdrDtlVO> sumYear(OdrDtlVO odrDtlVO) {
		return getSqlSession().selectList("OdrDtl.sumYear", odrDtlVO);
	}
	
	// 2-5.상세 조회에서 주문서 ID의 개수 받아오기 == 상위관리자, 중간관리자, 하위관리자, 이용자
	@Override
	public int readCountOdrLstId(OdrDtlVO odrDtlVO) {
		return getSqlSession().selectOne("Rv.readCountOdrLstId", odrDtlVO);
	}
	
}
