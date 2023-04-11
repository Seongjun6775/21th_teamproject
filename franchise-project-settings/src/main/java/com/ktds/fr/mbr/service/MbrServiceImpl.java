package com.ktds.fr.mbr.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.common.util.SHA256Util;
import com.ktds.fr.mbr.dao.MbrDAO;
import com.ktds.fr.mbr.vo.MbrVO;

@Service
public class MbrServiceImpl implements MbrService {

	
	private static final Logger log = LoggerFactory.getLogger(MbrServiceImpl.class);
	
	@Autowired
	private MbrDAO mbrDAO;

	@Override
	public MbrVO readOneMbrByMbrIdAndMbrPwd(MbrVO mbrVO) {
		//아이디 차단 여부
		String loginBlockYn = mbrDAO.readLgnBlockYnById(mbrVO.getMbrId());
		log.info("아이디가 뭐니 {}", mbrVO.getMbrId());
		log.info("값이 뭐니 {}",loginBlockYn);
		if(loginBlockYn == null) {
			throw new ApiException("403", "아이디 또는 비밀번호가 일치하지 않습니다.");
		}else if(loginBlockYn.equals("Y")) {
			throw new ApiException("403", "계정이 잠겼습니다. 관리자에게 문의하세요");
		}
		//비밀번호 일치 여부
		String salt = mbrDAO.readSaltMbrById(mbrVO.getMbrId());
		if(salt == null) {
			throw new ApiException("403", "아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		String mbrPwd = mbrVO.getMbrPwd();
		mbrPwd = SHA256Util.getEncrypt(mbrPwd, salt);
		mbrVO.setMbrPwd(mbrPwd);
		MbrVO loginData = mbrDAO.readOneMbrByMbrIdAndMbrPwd(mbrVO);
		//로그인 후 처리
		if(loginData == null) {
			//로그인 실패 처리
			mbrDAO.updateMbrLgnFail(mbrVO);
			mbrDAO.updateMbrLgnBlock(mbrVO);
		}else {
			//성공
			mbrDAO.updateMbrLgnSucc(mbrVO);
			// TODO 로그인 이력 수정하기
		}
		
		return loginData;
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
