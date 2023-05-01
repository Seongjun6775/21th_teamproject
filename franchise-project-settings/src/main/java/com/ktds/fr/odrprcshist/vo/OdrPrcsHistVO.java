package com.ktds.fr.odrprcshist.vo;

import java.util.List;

public class OdrPrcsHistVO {		
		
	private String odrPrcsHistId;	
	private String odrLstId;	
	private String odrPrcsHistRdrPrcs;	
	private String mdfyr;	
	private String mdfyDt;	
	
	private List<String> odrLstIdList;
	
	public String getOdrPrcsHistId() {	
		return odrPrcsHistId;
	}	
	public void setOdrPrcsHistId(String odrPrcsHistId) {	
		this.odrPrcsHistId = odrPrcsHistId;
	}	
	public String getOdrLstId() {	
		return odrLstId;
	}	
	public void setOdrLstId(String odrLstId) {	
		this.odrLstId = odrLstId;
	}	
	public String getOdrPrcsHistRdrPrcs() {	
		return odrPrcsHistRdrPrcs;
	}	
	public void setOdrPrcsHistRdrPrcs(String odrPrcsHistRdrPrcs) {	
		this.odrPrcsHistRdrPrcs = odrPrcsHistRdrPrcs;
	}	
	public String getMdfyr() {	
		return mdfyr;
	}	
	public void setMdfyr(String mdfyr) {	
		this.mdfyr = mdfyr;
	}	
	public String getMdfyDt() {	
		return mdfyDt;
	}	
	public void setMdfyDt(String mdfyDt) {	
		this.mdfyDt = mdfyDt;
	}
	
	public List<String> getOdrLstIdList() {
		return odrLstIdList;
	}
	public void setOdrLstIdList(List<String> odrLstIdList) {
		this.odrLstIdList = odrLstIdList;
	}	
		
}		
