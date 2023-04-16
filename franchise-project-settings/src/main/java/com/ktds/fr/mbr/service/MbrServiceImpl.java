package com.ktds.fr.mbr.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.common.util.SHA256Util;
import com.ktds.fr.lgnhist.dao.LgnHistDAO;
import com.ktds.fr.lgnhist.vo.LgnHistVO;
import com.ktds.fr.mbr.dao.MbrDAO;
import com.ktds.fr.mbr.vo.MbrVO;

@Service
public class MbrServiceImpl implements MbrService {

	
	private static final Logger log = LoggerFactory.getLogger(MbrServiceImpl.class);
	
	@Autowired
	private MbrDAO mbrDAO;
	
	@Autowired
	private LgnHistDAO lgnHistDAO;

	@Override	//로그인
	public MbrVO readOneMbrByMbrIdAndMbrPwd(MbrVO mbrVO) {
		//TODO 삭제할 log
		log.info("아이디는 {}",mbrVO.getMbrId());
		//아이디 차단 여부
		String loginBlockYn = mbrDAO.readLgnBlockYnById(mbrVO.getMbrId());
		if(loginBlockYn == null) {
			throw new ApiException("403", "계정정보없음");
		}else if(loginBlockYn.equals("Y")) {
			throw new ApiException("403", "계정이 잠겼습니다. 관리자에게 문의하세요.");
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
			mbrVO.setMbrLgnFlCnt(mbrDAO.readOneMbrLgnFailCnt(mbrVO.getMbrId()));
			mbrDAO.updateMbrLgnBlock(mbrVO);
		}else {
			//성공
			mbrDAO.updateMbrLgnSucc(mbrVO);
			// TODO 로그인 이력 수정하기
			LgnHistVO lgnHistVO = new LgnHistVO();
			lgnHistVO.setLgnHistActn("login");
			lgnHistVO.setMbrId(mbrVO.getMbrId());
			lgnHistVO.setLgnHistIp(mbrVO.getMbrRcntLgnIp());
			lgnHistDAO.createMbrLgnHist(lgnHistVO);
		}
		
		return loginData;
	}

	@Override	//아이디 중복 체크
	public boolean readCountMbrById(String mbrId) {
		return mbrDAO.readCountMbrById(mbrId) > 0;
	}

	@Override // 회원 등록
	public boolean createNewMbr(MbrVO mbrVO) {
		String mbrPwd = mbrVO.getMbrPwd();
		String salt = SHA256Util.generateSalt();
		mbrVO.setMbrPwdSlt(salt);
		
		mbrPwd = SHA256Util.getEncrypt(mbrPwd, salt);
		mbrVO.setMbrPwd(mbrPwd);
		
		return mbrDAO.createNewMbr(mbrVO) > 0;
	}

	@Override // 회원 전체 조회
	public List<MbrVO> readAllMbr() {
		return mbrDAO.readAllMbr();
	}

	@Override // 하위관리자 전체 조회
	public List<MbrVO> readAllEmployeeAdminMbr() {
		return mbrDAO.readAllEmployeeAdminMbr();
	}

	@Override // 회원 정보 수정
	public boolean updateOneMbr(MbrVO mbrVO) {
		return mbrDAO.updateOneMbr(mbrVO) > 0;
	}

	@Override // 회원 탈퇴
	public boolean deleteOneMbr(String mbrId) {
		return mbrDAO.deleteOneMbr(mbrId) > 0;
	}
	
	
}
