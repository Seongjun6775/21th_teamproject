package com.ktds.fr.hr.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.ktds.fr.hr.vo.HrVO;

public interface HrService {
	
	public List<HrVO> readAllHr();
	
	public List<HrVO> readAllMyHr(String mbrId);
	
	public HrVO readOneHrByHrId(String hrId);
	
	public boolean createNewHr(HrVO hrVO, MultipartFile uploadFile);
	
	public boolean updateOneHrByHrId(HrVO hrVO);
	
	public boolean deleteOneHrByHrId(String hrId);

}
