package com.ktds.fr.hr.vo;

import com.ktds.fr.common.vo.AbstractVO;

public class HrVO extends AbstractVO {
	
	/**
	 * 채용 지원 ID
	 */
	private String hrId;
	/**
	 * 회원 ID (채용 지원자 ID)
	 */
	private String mbrId;
	/**
	 * 채용 지원글 제목
	 */
	private String hrTtl;
	/**
	 * 채용 지원글 내용
	 */
	private String hrCntnt;
	/**
	 * 채용 지원 등록일
	 */
	private String hrRgstDt;
	/**
	 * 최종 수정일
	 */
	private String hrMdfyDt;
	/**
	 * 채용 승인 여부
	 */
	private String hrAprYn;
	/**
	 * 채용 승인 일자
	 */
	private String hrAprDt;
	/**
	 * 지원 상태 ('접수'(기본값) / '심사중' / '심사완료')
	 */
	private String hrStat;
	/**
	 * 원래 파일 이름
	 */
	private String orgnFlNm;
	/**
	 * 암호화된 파일 이름
	 */
	private String uuidFlNm;
	/**
	 * 파일 크기
	 */
	private long flSize;
	/**
	 * 파일 확장자
	 */
	private String flExt;
	/**
	 * 사용 여부
	 */
	private String useYn;
	/**
	 * 삭제 여부
	 */
	private String delYn;
	/**
	 * 공지 여부
	 */
	private String ntcYn;
	/**
	 * 채용 종류 (점주, 사원)
	 */
	private String hrLvl;
	/**
	 * 채용 종류 이름
	 */
	private String cdNm;
	
	
	public String getHrId() {
		return hrId;
	}
	public void setHrId(String hrId) {
		this.hrId = hrId;
	}
	public String getMbrId() {
		return mbrId;
	}
	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}
	public String getHrTtl() {
		return hrTtl;
	}
	public void setHrTtl(String hrTtl) {
		this.hrTtl = hrTtl;
	}
	public String getHrCntnt() {
		return hrCntnt;
	}
	public void setHrCntnt(String hrCntnt) {
		this.hrCntnt = hrCntnt;
	}
	public String getHrRgstDt() {
		return hrRgstDt;
	}
	public void setHrRgstDt(String hrRgstDt) {
		this.hrRgstDt = hrRgstDt;
	}
	public String getHrMdfyDt() {
		return hrMdfyDt;
	}
	public void setHrMdfyDt(String hrMdfyDt) {
		this.hrMdfyDt = hrMdfyDt;
	}
	public String getHrAprYn() {
		return hrAprYn;
	}
	public void setHrAprYn(String hrAprYn) {
		this.hrAprYn = hrAprYn;
	}
	public String getHrAprDt() {
		return hrAprDt;
	}
	public void setHrAprDt(String hrAprDt) {
		this.hrAprDt = hrAprDt;
	}
	public String getHrStat() {
		return hrStat;
	}
	public void setHrStat(String hrStat) {
		this.hrStat = hrStat;
	}
	public String getOrgnFlNm() {
		return orgnFlNm;
	}
	public void setOrgnFlNm(String orgnFlNm) {
		this.orgnFlNm = orgnFlNm;
	}
	public String getUuidFlNm() {
		return uuidFlNm;
	}
	public void setUuidFlNm(String uuidFlNm) {
		this.uuidFlNm = uuidFlNm;
	}
	public long getFlSize() {
		return flSize;
	}
	public void setFlSize(long flSize) {
		this.flSize = flSize;
	}
	public String getFlExt() {
		return flExt;
	}
	public void setFlExt(String flExt) {
		this.flExt = flExt;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public String getNtcYn() {
		return ntcYn;
	}
	public void setNtcYn(String ntcYn) {
		this.ntcYn = ntcYn;
	}
	public String getHrLvl() {
		return hrLvl;
	}
	public void setHrLvl(String hrLvl) {
		this.hrLvl = hrLvl;
	}
	public String getCdNm() {
		return cdNm;
	}
	public void setCdNm(String cdNm) {
		this.cdNm = cdNm;
	}


}
