package com.ktds.fr.odrlst.dao;

import java.util.List;

import com.ktds.fr.odrlst.vo.OdrLstVO;

public interface OdrLstDAO {
	
	public int createNewOdrLst(OdrLstVO odrLstVO);
	
	public List<OdrLstVO> readAllOdrLst(OdrLstVO odrLstVO);
	
	public List<OdrLstVO> readAllMyOdrLst(OdrLstVO odrLstVO);
	
	public OdrLstVO readOneOdrLstByOdrLstId(String odrLstId);
	
	public int updateOneOdrLstByOdrLstId(OdrLstVO odrLstVO);
	
	public int deleteOneOdrLstByOdrLstId(OdrLstVO odrLstVO);

}
