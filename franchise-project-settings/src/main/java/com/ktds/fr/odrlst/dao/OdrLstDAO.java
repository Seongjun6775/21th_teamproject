package com.ktds.fr.odrlst.dao;

import java.util.List;

import com.ktds.fr.odrdtl.vo.OdrDtlVO;
import com.ktds.fr.odrlst.vo.OdrLstVO;

public interface OdrLstDAO {
	
	public int checkRemainOdrLst(OdrDtlVO odrDtlVO);
	
	public OdrLstVO getOdrLstId(OdrDtlVO odrDtlVO);
	
	public List<OdrLstVO> getOdrLstIdForRv(String mbrId);
	
	public int createNewOdrLst(OdrLstVO odrLstVO);
	
	public List<OdrLstVO> readAllOdrLst(OdrLstVO odrLstVO);
	
	public List<OdrLstVO> readAllMyOdrLst(OdrLstVO odrLstVO);
	
	public OdrLstVO isThisMyOdrLst(String odrLstId);
	/**
	 * 주문서 ID를 기준으로 현재 주문 상태를 받아옵니다.(OdrDtlController에서 사용합니다.)
	 * @param odrLstId 주문서 ID
	 * @return odrLstOdrPrcs(주문 처리 상태)
	 */
	public OdrLstVO getOdrPrcs(String odrLstId);
	
	public OdrLstVO readOneOdrLstByOdrLstId(String odrLstId);
	
	public int updateOdrPrcsToReadyByOdrLstId(String odrLstId);
	
	public int deleteOneOdrLstByOdrLstId(String odrLstId);
	
	public int deleteOdrLstBySelectedLstId(List<String> odrLstId);

	/**
	 * 매장용
	 */
	public List<OdrLstVO> readAllOdrLstForStr(OdrLstVO odrLstVO);
	public int updateCheckAll(OdrLstVO odrLstVO);
	public List<OdrLstVO> completeOdrForStr(OdrLstVO odrLstVO);
	
	public List<String> monthly();
	
}
