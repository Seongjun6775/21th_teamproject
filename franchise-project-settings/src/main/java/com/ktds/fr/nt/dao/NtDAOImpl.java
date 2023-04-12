package com.ktds.fr.nt.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.nt.vo.NtVO;

@Repository
public class NtDAOImpl extends SqlSessionDaoSupport implements NtDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public int createNewNt(NtVO ntVO) {
		return getSqlSession().insert("Nt.createNewNt", ntVO);
	}

	@Override
	public List<NtVO> readAllNt() {
		return getSqlSession().selectList("Nt.readAllNt");
	}

	@Override
	public int updateOneNtByNtId(String ntId) {
		return getSqlSession().update("Nt.updateOneNtByNtId", ntId);
	}

	@Override
	public int deleteOneNtByNtId(String ntId) {
		return getSqlSession().update("Nt.deleteOneNtByNtId", ntId);
	}
	
	@Override
	public int deleteNtBySelectedNtId(List<String> ntId) {
		return getSqlSession().update("Nt.deleteNtBySelectedNtId", ntId);
	}
	
	@Override
	public NtVO readOneNtByNtId(String ntId) {
		return getSqlSession().selectOne("Nt.readOneNtByNtId", ntId);
	}
	
}