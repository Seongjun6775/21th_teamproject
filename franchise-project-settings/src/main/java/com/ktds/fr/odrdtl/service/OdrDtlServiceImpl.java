package com.ktds.fr.odrdtl.service;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.odrdtl.dao.OdrDtlDAO;
import com.ktds.fr.odrdtl.vo.OdrDtlVO;
import com.ktds.fr.odrlst.dao.OdrLstDAO;
import com.ktds.fr.odrlst.vo.OdrLstVO;

@Service
public class OdrDtlServiceImpl implements OdrDtlService {
	
	@Autowired
	public OdrDtlDAO odrDtlDAO;
	
	@Autowired
	public OdrLstDAO odrLstDAO;

	@Override
	public boolean createNewOdrDtl(OdrDtlVO odrDtlVO) {
		
		// 현재 주문을 하고 있는 매장에서, 이전에 주문이 완료되지 않은 주문서가 존재하는지 확인합니다.
		int remainList = odrLstDAO.checkRemainOdrLst(odrDtlVO);
		
		boolean createResult = false;
		
		// 만약 '대기'상태였던 주문서가 있다면, 새로운 OdrDtl을 그 안에 추가합니다.
		if (remainList > 0) {
			// odrDtl 내의 mbrId로 OdrLst에 접근해, 이미 존재하는 주문서 ID를 받아옵니다.
			OdrLstVO OdrLstId = odrLstDAO.getOdrLstId(odrDtlVO);
			// 받아온 주문서 ID를 odrDtlVO 안에 세팅합니다.
			odrDtlVO.setOdrLstId(OdrLstId.getOdrLstId());
			
			// 주문서 ID가 포함된 odrDtlVO로 새 주문상세를 생성합니다.
			createResult = odrDtlDAO.createNewOdrDtl(odrDtlVO) > 0;
		}
		// 만약 '대기'상태였던 주문서가 없다면, 새 주문서를 생성한 후 그 안에 OdrDtl을 추가합니다.
		else {
			// 주문서를 생성하기 위해 OdrLstVO를 만든 후, 정보를 넣어줍니다.
			OdrLstVO odrLstVO = new OdrLstVO();
			odrLstVO.setMbrId(odrDtlVO.getMbrId());
			odrLstVO.setOdrLstRgstr(odrDtlVO.getMbrId());
			odrLstVO.setMdfyr(odrDtlVO.getMbrId());
			odrLstVO.setStrId(odrDtlVO.getOdrDtlStrId());
			// 새 주문서를 생성합니다.
			odrLstDAO.createNewOdrLst(odrLstVO);
			
			// odrDtl 내의 mbrId로 OdrLst에 접근해, 방금 생성한 주문서의 ID를 받아옵니다.
			OdrLstVO OdrLstId = odrLstDAO.getOdrLstId(odrDtlVO);
			// 받아온 주문서 ID를 odrDtlVO 안에 세팅합니다.
			odrDtlVO.setOdrLstId(OdrLstId.getOdrLstId());
			// 주문서 ID가 포함된 odrDtlVO로 새 주문상세를 생성합니다.
			createResult = odrDtlDAO.createNewOdrDtl(odrDtlVO) > 0;
		}
		
		return createResult;
	}
	
	@Override
	public List<OdrDtlVO> readAllOdrDtlByOdrLstIdAndMbrId(OdrDtlVO odrDtlVO) {
		return odrDtlDAO.readAllOdrDtlByOdrLstIdAndMbrId(odrDtlVO);
	}
	
	@Override
	public OdrDtlVO readOneOdrDtlByOdrDtlId(String odrDtlId) {
		return odrDtlDAO.readOneOdrDtlByOdrDtlId(odrDtlId);
	}
	
	@Override
	public boolean updateOneOdrDtlByOdrDtlId(OdrDtlVO odrDtlVO) {
		
		// 주문 상세를 생성한 계정 ID를 확인합니다.
		OdrDtlVO mbrId = odrDtlDAO.readOneOdrDtlByOdrDtlId(odrDtlVO.getOdrDtlId());
		// 주문 상세를 생성한 계정 ID와 현재 접속중인 계정 ID가 같은지 확인합니다.
		if (!mbrId.getMbrId().equals(odrDtlVO.getMbrId())) {
			throw new ApiException("400", "권한이 없습니다.");
		}
		
		// 수정 성공 여부를 RestOdrDtlController로 전달합니다.
		return odrDtlDAO.updateOneOdrDtlByOdrDtlId(odrDtlVO) > 0;
	}

	@Override
	public boolean deleteOneOdrDtlByOdrDtlId(OdrDtlVO odrDtlVO) {
		
		// 주문 상세를 생성한 계정 ID를 확인합니다.
		OdrDtlVO mbrId = odrDtlDAO.readOneOdrDtlByOdrDtlId(odrDtlVO.getOdrDtlId());
		// 주문 상세를 생성한 계정 ID와 현재 접속중인 계정 ID가 같은지 확인합니다.
		if (!mbrId.getMbrId().equals(odrDtlVO.getMbrId())) {
			throw new ApiException("400", "권한이 없습니다.");
		}
		// 삭제 성공 여부를 저장합니다.
		boolean deleteResult = odrDtlDAO.deleteOneOdrDtlByOdrDtlId(odrDtlVO) > 0;
		
		// 남은 물품 갯수 확인을 위해 odrLstId를 odrDtlVO 안에 저장합니다.
		odrDtlVO.setOdrLstId(mbrId.getOdrLstId());
		
		if (deleteResult) {
			// 삭제가 성공했을 때, 주문서 내에 남은 물품 갯수를 확인합니다.
			List<OdrDtlVO> restList = odrDtlDAO.readAllOdrDtlByOdrLstIdAndMbrId(odrDtlVO);
			// 만약 주문서 내에 남은 물품이 없다면, 주문서도 삭제합니다.
			if (restList.size() == 0) {
				odrLstDAO.deleteOneOdrLstByOdrLstId(odrDtlVO.getOdrLstId());
			}
		}
		// 삭제 성공 여부를 RestOdrDtlController로 전달합니다.
		return deleteResult;
	}
	
	@Override
	public boolean deleteAllOdrDtlByOdrLstId(OdrDtlVO odrDtlVO) {
		
		// 주문서를 생성한 계정 ID를 확인합니다.
		OdrLstVO mbrId = odrLstDAO.isThisMyOdrLst(odrDtlVO.getOdrLstId());
		// 주문서를 생성한 계정 ID와 현재 접속중인 계정 ID가 같은지 확인합니다.
		if (!mbrId.getMbrId().equals(odrDtlVO.getMbrId())) {
			// 만약 다르다면, 요청을 거부합니다.
			throw new ApiException("400", "권한이 없습니다.");
		}
		// 삭제 성공 여부를 저장합니다.
		boolean deleteResult = odrDtlDAO.deleteAllOdrDtlByOdrLstId(odrDtlVO) > 0;
		
		// 만약 전체 삭제에 성공했다면, 해당 주문서를 삭제합니다.
		if (deleteResult) {
			odrLstDAO.deleteOneOdrLstByOdrLstId(odrDtlVO.getOdrLstId());
		}
		// 삭제 성공 여부를 RestOdrDtlController로 전달합니다.
		return deleteResult;
	}
	
	@Override
	public boolean deleteOdrDtlBySelectedDtlId(List<String> odrDtlId) {
		return odrDtlDAO.deleteOdrDtlBySelectedDtlId(odrDtlId) > 0;
	}

	@Override
	public List<OdrDtlVO> odrDtlForOdrLst(String odrDtlId) {
		return odrDtlDAO.odrDtlForOdrLst(odrDtlId);
	}

	
	
	@Override
	public List<OdrDtlVO> forSale(OdrDtlVO odrDtlVO) {
		return odrDtlDAO.forSale(odrDtlVO);
	}

	@Override
	public List<OdrDtlVO> group(OdrDtlVO odrDtlVO) {
		return odrDtlDAO.group(odrDtlVO);
	}

	@Override
	public List<OdrDtlVO> groupPrdt(OdrDtlVO odrDtlVO) {
		if(odrDtlVO.getStartDt() == null || odrDtlVO.getStartDt().length()==0) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH)+1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String strMonth = month < 10 ? "0" + month : month + "";
			String strDay = day < 10 ? "0" + day : day + "";
			
			String startDt = year+ "-" + strMonth + "-" + strDay;
			odrDtlVO.setStartDt(startDt);
		}
		if(odrDtlVO.getEndDt() == null || odrDtlVO.getEndDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String strMonth = month < 10 ? "0" + month : month + "";
			String strDay = day < 10 ? "0" + day : day + "";
			
			String endDt = year + "-" + strMonth + "-" + strDay;
			odrDtlVO.setEndDt(endDt);
			
		}
		return odrDtlDAO.groupPrdt(odrDtlVO);
	}
	
	@Override
	public List<OdrDtlVO> groupStr(OdrDtlVO odrDtlVO) {
		return odrDtlDAO.groupStr(odrDtlVO);
	}

	
	
	@Override
	public List<OdrDtlVO> oneMonth(OdrDtlVO odrDtlVO) {
		String oneDay = odrDtlVO.getOneDay();
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, -1);
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		int day = cal.get(Calendar.DAY_OF_MONTH);
		
		System.out.println(year + " / " + month + " / " + day  + " / " + oneDay);
		
		
		return odrDtlDAO.oneMonth(odrDtlVO);
	}

	@Override
	public List<OdrDtlVO> startEnd(OdrDtlVO odrDtlVO) {
		return odrDtlDAO.startEnd(odrDtlVO);
	}

	@Override
	public List<OdrDtlVO> viewStrPayments(OdrDtlVO odrDtlVO) {
		return odrDtlDAO.viewStrPayments(odrDtlVO);
	}
	
	
	
	
}
