package com.ktds.fr.evntstr.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.evntstr.vo.EvntStrVO;
import com.ktds.fr.mbr.vo.MbrVO;

@Repository
public class EvntStrDAOImpl extends SqlSessionDaoSupport implements EvntStrDAO {
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	// 2. 이벤트 전체목록 조회 ▶▶상위관리자
	public List<EvntStrVO> readAllEvntStr(EvntStrVO evntStrVO) {
		return getSqlSession().selectList("EvntStr.readAllEvntStr", evntStrVO);
	}

	@Override
	
	// 참여매장 등록하기 ▶ 중간관리자
	public int createEvntStr(EvntStrVO evntStrVO) {
		return getSqlSession().insert("EvntStr.createEvntStr", evntStrVO );
	}

	@Override
	public int chkAlreadyCreate(EvntStrVO evntStrVO) {
		return getSqlSession().selectOne("EvntStr.chkAlreadyCreate", evntStrVO );
	}


	@Override
	public int deleteEvntStrListByEvntId(List<String> evntStrIdList) {
		return getSqlSession().update("EvntStr.deleteEvntStrListByEvntId", evntStrIdList );
	}

	@Override
	public int insertAllEvntStr(EvntStrVO evntStrVO) {
		return getSqlSession().insert("EvntStr.insertAllEvntStr", evntStrVO);
	}



}
