package com.ktds.fr.odrlst.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.mbr.dao.MbrDAO;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.odrlst.dao.OdrLstDAO;
import com.ktds.fr.odrlst.vo.OdrLstVO;
import com.ktds.fr.odrprcshist.dao.OdrPrcsHistDAO;
import com.ktds.fr.odrprcshist.vo.OdrPrcsHistVO;

@Service
public class OdrLstServiceImpl implements OdrLstService {
	
	@Autowired
	private OdrLstDAO odrLstDAO;
	
	@Autowired
	private MbrDAO mbrDAO;
	
	@Autowired
	private OdrPrcsHistDAO odrPrcsHistDAO; 

	@Override
	public boolean createNewOdrLst(OdrLstVO odrLstVO) {
		return odrLstDAO.createNewOdrLst(odrLstVO) > 0;
	}

	@Override
	public List<OdrLstVO> readAllOdrLst(OdrLstVO odrLstVO) {
		return odrLstDAO.readAllOdrLst(odrLstVO);
	}

	@Override
	public List<OdrLstVO> readAllMyOdrLst(OdrLstVO odrLstVO) {
		return odrLstDAO.readAllMyOdrLst(odrLstVO);
	}
	
	@Override
	public OdrLstVO getOdrPrcs(String odrLstId) {
		
		OdrLstVO isExist = odrLstDAO.getOdrPrcs(odrLstId);
		
		if (isExist.getOdrLstOdrPrcs() == null || isExist.getOdrLstOdrPrcs().trim().length() == 0 ) {
			throw new ApiException("404", "주문서가 존재하지 않습니다.");
		}
		return isExist;
	}
	
	@Override
	public OdrLstVO isThisMyOdrLst(String odrLstId) {
		return odrLstDAO.isThisMyOdrLst(odrLstId);
	}

	@Override
	public OdrLstVO readOneOdrLstByOdrLstId(String odrLstId) {
		return odrLstDAO.readOneOdrLstByOdrLstId(odrLstId);
	}
	
	@Override
	public boolean updateRestMbrPyMn(MbrVO mbrVO) {
		return mbrDAO.updateRestMbrPyMn(mbrVO) > 0;
	}
	
	@Override
	public boolean updateOdrPrcsToReadyByOdrLstId(String odrLstId) {
		
		
		
		return odrLstDAO.updateOdrPrcsToReadyByOdrLstId(odrLstId) > 0;
	}
	
	@Override
	public boolean deleteOneOdrLstByOdrLstId(String odrLstId) {
		// 주문서의 현재 상태를 가져옵니다.
		OdrLstVO odrPrcs = odrLstDAO.getOdrPrcs(odrLstId);
		// 만약 주문서가 '주문 대기', '주문 취소' 상태가 아니라면, 삭제 요청을 거부합니다.
		if (!odrPrcs.getOdrLstOdrPrcs().equals("003-01") && !odrPrcs.getOdrLstOdrPrcs().equals("003-05")) {
			if (!odrPrcs.getOdrLstOdrPrcs().equals("003-04")) {
				throw new ApiException("500", "주문이 이미 접수되었습니다.");
			}
		}
		
		return odrLstDAO.deleteOneOdrLstByOdrLstId(odrLstId) > 0;
	}
	
	@Override
	public boolean deleteOdrLstBySelectedLstId(List<String> odrLstId) {
		return odrLstDAO.deleteOdrLstBySelectedLstId(odrLstId) > 0;
	}

	@Override
	public List<OdrLstVO> readAllOdrLstForStr(OdrLstVO odrLstVO) {
		return odrLstDAO.readAllOdrLstForStr(odrLstVO);
	}

	@Override
	public boolean updateCheckAll(OdrLstVO odrLstVO) {
		
		boolean isSuccess = odrLstDAO.updateCheckAll(odrLstVO) > 0;
		
		if (isSuccess) {
			OdrPrcsHistVO odrPrcsHistVO = new OdrPrcsHistVO();
			odrPrcsHistVO.setMdfyr(odrLstVO.getMdfyr());
			odrPrcsHistVO.setOdrPrcsHistRdrPrcs(odrLstVO.getOdrLstOdrPrcs());
			odrPrcsHistVO.setOdrLstIdList(odrLstVO.getOdrLstIdList());
			
			isSuccess = odrPrcsHistDAO.create(odrPrcsHistVO) > 0;
		}
		
		return isSuccess;
	}

	@Override
	public List<OdrLstVO> completeOdrForStr(OdrLstVO odrLstVO) {
		return odrLstDAO.completeOdrForStr(odrLstVO);
	}

}
