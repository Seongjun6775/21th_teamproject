package com.ktds.fr.rv.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.rv.dao.RvDAO;
import com.ktds.fr.rv.vo.RvVO;
import com.ktds.fr.rv.vo.SearchRvVO;

@Service
public class RvServiceImpl implements RvService {

	@Autowired
	private RvDAO rvDAO;

	// 1-1.(제품 이력확인 후)리뷰 등록 == 이용자
		@Override
		public boolean createNewRv(RvVO rvVO) {
			
			if (rvVO.getRvLkDslk().equals("선택")) {
				throw new ApiException("500", "좋아요 또는 싫어요를 선택하세요.");
			}
			int rvCount7 = rvDAO.createNewRvWithin7days(rvVO);
			if (rvCount7 == 0) {
				throw new ApiException("500", "주문서 수정일로부터 7일 이내에만 리뷰를 작성할 수 있습니다.");
			}
			
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
	public List<RvVO> readAllRvList(RvVO rvVO, MbrVO mbrVO, SearchRvVO searchRvVO) {
		rvVO.setMbrVO(mbrVO);
		
		if (mbrVO.getMbrLvl().equals("001-01")) {
			searchRvVO.setMbrVO(mbrVO);
			return rvDAO.readAllRvListForTopManager(searchRvVO);
		}
		else if (mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03")) {
			searchRvVO.setMbrVO(mbrVO);
			return rvDAO.readAllRvListForMiddleManager(searchRvVO);
		}
		else {
			return rvDAO.readAllRvListForMemberByRvId(rvVO);
		}
	}
	// ▶ 진영님이 만든거: 중간관리자와 하위관리자 목록 조회(2-1) 대체
	@Override
	public List<RvVO> readAllRvListForManager(SearchRvVO searchRvVO) {
		return rvDAO.readAllRvListForManager(searchRvVO);
	}
			
	// 2-2.리뷰 상세 조회 == 상위관리자, 중하위관리자, 이용자
	@Override
	public RvVO readOneRvVO(RvVO rvVO, MbrVO mbrVO) {
//		rvVO.setMbrId(mbrVO.getMbrId());
//		if (mbrVO.getMbrLvl().equals("001-01")) {
//			return rvDAO.readOneRvVOForTopManagerByRvId(rvVO.getRvId());
//		}
//		else if (mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03")) {
//			return rvDAO.readOneRvVOForMiddleManagerByOdrId(rvVO);
//		}
//		else {
//			return rvDAO.readOneRvVOForMemberByRvId(rvVO.getRvId());
//		}
		return rvDAO.readOneRvVOForMiddleManagerByOdrId(rvVO);
	}

	
	// 3-1.리뷰 목록에서 리뷰 삭제 == 상위관리자, 이용자
	@Override
	public boolean deleteAllRvListByRvId(List<String> rvIdList, MbrVO mbrVO) {
		if (mbrVO.getMbrLvl().equals("001-01") || mbrVO.getMbrLvl().equals("001-04")) {
			return rvDAO.deleteAllRvVOByRvIdList(rvIdList) > 0;
		}
		return false;
	}
	
	// 3-2.리뷰 상세에서 리뷰 삭제 == 상위관리자, 이용자
	@Override
	public boolean deleteOneRvVOByRvId(String rvId, MbrVO mbrVO) {
		if (mbrVO.getMbrLvl().equals("001-01") || mbrVO.getMbrLvl().equals("001-04")) {
			return rvDAO.deleteOneRvVOByRvId(rvId) > 0;
		}
		return false;
	}

		
}
