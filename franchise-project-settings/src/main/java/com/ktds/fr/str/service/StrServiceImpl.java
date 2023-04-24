package com.ktds.fr.str.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.str.dao.StrDAO;
import com.ktds.fr.str.vo.StrVO;

@Service
public class StrServiceImpl implements StrService {

	@Autowired
	private StrDAO strDAO;
	
	@Override
	public List<StrVO> readAllStrMaster(StrVO strVO) {
		return strDAO.readAllStrMaster(strVO);
	}

	@Override
	public StrVO readOneStrByMaster(String strId) {
		return strDAO.readOneStrByMaster(strId);
	}

	@Override
	public StrVO readOneStrByManager(String strId) {
		return strDAO.readOneStrByManager(strId);
	}

	@Override
	public boolean createOneStr(StrVO strVO) {
		return strDAO.createOneStr(strVO) > 0;
	}

	@Override
	public boolean updateOneStrByMaster(StrVO strVO) {
		return strDAO.updateOneStrByMaster(strVO) > 0;
	}

	@Override
	public boolean updateOneStrByManager(StrVO strVO) {
		return strDAO.updateOneStrByManager(strVO) > 0;
	}

	@Override
	public boolean deleteOneStrByStrId(String strId) {
		return strDAO.deleteOneStrByStrId(strId) > 0;
	}

	@Override
	public boolean readBlockStrNm(String strNm) {
		return strDAO.readBlockStrNm(strNm) > 0;
	}
	@Override
	public boolean readBlockStrAddr(String strAddr) {
		return strDAO.readBlockStrAddr(strAddr) > 0;
	}
	@Override
	public boolean readBlockStrCallNum(String strCallNum) {
		return strDAO.readBlockStrCallNum(strCallNum) > 0;
	}

	@Override
	public boolean readBlockStrByMan(String strId) {
		return strDAO.readBlockStrByMan(strId) > 0;
	}
	
	/**
	 * 회원기능과 연동
	 */
	@Override
	public List<StrVO> readAllStrNoPagenate(StrVO strVO) {
		return strDAO.readAllStrNoPagenate(strVO);
	}
	
}

