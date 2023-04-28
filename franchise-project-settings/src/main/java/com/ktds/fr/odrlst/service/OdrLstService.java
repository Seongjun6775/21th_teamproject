package com.ktds.fr.odrlst.service;

import java.util.List;

import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.odrlst.vo.OdrLstVO;

public interface OdrLstService {
	
	public boolean createNewOdrLst(OdrLstVO odrLstVO);
	
	public List<OdrLstVO> readAllOdrLst(OdrLstVO odrLstVO);
	
	public List<OdrLstVO> readAllMyOdrLst(OdrLstVO odrLstVO);
	
	public OdrLstVO readOneOdrLstByOdrLstId(String odrLstId);
	
	public boolean updateRestMbrPyMn(MbrVO mbrVO);
	
	public boolean updateOdrPrcsToReadyByOdrLstId(String odrLstId);
	
	public boolean deleteOneOdrLstByOdrLstId(String odrLstId);
	
	public boolean deleteOdrLstBySelectedLstId(List<String> odrLstId);

	/**
	 * 매장용
	 */
	public List<OdrLstVO> readAllOdrLstForStr(OdrLstVO odrLstVO);
	public boolean updateCheckAll(OdrLstVO odrLstVO);
	public List<OdrLstVO> completeOdrForStr(OdrLstVO odrLstVO);
	
}
