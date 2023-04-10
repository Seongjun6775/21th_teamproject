package com.ktds.fr.mbr.service;

import java.util.List;

import com.ktds.fr.mbr.vo.MbrVO;

public interface MbrService {
	
	/*로그인 관련*/
	//로그인용 비밀번호 검사
	public String readSaltMbrById(String mbrId);
	//로그인 차단 여부 검사
	public String readLgnBlockYnById(String mbrId);
	//개인 정보 조회용, 로그인용
	public MbrVO readOneMbrByMbrIdAndMbrPwd(MbrVO mbrVO);
	//로그인 성공시
	public boolean updateMbrLgnSucc(MbrVO mbrVO);
	//로그인 실패시
	public boolean updateMbrLgnFail(MbrVO mbrVO);
	//로그인 차단
	public boolean updateMbrLgnBlock(MbrVO mbrVO);
	
	/*회원가입 관련*/
	//아이디 중복검사
	public boolean readCountMbrById(String mbrId);
	//회원 등록
	public boolean createNewMbr(MbrVO mbrVO);

	
	//이용자 조회용
	public List<MbrVO> readAllMbr();
	//하위 관리자 조회용
	public List<MbrVO> readAllEmployeeAdminMbr();
	//회원 수정
	public boolean updateOneMbr(MbrVO mbrVO);
	//회원 삭제
	public boolean deleteOneMbr(String mbrId);

}
