package com.ktds.fr.strprdt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.common.api.exceptions.ApiArgsException;
import com.ktds.fr.prdt.vo.PrdtVO;
import com.ktds.fr.strprdt.dao.StrPrdtDAO;
import com.ktds.fr.strprdt.vo.StrPrdtVO;

@Service
public class StrPrdtServiceImpl implements StrPrdtService {

	@Autowired
	private StrPrdtDAO strPrdtDAO;
	
	@Override
	public List<StrPrdtVO> readAll(StrPrdtVO strPrdtId) {
		return strPrdtDAO.readAll(strPrdtId);
	}
	
	@Override
	public List<StrPrdtVO> readAllCustomerByStr(StrPrdtVO strPrdtVO) {
		return strPrdtDAO.readAllCustomerByStr(strPrdtVO);
	}
	
	@Override
	public StrPrdtVO readOneCustomerByStr(String strPrdtId) {
		return strPrdtDAO.readOneCustomerByStr(strPrdtId);
	}
	
	@Override
	public List<PrdtVO> missingList(String strId) {
		return strPrdtDAO.missingList(strId);
	}
	
	@Override
	public boolean create(List<StrPrdtVO> strPrdtList) {
		return strPrdtDAO.create(strPrdtList) > 0;
	}

	@Override
	public boolean update(StrPrdtVO strPrdtVO) {
		String useYn = strPrdtVO.getUseYn();
		if (useYn == null || useYn.trim().length() == 0) {
			throw new ApiArgsException("400", "사용유무 선택 필요");
		}
		return strPrdtDAO.update(strPrdtVO) > 0;
	}


}
