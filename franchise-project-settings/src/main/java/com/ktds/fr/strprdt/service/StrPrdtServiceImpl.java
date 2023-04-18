package com.ktds.fr.strprdt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.strprdt.dao.StrPrdtDAO;
import com.ktds.fr.strprdt.vo.StrPrdtVO;

@Service
public class StrPrdtServiceImpl implements StrPrdtService {

	@Autowired
	private StrPrdtDAO strPrdtDAO;
	
	@Override
	public List<StrPrdtVO> readAll(StrPrdtVO strPrdtVO) {
		return strPrdtDAO.readAll(strPrdtVO);
	}

	@Override
	public boolean update(StrPrdtVO strPrdtVO) {
		return strPrdtDAO.update(strPrdtVO) > 0;
	}

	@Override
	public boolean updateSelectAll(List<StrPrdtVO> strPrdtVOList) {
		return strPrdtDAO.updateSelectAll(strPrdtVOList) > 0;
	}

}
