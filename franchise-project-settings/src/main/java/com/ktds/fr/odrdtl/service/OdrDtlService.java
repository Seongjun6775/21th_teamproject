package com.ktds.fr.odrdtl.service;

import java.util.List;

import com.ktds.fr.odrdtl.vo.OdrDtlVO;

public interface OdrDtlService {
	
	/**
	 * 주문한 상품에 대한 새 주문 상세를 작성합니다.
	 * @param odrDtlVO 주문 상세 정보
	 * @return 작성한 건수
	 */
	public boolean createNewOdrDtl(OdrDtlVO odrDtlVO);
	
	/**
	 * 회원 ID를 기준으로 회원이 주문한 모든 상품의 주문상세를 읽어옵니다.
	 * @param odrLstId 주문한 회원 ID
	 * @return 회원이 주문한 상품의 주문 상세 목록
	 */
	public List<OdrDtlVO> readAllOdrDtlByOdrLstId(String mbrId);
	
	/**
	 * 주문 상세 ID를 기준으로 그 주문에 대해 상세 조회합니다.
	 * @param odrDtlId 주문 상세 ID
	 * @return 주문한 상품의 상세 정보
	 */
	public OdrDtlVO readOneOdrDtlByOdrDtlId(String odrDtlId);
	
	/**
	 * 주문 상세 ID를 기준으로 그 주문의 정보를 수정합니다.
	 * @param odrDtlId 주문 상세 ID
	 * @return 수정한 건수
	 */
	public boolean updateOneOdrDtlByOdrDtlId(String odrDtlId);
	
	/**
	 * 주문 상세 ID를 기준으로 그 주문을 삭제합니다.
	 * @param odrDtlId 주문 상세 ID
	 * @return 삭제한 건수
	 */
	public boolean deleteOneOdrDtlByOdrDtlId(String odrDtlId);
	

}
