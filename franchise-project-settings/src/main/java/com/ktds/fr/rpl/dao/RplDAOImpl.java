package com.ktds.fr.rpl.dao;

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
	public int createNewRpl(RplVO rplVO) {
		return getSqlSession().insert("Rpl.createNewReply", rplVO);
	}

	@Override
	public int updateOneRpl(RplVO rplVO) {
		return getSqlSession().update("Rpl.updateOneReply", rplVO);
	}

	@Override
	public int deleteOneRplByRplId(String rplId) {
		return getSqlSession().update("Reply.deleteOneReplyById", rplId);
	}

}
