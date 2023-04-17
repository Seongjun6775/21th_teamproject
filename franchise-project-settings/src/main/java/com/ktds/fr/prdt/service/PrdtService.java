package com.ktds.fr.prdt.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.ktds.fr.prdt.vo.PrdtVO;

public interface PrdtService {

	public List<PrdtVO> readAll(PrdtVO prdtVO);
	public PrdtVO readOne(String prdtId);
	
	public boolean create(PrdtVO prdtVO, MultipartFile uploadFile);
	public boolean update(PrdtVO prdtVO, MultipartFile uploadFile);
	public boolean deleteOne(String prdtId);
	public boolean deleteSelectAll(List<String> prdtIdList);
	
}
