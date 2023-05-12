package com.ktds.fr.lgnhist.vo;

import com.ktds.fr.mbr.vo.MbrVO;

public class LgnHistVO {

	private String lgnHistId;
	private String mbrId;
	private String lgnHistActn;
	private String lgnHistDt;
	private String lgnHistIp;
	
	private MbrVO mbrVO;
	
	public MbrVO getMbrVO() {
		return mbrVO;
	}

	public void setMbrVO(MbrVO mbrVO) {
		this.mbrVO = mbrVO;
	}

	public String getLgnHistId() {
		return lgnHistId;
	}

	public void setLgnHistId(String lgnHistId) {
		this.lgnHistId = lgnHistId;
	}

	public String getMbrId() {
		return mbrId;
	}

	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}

	public String getLgnHistActn() {
		return lgnHistActn;
	}

	public void setLgnHistActn(String lgnHistActn) {
		this.lgnHistActn = lgnHistActn;
	}

	public String getLgnHistDt() {
		return lgnHistDt;
	}

	public void setLgnHistDt(String lgnHistDt) {
		this.lgnHistDt = lgnHistDt;
	}

	public String getLgnHistIp() {
		return lgnHistIp;
	}

	public void setLgnHistIp(String lgnHistIp) {
		this.lgnHistIp = lgnHistIp;
	}

}
