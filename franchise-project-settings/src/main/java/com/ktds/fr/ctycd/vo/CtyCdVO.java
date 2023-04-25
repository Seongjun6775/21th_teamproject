package com.ktds.fr.ctycd.vo;

import com.ktds.fr.common.vo.AbstractVO;
import com.ktds.fr.lctcd.vo.LctCdVO;

public class CtyCdVO extends AbstractVO{

	private String ctyId;
	private String ctyNm;
	private String lctId;

	private LctCdVO lctCdVO;
	
	public LctCdVO getLctCdVO() {
		return lctCdVO;
	}

	public void setLctCdVO(LctCdVO lctCdVO) {
		this.lctCdVO = lctCdVO;
	}

	public String getCtyId() {
		return ctyId;
	}

	public void setCtyId(String ctyId) {
		this.ctyId = ctyId;
	}

	public String getCtyNm() {
		return ctyNm;
	}

	public void setCtyNm(String ctyNm) {
		this.ctyNm = ctyNm;
	}

	public String getLctId() {
		return lctId;
	}

	public void setLctId(String lctId) {
		this.lctId = lctId;
	}

}
