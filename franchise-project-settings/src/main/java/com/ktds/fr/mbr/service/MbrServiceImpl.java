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

import com.ktds.fr.chsrl.dao.ChSrlDAO;
import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.common.util.SHA256Util;
import com.ktds.fr.hr.dao.HrDAO;
import com.ktds.fr.hr.vo.HrVO;
import com.ktds.fr.lgnhist.dao.LgnHistDAO;
import com.ktds.fr.lgnhist.vo.LgnHistVO;
import com.ktds.fr.mbr.dao.MbrDAO;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.str.dao.StrDAO;
import com.ktds.fr.str.vo.StrVO;

@Service
public class MbrServiceImpl implements MbrService {

	
	private static final Logger log = LoggerFactory.getLogger(MbrServiceImpl.class);
	
	@Autowired
	private MbrDAO mbrDAO;
	
	@Autowired
	private LgnHistDAO lgnHistDAO;
	
	@Autowired
	private ChSrlDAO chSrlDAO;
	
	@Autowired
	private StrDAO strDAO;
	
	@Autowired
	private HrDAO hrDAO;

	@Override	//로그인
	public MbrVO readOneMbrByMbrIdAndMbrPwd(MbrVO mbrVO) {
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
	public List<MbrVO> readAllAdminMbr(MbrVO mbrVO) {
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
		return mbrDAO.readAllAdminMbr(mbrVO);
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
		MbrVO mbrVO = mbrDAO.readOneMbrByMbrId(mbrId);
		if(mbrVO==null) {
			throw new ApiException(ApiStatus.FAIL, "조회에 실패했습니다.");
		}
		return mbrVO;
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
	public List<MbrVO> readMbrByMbrEml(MbrVO mbrVO) {
		//이메일 주소 있는지 확인
		List<MbrVO> mbrList = mbrDAO.readMbrByMbrEml(mbrVO);
		if(mbrList == null || mbrList.size() == 0) {
			throw new ApiException(ApiStatus.FAIL, "이메일을 확인해 주세요.");
		}
		//아이디 전달 - 암호화 하여서 뒤에 3글자만 *로 바꾸어서
		MbrVO mbr = null;
		for(int i =0; i<mbrList.size(); i +=1) {
			String mbrId = mbrList.get(i).getMbrId();
			mbrId = mbrId.substring(0, mbrId.length()-3) + "***";
			mbr = mbrList.get(i);
			mbr.setMbrId(mbrId);
		}
		return mbrList;
	}
	@Override
	public boolean updateMbrPwdByMbrIdAndMbrEml(MbrVO mbrVO) {
		boolean dupMbrid = this.readCountMbrById(mbrVO.getMbrId());
		if(!dupMbrid) {
			throw new ApiException(ApiStatus.FAIL, "아이디를 확인해 주세요.");
		}
		boolean updateResult = this.updateOneMbrPwd(mbrVO);
		if(!updateResult) {
			throw new ApiException(ApiStatus.FAIL, "비밀번호 찾기에 실패했습니다. 다시 시도해 주세요.");
		}
		return updateResult;
	}
	@Override
	public boolean updateOneMbrLvlAndStrId(MbrVO mbrVO) {
		//등급만 변경할 경우
		if(mbrVO.getStrId() == null || mbrVO.getStrId().length() == 0) {
			boolean updateLvlResult = this.updateMbrLvl(mbrVO);
			if(updateLvlResult) {
				chSrlDAO.createOneChHist(mbrVO);
				return updateLvlResult;
			}
			throw new ApiException(ApiStatus.FAIL, "권한/소속 변경에 실패했습니다. 다시 시도해 주세요.");
		}
		//TODO 주석 지우기
		//소속만 변경할 경우
		//중간 관리자의 소속변경
		else if(mbrVO.getMbrLvl().equals(mbrVO.getOriginMbrLvl())) {
			return this.updateStr(mbrVO);
		}
		//등급과 소속 같이 변경할 경우
		else if(!mbrVO.getMbrLvl().equals(mbrVO.getOriginMbrLvl())) {
			return this.updateMbrLvl(mbrVO) && this.updateStr(mbrVO);
		}
		return false;
	}
	@Override
	public boolean deleteAllMbrAdminByMbrId(MbrVO mbrVO, List<String>mbrIdList) {
		if( !mbrVO.getMbrLvl().equals("001-01") || mbrVO.getMbrLvl() == null || mbrVO.getMbrLvl().length()==0) {
			throw new ApiException(ApiStatus.FAIL, "해임에 실패했습니다. 다시 시도 해주세요.");
		}
		//STR 테이블에서 mbrIdList를 가지고 검색 -> 매장찾기
		List<String> strIdList = strDAO.readAllStrByMbrId(mbrIdList);
		log.info("검사 하기{}",strIdList);
		if(strIdList == null || strIdList.size()==0) {
			//없으면 MBR테이블의 str_id->null && MBR테이블의 mbrLvl -> default로
			//채용 페이지에 이력서 delYn=Y으로 바꾸기
			boolean delResult = mbrDAO.deleteAllMbrAdminByMbrId(mbrIdList) > 0;
			if(!delResult) {
				throw new ApiException(ApiStatus.FAIL, "해임에 실패했습니다. 다시 시도 해주세요");
			}
			hrDAO.deleteAllHrByMbrId(mbrIdList);
			return delResult;
		}else {
			//있으면 해당 mbrId -> null
			strDAO.deleteAllManagerByStrId(strIdList);
			boolean delResult = mbrDAO.deleteAllMbrAdminByMbrId(mbrIdList) > 0;
			if(!delResult) {
				throw new ApiException(ApiStatus.FAIL, "해임에 실패했습니다. 다시 시도 해주세요");
			}
			hrDAO.deleteAllHrByMbrId(mbrIdList);
			return delResult;
		}
	}
	
	@Override
	public List<MbrVO> readAllCrewMbrByStrId(MbrVO mbrVO) {
		if(mbrVO.getMbrLvl().equals("001-03") || mbrVO.getMbrLvl().equals("001-04")) {
			throw new ApiException(ApiStatus.FAIL, "권한이 없습니다.");
		}
		return mbrDAO.readAllCrewMbrByStrId(mbrVO);
	}
	
	@Override
	public MbrVO readOneCrewByMbrId(String mbrId) {
		if(mbrId == null || mbrId.length() == 0) {
			throw new ApiException(ApiStatus.FAIL, "관리자 조회에 실패하였습니다.");
		}
		MbrVO mbrVO = mbrDAO.readOneCrewByMbrId(mbrId);
		if(mbrVO==null) {
			throw new ApiException(ApiStatus.FAIL, "관리자 조회에 실패하였습니다.");
		}
		HrVO readHrVO = hrDAO.readOneHrByMbrId(mbrId);
		mbrVO.setHrVO(readHrVO);
		return mbrVO;
	}
	
	public boolean updateMbrLvl(MbrVO mbrVO) {
		if(mbrVO.getMbrLvl().equals("001-02")) {
			int updateResult = mbrDAO.updateOneMbrLvlAndStrId(mbrVO);
			if(updateResult > 0) {
				return updateResult > 0;
			}
			else {
				throw new ApiException(ApiStatus.FAIL, "권한/소속 변경에 실패했습니다. 다시 시도해 주세요.");
			}
		}
		else if(mbrVO.getMbrLvl().equals("001-03")) {
			int updateResult = mbrDAO.updateOneMbrLvlAndStrId(mbrVO);
			if(updateResult > 0) {
				int delResult = strDAO.deleteOneManagerByMbrId(mbrVO.getMbrId());
				return (updateResult > 0) && (delResult > 0);
			}
			else {
				throw new ApiException(ApiStatus.FAIL, "권한/소속 변경에 실패했습니다. 다시 시도해 주세요.");
			}
		}
		return false;
	}
	public boolean updateStr(MbrVO mbrVO) {
		if(mbrVO.getMbrLvl().equals("001-02")) {
			int readResult = strDAO.readOneStrByMbrId(mbrVO.getMbrId());
			if(readResult > 0) {
				boolean delResult = strDAO.deleteOneManagerByMbrId(mbrVO.getMbrId()) > 0;
				boolean updateStrResult = strDAO.updateOneStrByStrIdAndMbrId(mbrVO) > 0;
				boolean updateMbrResult = mbrDAO.updateOneMbrLvlAndStrId(mbrVO) > 0;
				if(delResult && updateStrResult && updateMbrResult ) {
					chSrlDAO.createOneChHist(mbrVO);
					return updateMbrResult;
				}else {
					throw new ApiException(ApiStatus.FAIL, "권한/소속 변경에 실패했습니다. 다시 시도해 주세요.");
				}
			}
			else {
				boolean updateStrResult = strDAO.updateOneStrByStrIdAndMbrId(mbrVO) > 0;
				boolean updateMbrResult = mbrDAO.updateOneMbrLvlAndStrId(mbrVO) > 0;
				if(updateStrResult && updateMbrResult) {
					chSrlDAO.createOneChHist(mbrVO);
					return updateMbrResult;
				}else {
					throw new ApiException(ApiStatus.FAIL, "권한/소속 변경에 실패했습니다. 다시 시도해 주세요.");
				}
			}
		}else if(mbrVO.getMbrLvl().equals("001-03")) {
			boolean updateMbrResult = mbrDAO.updateOneMbrLvlAndStrId(mbrVO) > 0;
			if(updateMbrResult) {
				chSrlDAO.createOneChHist(mbrVO);
				return updateMbrResult;
			}else {
				throw new ApiException(ApiStatus.FAIL, "권한/소속 변경에 실패했습니다. 다시 시도해 주세요.");
			}
		}
		return false;
	}
}
