package com.ktds.fr.ntc.dao;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.ntc.vo.NtcVO;

@Repository
public class NtcDAOImpl extends SqlSessionDaoSupport implements NtcDAO {
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public int createNotice(NtcVO ntcVO) {
		return getSqlSession().insert("Ntc.createNotice", ntcVO);
	}

	@Override
	public int updateNotice(NtcVO ntcVO) {
		return getSqlSession().update("Ntc.updateNotice", ntcVO);
	}

	@Override
	public int deleteNotice(String ntcId) {
		return getSqlSession().update("Ntc.deleteNotice",ntcId);
	}

	@Override
	public List<NtcVO> readDetailNotice(NtcVO ntcVO) {
		return getSqlSession().selectList("Ntc.readDetailNotice", ntcVO);
	}

	@Override
	public List<NtcVO> readTotalNotice(NtcVO ntcVO) {
		return getSqlSession().selectList("Ntc.readTotalNotice", ntcVO);
	}

	
}
