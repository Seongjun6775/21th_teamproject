package com.ktds.fr.odrlst.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.mbr.dao.MbrDAO;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.odrlst.dao.OdrLstDAO;
import com.ktds.fr.odrlst.vo.OdrLstVO;

@Service
public class OdrLstServiceImpl implements OdrLstService {
	
	@Autowired
	private OdrLstDAO odrLstDAO;
	
	@Autowired
	private MbrDAO mbrDAO;

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
	public boolean deleteOneOdrLstByOdrLstId(OdrLstVO odrLstVO) {
		return odrLstDAO.deleteOneOdrLstByOdrLstId(odrLstVO) > 0;
	}

}
