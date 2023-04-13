package com.ktds.fr.rv.service;

import java.util.List;

import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.rv.vo.RvVO;

public interface RvService {

	// 1-1.(제품 이력확인 후)리뷰 등록 == 이용자
	public boolean createNewRv(RvVO rvVO);
	// 1-2.이용자가 쓴 리뷰 개수 조회(리뷰 쓴 적이 없어야 리뷰 등록 가능)
	public int readCountRvByRvId(RvVO rvVO);	

	
	// 2-1.리뷰 목록 조회 == 상위관리자, 중하위관리자, 이용자
	public List<RvVO> readAllRvList(RvVO rvVO, MbrVO mbrVO);
	// 2-2.리뷰 상세 조회 == 상위관리자, 중하위관리자, 이용자
	public RvVO readOneRvVO(RvVO rvVO, MbrVO mbrVO);

	
	// 3-1.모든 매장의 리뷰 삭제 == 상위관리자
	public boolean deleteAllRvVOByRvId(String rvId);
	// 3-2.자기가 쓴 리뷰 삭제 == 이용자
	public boolean deleteOneRvVOByRvId(String rvId);
	
}
