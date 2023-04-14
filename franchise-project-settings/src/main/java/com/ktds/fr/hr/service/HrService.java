package com.ktds.fr.hr.service;

import java.util.List;

import com.ktds.fr.hr.vo.HrVO;

public interface HrService {
	
	public List<HrVO> readAllHr();
	
	public HrVO readOneHrByHrId(String hrId);
	
	public boolean createNewHr(HrVO hrVO);
	
	public boolean updateOneHrByHrId(HrVO hrVO);
	
	public boolean deleteOneHrByHrId(String hrId);

}
