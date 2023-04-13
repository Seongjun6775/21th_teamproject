package com.ktds.fr.rv.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.rv.dao.RvDAO;
import com.ktds.fr.rv.vo.RvVO;

@Service
public class RvServiceImpl implements RvService {

	@Autowired
	private RvDAO rvDAO;

	// 1-1.(제품 이력확인 후)리뷰 등록 == 이용자
	@Override
	public boolean createNewRv(RvVO rvVO) {
		
		int rvCount = this.readCountRvByRvId(rvVO);
		if (rvCount >= 1) {
			throw new ApiException("500", "이미 리뷰를 작성하셨습니다.");
		}
		try {
			return rvDAO.createNewRv(rvVO) > 0;
		}
		catch (RuntimeException re) {
			throw new ApiException("500", "이미 리뷰를 작성하셨습니다.");
		}
	
	}
	
	// 1-2.이용자가 쓴 리뷰 개수 조회(리뷰 쓴 적이 없어야 리뷰 등록 가능)
	@Override
	public int readCountRvByRvId(RvVO rvVO) {
		return rvDAO.readCountRvByRvId(rvVO);
	}

	
	// 2-1.리뷰 목록 조회 == 상위관리자, 중하위관리자, 이용자
	@Override
	public List<RvVO> readAllRvList(RvVO rvVO, MbrVO mbrVO) {
		if (mbrVO.getMbrLvl() == "상위관리자") {
			return rvDAO.readAllRvListForTopManager(rvVO);
		}
		else if (mbrVO.getMbrLvl() == "중간관리자" || mbrVO.getMbrLvl() == "하위관리자") {
			return rvDAO.readAllRvListForMiddleManager(mbrVO.getStrId());
		}
		else {
			return rvDAO.readAllRvListForMemberByRvId(rvVO.getRvId());
		}
	}

	// 2-2.리뷰 상세 조회 == 상위관리자, 중하위관리자, 이용자
	@Override
	public RvVO readOneRvVO(RvVO rvVO, MbrVO mbrVO) {
		if (mbrVO.getMbrLvl() == "최고관리자") {
			return rvDAO.readOneRvVOForTopManagerByRvId(rvVO.getRvId());
		}
		else if (mbrVO.getMbrLvl() == "중간관리자" || mbrVO.getMbrLvl() == "하위관리자") {
			return rvDAO.readOneRvVOForMiddleManagerByOdrId(rvVO.getOdrId());
		}
		else {
			return rvDAO.readOneRvVOForMemberByRvId(rvVO.getRvId());
		}
	}

	
	// 3-1.모든 매장의 리뷰 삭제 == 상위관리자
	@Override
	public boolean deleteAllRvVOByRvId(String rvId) {
		return rvDAO.deleteAllRvVOForTopManagerByRvId(rvId) > 0;
	}

	// 3-2.자기가 쓴 리뷰 삭제 == 이용자
	@Override
	public boolean deleteOneRvVOByRvId(String rvId) {
		return rvDAO.deleteOneRvVOForMemberByRvId(rvId) > 0;
	}

		
}
