package com.ktds.fr.hr.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.ktds.fr.hr.vo.HrVO;

public interface HrService {
	
	public List<HrVO> readAllHr(HrVO hrVO);
	
	public List<HrVO> readAllMyHr(HrVO hrVO);
	
	public HrVO readOneHrByHrId(String hrId);
	
	public boolean createNewHr(HrVO hrVO, MultipartFile uploadFile);
	
	public boolean updateOneHrByHrId(HrVO hrVO);
	
	public boolean deleteOneHrByHrId(String hrId);
	
	public boolean updateHrStatByHrId(String hrId);
	
	public boolean updateOneMstrHrByMrId(HrVO hrVO);
	
	public boolean updateHrAprByHrId(HrVO hrVO);
	
	public boolean checkCreateYn(String mbrId);

}
