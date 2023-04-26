package com.ktds.fr.evntprdt.vo;

import com.ktds.fr.common.vo.AbstractVO;
import com.ktds.fr.prdt.vo.PrdtVO;

public class EvntPrdtVO  extends AbstractVO{		
		
	private String evntPrdtId;	
	private String evntId;	
	private String prdtId;	
	private int evntPrdtChngPrc;	
	private String useYn;	
	private String delYn;
	
	/* 상품 */
	private String prdtNm;
	private int prdtPrc;
	private PrdtVO prdtVO;
	
	/* 이벤트 날짜 */
	private String evntStrtDt;
	private String evntEndDt;
	
	
	public String getEvntPrdtId() {	
		return evntPrdtId;
	}	
	public void setEvntPrdtId(String evntPrdtId) {	
		this.evntPrdtId = evntPrdtId;
	}	
	public String getEvntId() {	
		return evntId;
	}	
	public void setEvntId(String evntId) {	
		this.evntId = evntId;
	}	
	public String getPrdtId() {	
		return prdtId;
	}	
	public void setPrdtId(String prdtId) {	
		this.prdtId = prdtId;
	}	
	public int getEvntPrdtChngPrc() {	
		return evntPrdtChngPrc;
	}	
	public void setEvntPrdtChngPrc(int evntPrdtChngPrc) {	
		this.evntPrdtChngPrc = evntPrdtChngPrc;
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
	public String getPrdtNm() {
		return prdtNm;
	}
	public void setPrdtNm(String prdtNm) {
		this.prdtNm = prdtNm;
	}
	public int getPrdtPrc() {
		return prdtPrc;
	}
	public void setPrdtPrc(int prdtPrc) {
		this.prdtPrc = prdtPrc;
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
	
	public PrdtVO getPrdtVO() {
		return prdtVO;
	}
	public void setPrdtVO(PrdtVO prdtVO) {
		this.prdtVO = prdtVO;
	}
	
		
}