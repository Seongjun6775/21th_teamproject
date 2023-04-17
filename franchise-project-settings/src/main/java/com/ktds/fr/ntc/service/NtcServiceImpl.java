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
	public boolean createNotice(NtcVO ntcVO) {
		return ntcDAO.createNotice(ntcVO) > 0;
	}

	@Override
	public boolean updateNotice(NtcVO ntcVO) {
		return ntcDAO.updateNotice(ntcVO) > 0;
	}

	@Override
	public boolean deleteNotice(String ntcId) {
		return ntcDAO.deleteNotice(ntcId) > 0;
	}

	@Override
	public List<NtcVO> readDetailNotice(NtcVO ntcVO) {
		return ntcDAO.readDetailNotice(ntcVO);
	}

	@Override
	public List<NtcVO> readTotalNotice(NtcVO ntcVO) {
		return ntcDAO.readTotalNotice(ntcVO);
	}
	
	
}
