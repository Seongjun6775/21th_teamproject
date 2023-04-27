package com.ktds.fr.evntstr.vo;

import com.ktds.fr.common.vo.AbstractVO;

public class EvntStrVO extends AbstractVO{

	private String evntStrId;
	private String evntId;
	/* 이벤트 제목 */
	private String evntTtl;
	/* 이벤트 내용 */
	private String evntCntnt;
	/* 이벤트 시작일 */
	private String evntStrtDt;
	/* 이벤트 종료일 */
	private String evntEndDt;

	private String strId;
	private String strNm;
	private String useYn;
	private String delYn;

	private String mbrId;
	private String mbrNm;

	public String getEvntStrId() {
		return evntStrId;
	}

	public void setEvntStrId(String evntStrId) {
		this.evntStrId = evntStrId;
	}

	public String getEvntId() {
		return evntId;
	}

	public void setEvntId(String evntId) {
		this.evntId = evntId;
	}

	public String getEvntTtl() {
		return evntTtl;
	}

	public void setEvntTtl(String evntTtl) {
		this.evntTtl = evntTtl;
	}

	public String getEvntCntnt() {
		return evntCntnt;
	}

	public void setEvntCntnt(String evntCntnt) {
		this.evntCntnt = evntCntnt;
	}

	public String getEvntStrtDt() {
		return evntStrtDt;
	}

	public void setEvntStrtDt(String evntStrtDt) {
		this.evntStrtDt = evntStrtDt;
	}

	public String getEvntEndDt() {
		return evntEndDt;
	}

	public void setEvntEndDt(String evntEndDt) {
		this.evntEndDt = evntEndDt;
	}

	public String getStrId() {
		return strId;
	}

	public void setStrId(String strId) {
		this.strId = strId;
	}

	public String getStrNm() {
		return strNm;
	}

	public void setStrNm(String strNm) {
		this.strNm = strNm;
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

	public String getMbrId() {
		return mbrId;
	}

	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}

	public String getMbrNm() {
		return mbrNm;
	}

	public void setMbrNm(String mbrNm) {
		this.mbrNm = mbrNm;
	}


}



