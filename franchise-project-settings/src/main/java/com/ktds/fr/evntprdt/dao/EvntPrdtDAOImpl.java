package com.ktds.fr.evntprdt.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.evntprdt.vo.EvntPrdtVO;

@Repository
public class EvntPrdtDAOImpl extends SqlSessionDaoSupport implements EvntPrdtDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	// 이벤트 적용 품목 확인 ▷상위관리자,중간관리자
	public List<EvntPrdtVO> readAllEvntPrdt(EvntPrdtVO evntPrdtVO) {
		return getSqlSession().selectList("EvntPrdt.readAllEvntPrdt", evntPrdtVO );
	}

}
