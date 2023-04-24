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
	public List<OdrDtlVO> readAllOdrDtlByOdrLstId(String mbrId) {
		return odrDtlDAO.readAllOdrDtlByOdrLstId(mbrId);
	}
	
	@Override
	public OdrDtlVO readOneOdrDtlByOdrDtlId(String odrDtlId) {
		return odrDtlDAO.readOneOdrDtlByOdrDtlId(odrDtlId);
	}

	@Override
	public boolean updateOneOdrDtlByOdrDtlId(String odrDtlId) {
		return odrDtlDAO.updateOneOdrDtlByOdrDtlId(odrDtlId) > 0;
	}

	@Override
	public boolean deleteOneOdrDtlByOdrDtlId(String odrDtlId) {
		return odrDtlDAO.deleteOneOdrDtlByOdrDtlId(odrDtlId) > 0;
	}
	
	
}
