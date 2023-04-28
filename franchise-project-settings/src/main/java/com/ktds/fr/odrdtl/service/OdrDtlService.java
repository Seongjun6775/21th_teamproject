package com.ktds.fr.odrdtl.service;

import java.util.List;

import com.ktds.fr.odrdtl.vo.OdrDtlVO;
import com.ktds.fr.odrlst.vo.OdrLstVO;
import com.ktds.fr.strprdt.vo.StrPrdtVO;

public interface OdrDtlService {
	
	/**
	 * 주문한 상품에 대한 새 주문 상세를 작성합니다.
	 * @param odrDtlVO 주문 상세 정보
	 * @return 작성 여부
	 */
	public boolean createNewOdrDtl(OdrDtlVO odrDtlVO);
	
	/**
	 * VO 내의 주문서 ID를 기준으로 주문서 내의 모든 상품 정보를 읽어옵니다.
	 * @param odrDtlVO 주문서 ID + pagenation 구현용 VO
	 * @return 주문서 내의 모든 상품 정보 목록
	 */
	public List<OdrDtlVO> readAllOdrDtlByOdrLstIdAndMbrId(OdrDtlVO odrDtlVO);
	
	/**
	 * 주문서 ID를 기준으로 그 주문서를 생성한 회원의 ID를 받아옵니다.
	 * @param odrLstId 주문서 ID
	 * @return 회원 ID
	 */
	public OdrLstVO isThisMyOdrLst(String odrLstId);
	
	/**
	 * 주문서 ID를 기준으로 현재 주문 상태를 받아옵니다.(OdrDtlController에서 사용합니다.)
	 * @param odrLstId 주문서 ID
	 * @return odrLstOdrPrcs(주문 처리 상태)
	 */
	public OdrLstVO getOdrPrcs(String odrLstId);
	
	/**
	 * 주문 상세 ID를 기준으로 그 주문에 대해 상세 조회합니다.
	 * @param odrDtlId 주문 상세 ID
	 * @return 주문한 상품의 상세 정보
	 */
	public OdrDtlVO readOneOdrDtlByOdrDtlId(String odrDtlId);
	
	/**
	 * OdrDtl을 생성하기 위해 주문한 물품의 물품 + 매장 정보를 가져옵니다.
	 * @param strPrdtId 매장 + 물품 ID
	 * @return 주문한 물품의 상세 정보
	 */
	public StrPrdtVO readOneCustomerByStr(String strPrdtId);
	
	/**
	 * 주문 상세 ID를 기준으로 그 주문의 정보를 수정합니다.
	 * @param odrDtlId 주문 상세 ID
	 * @return 수정 여부
	 */
	public boolean updateOneOdrDtlByOdrDtlId(OdrDtlVO odrDtlVO);
	
	/**
	 * 주문 상세 ID를 기준으로 그 주문을 삭제합니다.
	 * @param odrDtlId 주문 상세 ID
	 * @return 삭제 여부
	 */
	public boolean deleteOneOdrDtlByOdrDtlId(String odrDtlId);
	
	/**
	 * 주문 상세 ID를 기준으로 선택한 주문들을 삭제합니다.
	 * @param odrDtlId 주문 상세 ID
	 * @return 삭제 여부
	 */
	public boolean deleteOdrDtlBySelectedDtlId(List<String> odrDtlId);
	
	/**
	 * 주문서 ID를 기준으로 그 주문서를 삭제합니다. (RestOdrDtlController 에서 사용합니다.)
	 * @param odrLstId 주문서 ID
	 * @return 삭제 여부
	 */
	public boolean deleteOneOdrLstByOdrLstId(String odrLstId);

}
