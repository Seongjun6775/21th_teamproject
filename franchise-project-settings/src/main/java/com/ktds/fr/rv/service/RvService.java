package com.ktds.fr.rv.service;

import java.util.List;

import com.ktds.fr.rv.vo.RvVO;

public interface RvService {

	// 1.(제품 이력확인 후)리뷰 등록 == 이용자
	public boolean createNewRv(RvVO rvVO);
	
	// 2-1.모든 리뷰 목록 조회 == 상위관리자
	public List<RvVO> readAllRvList(RvVO rvVO);
	// 2-2.모든 리뷰들의 내용 조회 == 상위관리자
	public RvVO readOneRvVO(RvVO rvVO);
	
	// 2-3.매장의 모든 리뷰 조회 (제목까지만 조회) == 중간관리자
	public List<RvVO> readAllRvByStrId(String strId);
	// 2-4.매장의 모든 리뷰들의 내용을 조회 (제목+내용 조회) == 중간관리자
	public RvVO readOneRvVOByStrId(String strId);
	
	// 3-1.모든 리뷰들에 대한 삭제를 수행가능 == 상위관리자
	public boolean deleteAllRvList(List<String> RvList);
	// 3-2.자신의 리뷰에 대한 삭제 수행가능 == 이용자
	public boolean deleteOneRvByRvId(String RvId);
	
}
