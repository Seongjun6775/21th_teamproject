package com.ktds.fr.odrlst.vo;

public class OdrLstVO {
	/**
	 * 장바구니 ID
	 */
	private String odrLstId;
	/**
	 * 회원 ID
	 */
	private String mbrId;
	/**
	 * 주문 처리 여부
	 */
	private String odrLstOdrPrcs;
	/**
	 * 주문 등록일
	 */
	private String odrLstRgstDt;
	/**
	 * 주문 등록자 (주문을 받은 직원 ID?)
	 */
	private String odrLstRgstr;
	/**
	 * 주문 수정일
	 */
	private String mdfyDt;
	/**
	 * 주문 수정자 (수정을 확인한 직원 ID?)
	 */
	private String mdfyr;
	/**
	 * 사용 여부
	 */
	private String useYn;
	/**
	 * 삭제 여부
	 */
	private String delYn;

	public String getOdrLstId() {
		return odrLstId;
	}

	public void setOdrLstId(String odrLstId) {
		this.odrLstId = odrLstId;
	}

	public String getMbrId() {
		return mbrId;
	}

	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}

	public String getOdrLstOdrPrcs() {
		return odrLstOdrPrcs;
	}

	public void setOdrLstOdrPrcs(String odrLstOdrPrcs) {
		this.odrLstOdrPrcs = odrLstOdrPrcs;
	}

	public String getOdrLstRgstDt() {
		return odrLstRgstDt;
	}

	public void setOdrLstRgstDt(String odrLstRgstDt) {
		this.odrLstRgstDt = odrLstRgstDt;
	}

	public String getOdrLstRgstr() {
		return odrLstRgstr;
	}

	public void setOdrLstRgstr(String odrLstRgstr) {
		this.odrLstRgstr = odrLstRgstr;
	}

	public String getMdfyDt() {
		return mdfyDt;
	}

	public void setMdfyDt(String mdfyDt) {
		this.mdfyDt = mdfyDt;
	}

	public String getMdfyr() {
		return mdfyr;
	}

	public void setMdfyr(String mdfyr) {
		this.mdfyr = mdfyr;
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
