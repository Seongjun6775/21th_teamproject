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
	public boolean readBlockStrNm(StrVO strVO) {
		return strDAO.readBlockStrNm(strVO) > 0;
	}
	@Override
	public boolean readBlockStrAddr(StrVO strVO) {
		return strDAO.readBlockStrAddr(strVO) > 0;
	}
	@Override
	public boolean readBlockStrCallNum(StrVO strVO) {
		return strDAO.readBlockStrCallNum(strVO) > 0;
	}

}
