package com.ktds.fr.odrlst.dao;

import java.util.List;

import com.ktds.fr.odrdtl.vo.OdrDtlVO;
import com.ktds.fr.odrlst.vo.OdrLstVO;

public interface OdrLstDAO {
	
	public int checkRemainOdrLst(OdrDtlVO odrDtlVO);
	
	public OdrLstVO getOdrLstId(String mbrId);
	
	public int createNewOdrLst(OdrLstVO odrLstVO);
	
	public List<OdrLstVO> readAllOdrLst(OdrLstVO odrLstVO);
	
	public List<OdrLstVO> readAllMyOdrLst(OdrLstVO odrLstVO);
	
	public OdrLstVO readOneOdrLstByOdrLstId(String odrLstId);
	
	public int updateOdrPrcsToReadyByOdrLstId(String odrLstId);
	
	public int deleteOneOdrLstByOdrLstId(OdrLstVO odrLstVO);

}
