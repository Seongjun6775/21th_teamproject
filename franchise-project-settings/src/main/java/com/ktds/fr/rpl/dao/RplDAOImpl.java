package com.ktds.fr.rpl.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.rpl.vo.RplVO;
@Repository
public class RplDAOImpl extends SqlSessionDaoSupport implements RplDAO {
	

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public List<RplVO> readAllRpls(RplVO rplVO) {
		return getSqlSession().selectList("Rpl.readAllRpls", rplVO);
	}

	@Override 
	public int createNewRpl(RplVO rplVO) {
		return getSqlSession().insert("Rpl.createNewRpl", rplVO);
	}

	@Override
	public int updateOneRpl(RplVO rplVO) {
		return getSqlSession().update("Rpl.updateOneRpl", rplVO);
	}

	@Override
	public int deleteOneRplByRplId(String rplId) {
		return getSqlSession().update("Rpl.deleteOneRplByRplId", rplId);
	}

	@Override  
	public int deleteRplBySelectedRplId(List<String> rplId) {
		return getSqlSession().update("Rpl.deleteRplBySelectedRplId", rplId);
	}

}
