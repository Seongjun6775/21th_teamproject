package com.ktds.fr.str.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
	public boolean createOneStr(StrVO strVO, MultipartFile uploadFil) {
		return strDAO.createOneStr(strVO) > 0;
	}

	@Override
	public boolean updateOneStrByMaster(StrVO strVO, MultipartFile uploadFile) {
		return strDAO.updateOneStrByMaster(strVO) > 0;
	}

	@Override
	public boolean updateOneStrByManager(StrVO strVO, MultipartFile uploadFile) {
		return strDAO.updateOneStrByManager(strVO) > 0;
	}

	@Override
	public boolean deleteOneStrByStrId(String strId) {
		return strDAO.deleteOneStrByStrId(strId) > 0;
	}

}
