package com.ktds.fr.mngrbrd.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.mngrbrd.vo.MngrBrdVO;
@Repository
public class MngrBrdDAOImpl extends SqlSessionDaoSupport implements MngrBrdDAO {
	
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public List<MngrBrdVO> readAllMngrBrds() {
		return getSqlSession().selectList("MngrBrd.readAllMngrBrds");
	}

	@Override
	public MngrBrdVO readOneMngrBrdByMngrBrdId(String mngrBrdId) {
		return getSqlSession().selectOne("MngrBrd.readOneMngrBrdByMngrBrdId", mngrBrdId);
	}

	@Override
	public int createNewMngrBrd(MngrBrdVO mngrBrdVO) {
		return getSqlSession().insert("MngrBrd.createNewMngrBrd", mngrBrdVO);
	}

	@Override
	public int updateOneMngrBrd(MngrBrdVO mngrBrdVO) {
		return getSqlSession().update("MngrBrd.updateOneMngrBrd", mngrBrdVO);
	}

	@Override
	public int deleteOneMngrBrd(String mngrBrdId) {
		return getSqlSession().update("MngrBrd.deleteOneMngrBrd", mngrBrdId);
	}

}
