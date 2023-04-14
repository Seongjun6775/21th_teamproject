package com.ktds.fr.ntc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.ntc.dao.NtcDAO;
import com.ktds.fr.ntc.vo.NtcVO;

@Repository
public class NtcServiceImpl implements NtcService {
	
	@Autowired
	private NtcDAO ntcDAO;
	
	@Override
	public boolean createNoticeTitle(String ntcTtl) {
		return ntcDAO.createNoticeTitle(ntcTtl) > 0;
	}

	@Override
	public boolean createNoticeContent(String ntcCntnt) {
		return ntcDAO.createNoticeContent(ntcCntnt) > 0;
	}

	@Override
	public boolean createNewNoticeContent(String ntcId) {
		return ntcDAO.createNewNoticeContent(ntcId) > 0;
	}

	@Override
	public boolean updateNoticeTitle(String ntcTtl) {
		return ntcDAO.updateNoticeTitle(ntcTtl) > 0;
	}

	@Override
	public boolean updateNoticeContent(String ntcCntnt) {
		return ntcDAO.updateNoticeContent(ntcCntnt) > 0;
	}

	@Override
	public boolean deleteNoticeByNoticeId(String ntcId) {
		return ntcDAO.deleteNoticeByNoticeId(ntcId) > 0;
	}

	@Override
	public List<NtcVO> readAllNotice() {
		return ntcDAO.readAllNotice();
	}

	@Override
	public NtcVO readSelectedNoticeContent(String ntcCntnt) {
		return ntcDAO.readSelectedNoticeContent(ntcCntnt);
	}

	@Override
	public boolean readNoticeByRegisteredDate(String ntcRgstDt) {
		return ntcDAO.readNoticeByRegisteredDate(ntcRgstDt) > 0;
	}

}
