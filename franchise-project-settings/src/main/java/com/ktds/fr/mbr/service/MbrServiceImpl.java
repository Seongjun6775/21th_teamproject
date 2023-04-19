package com.ktds.fr.mbr.service;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.catalina.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.common.api.vo.ApiStatus;
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
	public List<MbrVO> readAllMbr(MbrVO mbrVO) {
		if(mbrVO.getStartDt() == null || mbrVO.getStartDt().length()==0) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH)+1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String strMonth = month < 10 ? "0" + month : month + "";
			String strDay = day < 10 ? "0" + day : day + "";
			
			String startDt = year+ "-" + strMonth + "-" + strDay;
			mbrVO.setStartDt(startDt);
		}
		if(mbrVO.getEndDt() == null || mbrVO.getEndDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String strMonth = month < 10 ? "0" + month : month + "";
			String strDay = day < 10 ? "0" + day : day + "";
			
			String endDt = year + "-" + strMonth + "-" + strDay;
			mbrVO.setEndDt(endDt);
			
		}
		return mbrDAO.readAllMbr(mbrVO);
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
	
	@Override
	public MbrVO readOneMbrByPwd(MbrVO mbrVO) {
		//비밀번호 일치 여부
		String salt = mbrDAO.readSaltMbrById(mbrVO.getMbrId());
		if(salt == null) {
			throw new ApiException("500", "오류가 발생했습니다. 다시 시도해주세요.");
		}
		String mbrPwd = mbrVO.getMbrPwd();
		mbrPwd = SHA256Util.getEncrypt(mbrPwd, salt);
		mbrVO.setMbrPwd(mbrPwd);
		MbrVO loginData = mbrDAO.readOneMbrByMbrIdAndMbrPwd(mbrVO);
		if(loginData == null) {
			//실패처리
			throw new ApiException(ApiStatus.FAIL, "비밀번호가 다릅니다.");
		}else {
			//성공
			return loginData;
		}
	}
	@Override
	public MbrVO readOneMbrByMbrId(String mbrId) {
		return mbrDAO.readOneMbrByMbrId(mbrId);
	}
	@Override
	public boolean updateOneMbrPwd(MbrVO mbrVO) {
		String mbrPwd = mbrVO.getMbrPwd();
		String salt = SHA256Util.generateSalt();
		mbrVO.setMbrPwdSlt(salt);
		
		mbrPwd = SHA256Util.getEncrypt(mbrPwd, salt);
		mbrVO.setMbrPwd(mbrPwd);
		return mbrDAO.updateOneMbrPwd(mbrVO) > 0;
	}
	@Override
	public boolean logoutMbr(LgnHistVO lgnHistVO) {
		return lgnHistDAO.createMbrLgnHist(lgnHistVO) > 0;
	}
	@Override
	public List<String> readMbrByMbrEml(String mbrEml, String type) {
		//이메일 주소 있는지 확인
		List<String> mbrList = mbrDAO.readMbrByMbrEml(mbrEml);
		if(mbrList == null || mbrList.size() == 0) {
			throw new ApiException(ApiStatus.FAIL, "이메일을 확인해 주세요.");
		}
		if(type.equals("id")) {
			//아이디 전달 - 암호화 하여서 뒤에 3글자만 *로 바꾸어서
			for(int i =0; i<mbrList.size(); i +=1) {
				String mbrId = mbrList.get(i);
				mbrId = mbrId.substring(0, mbrId.length()-3) + "***";
				mbrList.add(i, mbrId);
			}
		}else if(type.equals("pw")) {
			
		}
		
		//비밀번호 초기화 후 전달
		return mbrList;
	}
}
