package com.ktds.fr.odrdtl.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.odrdtl.dao.OdrDtlDAO;
import com.ktds.fr.odrdtl.vo.OdrDtlVO;

@Service
public class OdrDtlServiceImpl implements OdrDtlService {
	
	@Autowired
	public OdrDtlDAO odrDtlDAO;

	@Override
	public boolean createNewOdrDtl(OdrDtlVO odrDtlVO) {
		return odrDtlDAO.createNewOdrDtl(odrDtlVO) > 0;
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
