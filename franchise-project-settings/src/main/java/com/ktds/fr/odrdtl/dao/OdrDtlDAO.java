package com.ktds.fr.odrdtl.dao;

import java.util.List;

import com.ktds.fr.odrdtl.vo.OdrDtlVO;

public interface OdrDtlDAO {
	
	/**
	 * 주문한 상품에 대한 새 주문 상세를 작성합니다.
	 * @param odrDtlVO 주문 상세 정보
	 * @return 작성한 건수
	 */
	public int createNewOdrDtl(OdrDtlVO odrDtlVO);
	
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
	public int updateOneOdrDtlByOdrDtlId(String odrDtlId);
	
	/**
	 * 주문 상세 ID를 기준으로 그 주문을 삭제합니다.
	 * @param odrDtlId 주문 상세 ID
	 * @return 삭제한 건수
	 */
	public int deleteOneOdrDtlByOdrDtlId(String odrDtlId);

}
