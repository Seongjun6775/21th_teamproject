package com.ktds.fr.odrdtl.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
		// 이전에 주문이 완료되지 않은 주문서가 존재하는지 확인합니다.
		int remainList = odrLstDAO.checkRemainOdrLst(odrDtlVO.getMbrId());
		
		boolean createResult = false;
		
		// 만약 '대기'상태였던 주문서가 있다면, 새로운 OdrDtl을 그 안에 추가합니다.
		if (remainList > 0) {
			// odrDtl 내의 mbrId로 OdrLst에 접근해, 이미 존재하는 주문서 ID를 받아옵니다.
			OdrLstVO OdrLstId = odrLstDAO.getOdrLstId(odrDtlVO.getMbrId());
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
			
			int odrList = odrLstDAO.createNewOdrLst(odrLstVO);
			
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
		return odrDtlDAO.updateOneOdrDtlByOdrDtlId(odrDtlVO) > 0;
	}

	@Override
	public boolean deleteOneOdrDtlByOdrDtlId(String odrDtlId) {
		return odrDtlDAO.deleteOneOdrDtlByOdrDtlId(odrDtlId) > 0;
	}
	
	@Override
	public boolean deleteOdrDtlBySelectedDtlId(List<String> odrDtlId) {
		return odrDtlDAO.deleteOdrDtlBySelectedDtlId(odrDtlId) > 0;
	}
	
}
