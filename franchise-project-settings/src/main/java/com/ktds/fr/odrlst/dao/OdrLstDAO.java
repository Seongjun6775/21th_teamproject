package com.ktds.fr.odrlst.dao;

import java.util.List;

import com.ktds.fr.odrdtl.vo.OdrDtlVO;

public interface OdrLstDAO {
	
	/**
	 * 주문서 ID를 기준으로 주문서에 포함된 모든 주문상세를 읽어옵니다.
	 * @param odrLstId 주문서 ID
	 * @return 주문서에 포함된 주문 상세 목록
	 */
	public List<OdrDtlVO> readAllOdrDtlByOdrLstId(String odrLstId);

}
