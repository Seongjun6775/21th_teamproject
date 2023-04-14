package com.ktds.fr.hr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.hr.dao.HrDAO;
import com.ktds.fr.hr.vo.HrVO;

@Service
public class HrServiceImpl implements HrService {

	@Autowired
	private HrDAO hrDAO;

	@Override
	public List<HrVO> readAllHr() {
		return hrDAO.readAllHr();
	}

	@Override
	public HrVO readOneHrByHrId(String hrId) {
		return hrDAO.readOneHrByHrId(hrId);
	}

	@Override
	public boolean createNewHr(HrVO hrVO) {
		return hrDAO.createNewHr(hrVO) > 0;
	}

	@Override
	public boolean updateOneHrByHrId(HrVO hrVO) {
		return hrDAO.updateOneHrByHrId(hrVO) > 0;
	}

	@Override
	public boolean deleteOneHrByHrId(String hrId) {
		return hrDAO.deleteOneHrByHrId(hrId) > 0;
	}
	
	
	
}
