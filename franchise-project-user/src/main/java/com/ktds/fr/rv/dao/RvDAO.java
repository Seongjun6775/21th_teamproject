package com.ktds.fr.rv.dao;

import java.util.List;

import com.ktds.fr.rv.vo.RvVO;
import com.ktds.fr.rv.vo.SearchRvVO;

public interface RvDAO {

	// 1-1.(제품 이력확인 후)리뷰 등록 == 이용자
	public int createNewRv(RvVO rvVO);
	// 1-2.이용자가 쓴 리뷰 개수 조회(리뷰 쓴 적이 없어야 리뷰 등록 가능)
	public int readCountRvByRvId(RvVO rvVO);
	// 1-3. 주문서 ID를 토대로 수정일로부터 7일 이내에만 리뷰를 등록할 수 있도록 함
	public int createNewRvWithin7days(RvVO rvVO);

	
	// 2-1.모든 매장의 리뷰 목록 조회 == 상위관리자, 이용자
	public List<RvVO> readAllRvListForTopManager(SearchRvVO searchRvVO);
	// 2-2.모든 매장의 리뷰 상세 조회 == 상위관리자, 이용자
	public RvVO readOneRvVOForTopManagerByRvId(String rvId);
	

	
	// 3-1.모든 매장의 리뷰 삭제 == 상위관리자
	public int deleteAllRvVOByRvIdList(List<String> rvIdList);
	// 3-2.자기가 쓴 리뷰 삭제 == 이용자
	public int deleteOneRvVOByRvId(String rvId);
	
}
