package com.ktds.fr.hr.dao;

import java.util.List;

import com.ktds.fr.hr.vo.HrVO;

public interface HrDAO {
	
	public List<HrVO> readAllHr(HrVO hrVO);
	
	public List<HrVO> readAllMyHr(HrVO hrVO);
	
	public int countNtc();
	
	public HrVO readOneHrByHrId(String hrId);
	
	public int createNewHr(HrVO hrVO);
	
	public int updateOneHrByHrId(HrVO hrVO);
	
	public int deleteOneHrByHrId(String hrId);
	
	public int updateHrStatByHrId(String hrId);
	
	public int updateHrAprByHrId(HrVO hrVO);
	
	public int checkCreateYn(String mbrId);
	
	/**
	 * 직원 조회용
	 */
	public HrVO readOneHrByMbrId(String mbrId);
	/**
	 * 직원 해임용
	 */
	public int deleteAllHrByMbrId(List<String> mbrIdList);

}
