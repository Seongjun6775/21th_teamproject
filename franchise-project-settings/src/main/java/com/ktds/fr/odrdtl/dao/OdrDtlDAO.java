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
	 * VO 내의 주문서 ID와 mbrId를 기준으로 주문서 내의 모든 상품 정보를 읽어옵니다.
	 * @param odrDtlVO 주문서 ID + pagenation 구현용 VO
	 * @return 주문서 내의 모든 상품 정보 목록
	 */
	public List<OdrDtlVO> readAllOdrDtlByOdrLstIdAndMbrId(OdrDtlVO odrDtlVO);
	
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
	
	public int deleteOdrDtlBySelectedDtlId(List<String> odrDtlId);

}
