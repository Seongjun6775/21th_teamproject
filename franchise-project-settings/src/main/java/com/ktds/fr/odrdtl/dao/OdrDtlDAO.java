package com.ktds.fr.odrdtl.dao;

import java.util.List;

import com.ktds.fr.odrdtl.vo.OdrDtlVO;
import com.ktds.fr.rv.vo.RvVO;

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
	public int updateOneOdrDtlByOdrDtlId(OdrDtlVO odrDtlVO);
	
	/**
	 * 주문 상세 ID를 기준으로 그 주문을 삭제합니다.
	 * @param odrDtlVO 주문 상세 ID + 현재 접속중인 계정 ID
	 * @return 삭제한 건수
	 */
	public int deleteOneOdrDtlByOdrDtlId(OdrDtlVO odrDtlVO);
	
	/**
	 * 주문서 ID를 기준으로 주문서 내의 모든 상품을 삭제합니다.
	 * @param odrDtlVO 주문서 ID + 현재 접속중인 계정 ID
	 * @return 삭제한 상품 건수
	 */
	public int deleteAllOdrDtlByOdrLstId(OdrDtlVO odrDtlVO);
	
	/**
	 * 주문 상세 ID를 기준으로 선택한 주문들을 삭제합니다.
	 * @param odrDtlId 주문 상세 ID
	 * @return 삭제한 건수
	 * 
	 * 전체 삭제 기능이 생긴 관계로 지금은 사용되지 않는 기능입니다
	 * 
	 */
	public int deleteOdrDtlBySelectedDtlId(List<String> odrDtlId);

	
	
	/**
	 * 매장에서 보는 주문서의 디테일 / 노 페이지네이션
	 */
	public List<OdrDtlVO> odrDtlForOdrLst(String odrDtlId);

	// 2-5.상세 조회에서 주문서 ID의 개수 받아오기 == 상위관리자, 중간관리자, 하위관리자, 이용자
	public int readCountOdrLstId(OdrDtlVO odrDtlVO);
	
	/**
	 * 매출관련 조회용 
	 */
	public List<OdrDtlVO> forSale(OdrDtlVO odrDtlVO);
	public List<OdrDtlVO> group(OdrDtlVO odrDtlVO);
	public List<OdrDtlVO> groupPrdt(OdrDtlVO odrDtlVO);
	public List<OdrDtlVO> groupStr(OdrDtlVO odrDtlVO);

	public List<OdrDtlVO> startEnd(OdrDtlVO odrDtlVO);
	public List<OdrDtlVO> oneMonth(OdrDtlVO odrDtlVO);
	public List<OdrDtlVO> sumMonth(OdrDtlVO odrDtlVO);
	public List<OdrDtlVO> sumYear(OdrDtlVO odrDtlVO);

	/* index page 매장별 조회용 기능 */
	public List<OdrDtlVO> viewStrPayments(OdrDtlVO odrDtlVO);
	
}
