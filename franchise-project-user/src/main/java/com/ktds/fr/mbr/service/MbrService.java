package com.ktds.fr.mbr.service;

import java.util.List;

import com.ktds.fr.lgnhist.vo.LgnHistVO;
import com.ktds.fr.mbr.vo.MbrVO;

public interface MbrService {
	
	/*로그인 관련*/
	//로그인용 
	public MbrVO readOneMbrByMbrIdAndMbrPwd(MbrVO mbrVO);
	/*
	 * //로그인용 비밀번호 검사 public String readSaltMbrById(String mbrId); 
	 * //로그인 차단 여부 검사 public String readLgnBlockYnById(String mbrId);  
	 * //로그인 성공시 public boolean updateMbrLgnSucc(MbrVO mbrVO); 
	 * //로그인 실패시 public boolean updateMbrLgnFail(MbrVO mbrVO); 
	 * //로그인 차단 public boolean updateMbrLgnBlock(MbrVO mbrVO);
	 */
	
	/*회원가입 관련*/
	//아이디 중복검사
	public boolean readCountMbrById(String mbrId);
	//회원 등록
	public boolean createNewMbr(MbrVO mbrVO);

	
	//이용자 조회용
	public List<MbrVO> readAllMbr(MbrVO mbrVO);
	//관리자 조회용
	public List<MbrVO> readAllAdminMbr(MbrVO mbrVO);
	//회원 수정
	public boolean updateOneMbr(MbrVO mbrVO);
	//회원 삭제
	public boolean deleteOneMbr(String mbrId);
	//비밀번호 확인
	public MbrVO readOneMbrByPwd(MbrVO mbrVO);
	//개인정보 조회용
	public MbrVO readOneMbrByMbrId(String mbrId);
	//비밀번호 변경용
	public boolean updateOneMbrPwd(MbrVO mbrVO);
	//로그아웃 이력 찍기
	public boolean logoutMbr(LgnHistVO lgnHistVO);
	//ID 찾기용
	public List<MbrVO> readMbrByMbrEml(MbrVO mbrVO);
	//PW 찾기용
	public boolean updateMbrPwdByMbrIdAndMbrEml(MbrVO mbrVO);
	//권한 및 소소 수정용
	public boolean updateOneMbrLvlAndStrId(MbrVO mbrVO);
	//관리자 권한 해임용
	public boolean deleteOneMbrAdminByMbrId(MbrVO mbrVO);
}
