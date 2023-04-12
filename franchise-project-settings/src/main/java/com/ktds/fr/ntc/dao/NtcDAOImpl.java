package com.ktds.fr.ntc.dao;


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
	
	public int createNoticeTitle(String ntcTtl) {
		return getSqlSession().insert("Ntc.createNoticeTitle",ntcTtl);
	}

	public int createNoticeContent(String ntcCntnt) {
		return getSqlSession().insert("Ntc.createNoticeContent", ntcCntnt);
	}

	public int createNewNoticeContent(String ntcId) {
		return getSqlSession().insert("Ntc.createNewNoticeContent", ntcId);
		
	}

	public int updateNoticeTitle(String ntcTtl) {
		return getSqlSession().update("Ntc.updateNoticeTitle",ntcTtl);
	}

	public int updateNoticeContent(String ntcCntnt) {
		return getSqlSession().update("Ntc.updateNoticeContent",ntcCntnt);
	}

	public int deleteNoticeByNoticeId(String ntcId) {
		return getSqlSession().update("Ntc.deleteNoticeByNoticeId",ntcId);
	}


	public int readAllNoticeTitleByNoticeId(String ntcId) {
		return getSqlSession().selectOne("Ntc.readAllNoticeTitleByNoticeId",ntcId);
	}

	@Override
	public NtcVO readSelectedNoticeContent(NtcVO ntcVO) {
		return getSqlSession().selectOne("Ntc.readSelectedNoticeContent", ntcVO);
	}

	@Override
	public int readNoticeByRegisteredDate(String ntcRgstDt) {
		return getSqlSession().selectOne("Ntc.readNoticeByRegisteredDate",ntcRgstDt);
	}

}
