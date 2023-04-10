package com.ktds.fr.mbr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.common.util.SHA256Util;
import com.ktds.fr.mbr.dao.MbrDAO;
import com.ktds.fr.mbr.vo.MbrVO;

@Service
public class MbrServiceImpl implements MbrService {

	@Autowired
	private MbrDAO mbrDAO;

	@Override
	public String readSaltMbrById(String mbrId) {
		return mbrDAO.readSaltMbrById(mbrId);
	}

	@Override
	public String readLgnBlockYnById(String mbrId) {
		return mbrDAO.readLgnBlockYnById(mbrId);
	}

	@Override
	public MbrVO readOneMbrByMbrIdAndMbrPwd(MbrVO mbrVO) {
		return mbrDAO.readOneMbrByMbrIdAndMbrPwd(mbrVO);
	}

	@Override
	public boolean updateMbrLgnSucc(MbrVO mbrVO) {
		return mbrDAO.updateMbrLgnSucc(mbrVO) > 0;
	}

	@Override
	public boolean updateMbrLgnFail(MbrVO mbrVO) {
		return mbrDAO.updateMbrLgnFail(mbrVO) > 0;
	}

	@Override
	public boolean updateMbrLgnBlock(MbrVO mbrVO) {
		return mbrDAO.updateMbrLgnBlock(mbrVO) > 0;
	}

	@Override
	public boolean readCountMbrById(String mbrId) {
		return mbrDAO.readCountMbrById(mbrId) > 0;
	}

	@Override
	public boolean createNewMbr(MbrVO mbrVO) {
		String mbrPwd = mbrVO.getMbrPwd();
		String salt = SHA256Util.generateSalt();
		mbrVO.setMbrPwdSlt(salt);
		
		mbrPwd = SHA256Util.getEncrypt(mbrPwd, salt);
		mbrVO.setMbrPwd(mbrPwd);
		mbrVO.setMbrLvl("MEMBER");
		
		return mbrDAO.createNewMbr(mbrVO) > 0;
	}

	@Override
	public List<MbrVO> readAllMbr() {
		return mbrDAO.readAllMbr();
	}

	@Override
	public List<MbrVO> readAllEmployeeAdminMbr() {
		return mbrDAO.readAllEmployeeAdminMbr();
	}

	@Override
	public boolean updateOneMbr(MbrVO mbrVO) {
		return mbrDAO.updateOneMbr(mbrVO) > 0;
	}

	@Override
	public boolean deleteOneMbr(String mbrId) {
		return mbrDAO.deleteOneMbr(mbrId) > 0;
	}
	
	
}
