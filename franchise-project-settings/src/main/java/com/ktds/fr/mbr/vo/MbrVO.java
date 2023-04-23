package com.ktds.fr.mbr.vo;

import com.ktds.fr.cmmncd.vo.CmmnCdVO;
import com.ktds.fr.common.vo.AbstractVO;
import com.ktds.fr.str.vo.StrVO;

public class MbrVO extends AbstractVO {

	private String mbrId;
	private String strId;
	private String mbrNm;
	private String mbrPwd;
	private String mbrEml;
	private String mbrLeavDt;
	private String mbrRcntLgnDt;
	private String mbrRcntLgnIp;
	private int mbrLgnFlCnt;
	private String mbrLgnBlckYn;
	private String mbrLstLgnFlDt;
	private String mbrPwdSlt;
	private String mbrPwdChngDt;
	private String mbrLvl;
	private int mbrPyMn;
	private String mbrRgstrDt;
	private String useYn;
	private String delYn;

	/**
	 * 변경전 회원 등급
	 */
	private String originMbrLvl;
	/**
	 * 변경전 매장 ID
	 */
	private String originStrId;

	/**
	 * 회원 등급 변경자
	 */
	private String mdfyr;

	/**
	 * 공통코드
	 */
	private CmmnCdVO cmmnCdVO;
	/**
	 * 매장 정보
	 */
	private StrVO strVO;

	public StrVO getStrVO() {
		return strVO;
	}

	public void setStrVO(StrVO strVO) {
		this.strVO = strVO;
	}

	public String getOriginMbrLvl() {
		return originMbrLvl;
	}

	public void setOriginMbrLvl(String originMbrLvl) {
		this.originMbrLvl = originMbrLvl;
	}

	public String getOriginStrId() {
		return originStrId;
	}

	public void setOriginStrId(String originStrId) {
		this.originStrId = originStrId;
	}

	public String getMdfyr() {
		return mdfyr;
	}

	public void setMdfyr(String mdfyr) {
		this.mdfyr = mdfyr;
	}

	public CmmnCdVO getCmmnCdVO() {
		return cmmnCdVO;
	}

	public void setCmmnCdVO(CmmnCdVO cmmnCdVO) {
		this.cmmnCdVO = cmmnCdVO;
	}

	public String getMbrId() {
		return mbrId;
	}

	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}

	public String getStrId() {
		return strId;
	}

	public void setStrId(String strId) {
		this.strId = strId;
	}

	public String getMbrNm() {
		return mbrNm;
	}

	public void setMbrNm(String mbrNm) {
		this.mbrNm = mbrNm;
	}

	public String getMbrPwd() {
		return mbrPwd;
	}

	public void setMbrPwd(String mbrPwd) {
		this.mbrPwd = mbrPwd;
	}

	public String getMbrEml() {
		return mbrEml;
	}

	public void setMbrEml(String mbrEml) {
		this.mbrEml = mbrEml;
	}

	public String getMbrLeavDt() {
		return mbrLeavDt;
	}

	public void setMbrLeavDt(String mbrLeavDt) {
		this.mbrLeavDt = mbrLeavDt;
	}

	public String getMbrRcntLgnDt() {
		return mbrRcntLgnDt;
	}

	public void setMbrRcntLgnDt(String mbrRcntLgnDt) {
		this.mbrRcntLgnDt = mbrRcntLgnDt;
	}

	public String getMbrRcntLgnIp() {
		return mbrRcntLgnIp;
	}

	public void setMbrRcntLgnIp(String mbrRcntLgnIp) {
		this.mbrRcntLgnIp = mbrRcntLgnIp;
	}

	public int getMbrLgnFlCnt() {
		return mbrLgnFlCnt;
	}

	public void setMbrLgnFlCnt(int mbrLgnFlCnt) {
		this.mbrLgnFlCnt = mbrLgnFlCnt;
	}

	public String getMbrLgnBlckYn() {
		return mbrLgnBlckYn;
	}

	public void setMbrLgnBlckYn(String mbrLgnBlckYn) {
		this.mbrLgnBlckYn = mbrLgnBlckYn;
	}

	public String getMbrLstLgnFlDt() {
		return mbrLstLgnFlDt;
	}

	public void setMbrLstLgnFlDt(String mbrLstLgnFlDt) {
		this.mbrLstLgnFlDt = mbrLstLgnFlDt;
	}

	public String getMbrPwdSlt() {
		return mbrPwdSlt;
	}

	public void setMbrPwdSlt(String mbrPwdSlt) {
		this.mbrPwdSlt = mbrPwdSlt;
	}

	public String getMbrPwdChngDt() {
		return mbrPwdChngDt;
	}

	public void setMbrPwdChngDt(String mbrPwdChngDt) {
		this.mbrPwdChngDt = mbrPwdChngDt;
	}

	public String getMbrLvl() {
		return mbrLvl;
	}

	public void setMbrLvl(String mbrLvl) {
		this.mbrLvl = mbrLvl;
	}

	public int getMbrPyMn() {
		return mbrPyMn;
	}

	public void setMbrPyMn(int mbrPyMn) {
		this.mbrPyMn = mbrPyMn;
	}

	public String getMbrRgstrDt() {
		return mbrRgstrDt;
	}

	public void setMbrRgstrDt(String mbrRgstrDt) {
		this.mbrRgstrDt = mbrRgstrDt;
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

}
