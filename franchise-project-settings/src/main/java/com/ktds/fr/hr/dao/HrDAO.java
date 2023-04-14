package com.ktds.fr.hr.dao;

import java.util.List;

import com.ktds.fr.hr.vo.HrVO;

public interface HrDAO {
	
	public List<HrVO> readAllHr();
	
	public List<HrVO> readAllMyHr(String mbrId);
	
	public HrVO readOneHrByHrId(String hrId);
	
	public int createNewHr(HrVO hrVO);
	
	public int updateOneHrByHrId(HrVO hrVO);
	
	public int deleteOneHrByHrId(String hrId);

}
