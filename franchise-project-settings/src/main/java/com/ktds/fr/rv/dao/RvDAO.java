package com.ktds.fr.rv.dao;

import java.util.List;

import com.ktds.fr.rv.vo.RvVO;

public interface RvDAO {

	// 1-1.(제품 이력확인 후)리뷰 등록 == 이용자
	public int createNewRv(RvVO rvVO);
	// 1-2.이용자가 쓴 리뷰 개수 조회(리뷰 쓴 적이 없어야 리뷰 등록 가능)
	public int readCountRvByRvId(RvVO rvVO);

	
	// 2-1.모든 매장의 리뷰 목록 조회 == 상위관리자
	public List<RvVO> readAllRvListForTopManager(RvVO rvVO);
	// 2-2.모든 매장의 리뷰 상세 조회 == 상위관리자
	public RvVO readOneRvVOForTopManagerByRvId(String rvId);
	
	// 2-3.자기 매장의 리뷰 목록 조회 == 중하위관리자
	public List<RvVO> readAllRvListForMiddleManager(String strId);
	// 2-4.자기 매장의 리뷰 상세 조회 == 중하위관리자
	public RvVO readOneRvVOForMiddleManagerByOdrId(String odrId);
	
	// 2-5.자기가 쓴 리뷰 목록 조회 == 이용자
	public List<RvVO> readAllRvListForMemberByRvId(String rvId);
	// 2-6.자기가 쓴 리뷰 상세 조회 == 이용자
	public RvVO readOneRvVOForMemberByRvId(String rvId);

	
	// 3-1.모든 매장의 리뷰 삭제 == 상위관리자
	public int deleteAllRvVOForTopManagerByRvId(String rvId);
	// 3-2.자기가 쓴 리뷰 삭제 == 이용자
	public int deleteOneRvVOForMemberByRvId(String rvId);
	
}
