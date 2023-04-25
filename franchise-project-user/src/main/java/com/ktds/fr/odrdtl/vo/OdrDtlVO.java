package com.ktds.fr.odrdtl.vo;

import com.ktds.fr.common.vo.AbstractVO;
import com.ktds.fr.prdt.vo.PrdtVO;
import com.ktds.fr.str.vo.StrVO;

public class OdrDtlVO extends AbstractVO{
	
	/**
	 * 주문상세 ID
	 */
	private String odrDtlId;
	/**
	 * 주문서 ID
	 */
	private String odrLstId;
	/**
	 * 주문한 상품 ID
	 */
	private String odrDtlPrdtId;
	/**
	 * 주문한 상품 갯수
	 */
	private int odrDtlPrdtCnt;
	/**
	 * 주문한 매장 ID
	 */
	private String odrDtlStrId;
	/**
	 * 사용 여부
	 */
	private String useYn;
	/**
	 * 삭제 여부
	 */
	private String delYn;
	/**
	 * 주문한 회원 ID
	 */
	private String mbrId;
	
	private PrdtVO prdtVO;
	private StrVO strVO;

	public String getOdrDtlId() {
		return odrDtlId;
	}

	public void setOdrDtlId(String odrDtlId) {
		this.odrDtlId = odrDtlId;
	}

	public String getOdrLstId() {
		return odrLstId;
	}

	public void setOdrLstId(String odrLstId) {
		this.odrLstId = odrLstId;
	}

	public String getOdrDtlPrdtId() {
		return odrDtlPrdtId;
	}

	public void setOdrDtlPrdtId(String odrDtlPrdtId) {
		this.odrDtlPrdtId = odrDtlPrdtId;
	}

	public int getOdrDtlPrdtCnt() {
		return odrDtlPrdtCnt;
	}

	public void setOdrDtlPrdtCnt(int odrDtlPrdtCnt) {
		this.odrDtlPrdtCnt = odrDtlPrdtCnt;
	}

	public String getOdrDtlStrId() {
		return odrDtlStrId;
	}

	public void setOdrDtlStrId(String odrDtlStrId) {
		this.odrDtlStrId = odrDtlStrId;
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

	public PrdtVO getPrdtVO() {
		return prdtVO;
	}

	public void setPrdtVO(PrdtVO prdtVO) {
		this.prdtVO = prdtVO;
	}

	public StrVO getStrVO() {
		return strVO;
	}

	public void setStrVO(StrVO strVO) {
		this.strVO = strVO;
	}
	

}
