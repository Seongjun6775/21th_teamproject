package com.ktds.fr.evntprdt.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.evntprdt.vo.EvntPrdtVO;
import com.ktds.fr.prdt.vo.PrdtVO;

@Repository
public class EvntPrdtDAOImpl extends SqlSessionDaoSupport implements EvntPrdtDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	// 1. 이벤트 적용 품목 확인  ▶▶최상위관리자 ▷▷중간관리자 001-01, 001-02
	public List<EvntPrdtVO> readAllEvntPrdt(EvntPrdtVO evntPrdtVO) {
		return getSqlSession().selectList("EvntPrdt.readAllEvntPrdt", evntPrdtVO );
	}

	@Override
	// 2. 이벤트상품 등록을 위한 전체 상품리스트 가져오기 ▶▶최상위관리자 001-01
	public List<EvntPrdtVO> readAllPrdt(EvntPrdtVO evntPrdtVO) {
		return getSqlSession().selectList("EvntPrdt.readAllprdt", evntPrdtVO);
	}

	@Override
	// 3. 이벤트상품 등록 ▶▶최상위관리자 001-01
	public int createEvntPrdt(EvntPrdtVO evntPrdtVO) {
		return getSqlSession().insert("EvntPrdt.createEvntPrdt", evntPrdtVO);
	}

	@Override
	// 4. 이벤트 기간 내 동일 상품 이벤트 등록 중복 방지  ▶▶최상위관리자 001-01
	public List<EvntPrdtVO> chkEvntPrdt(EvntPrdtVO evntPrdtVO) {
		return getSqlSession().selectList("EvntPrdt.chkEvntPrdt", evntPrdtVO);
	}
	
	@Override
	// 5. 이벤트 상품 등록 해제  ▶▶최상위관리자 001-01
	public int deleteEvntPrdtListByEvntId(List<String> evntPrdtIdList) {
		return getSqlSession().update("EvntPrdt.deleteEvntPrdtListByEvntId",evntPrdtIdList );
	}

	@Override
	// 6. 체크된 이벤트 상품 일괄(개별) 등록 ▶▶최상위관리자 001-01
	public int createEvntPrdtListByEvntId(List<EvntPrdtVO> evntPrdtList) {
		return getSqlSession().insert("EvntPrdt.createEvntPrdtListByEvntId", evntPrdtList);
	}

}
