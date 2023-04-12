package com.ktds.fr.str.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.ktds.fr.str.vo.StrVO;

public interface StrService {

public List<StrVO>readAllStrMaster(StrVO strVO);
	
	public StrVO readOneStrByMaster(String strId);

	public StrVO readOneStrByManager(String strId);
	
	public boolean createOneStr(StrVO strVO, MultipartFile uploadFile);
	
	public boolean updateOneStrByMaster(StrVO strVO, MultipartFile uploadFile);
	
	public boolean updateOneStrByManager(StrVO strVO, MultipartFile uploadFile);
	
	public boolean deleteOneStrByStrId(String strId);
	
}
