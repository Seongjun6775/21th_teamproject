package com.ktds.fr.odrlst.service;

import java.util.List;

import com.ktds.fr.odrlst.vo.OdrLstVO;

public interface OdrLstService {
	
	public boolean createNewOdrLst(OdrLstVO odrLstVO);
	
	public List<OdrLstVO> readAllOdrLst(OdrLstVO odrLstVO);
	
	public List<OdrLstVO> readAllMyOdrLst(OdrLstVO odrLstVO);
	
	public List<OdrLstVO> getOdrLstIdForRv(String mbrId);
	
	public OdrLstVO readOneOdrLstByOdrLstId(String odrLstId);
	
	public boolean updateOneOdrLstByOdrLstId(OdrLstVO odrLstVO);
	
	public boolean deleteOneOdrLstByOdrLstId(OdrLstVO odrLstVO);

}
