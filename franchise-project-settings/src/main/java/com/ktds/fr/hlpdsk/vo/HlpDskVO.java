package com.ktds.fr.hlpdsk.vo;

import com.ktds.fr.common.vo.AbstractVO;
import com.ktds.fr.mbr.vo.MbrVO;

public class HlpDskVO extends AbstractVO{		
		
	private String hlpDskWrtId;	
	private String hlpDskSbjct;	
	private String hlpDskTtl;	
	private String hlpDskCntnt;	
	private String mbrId;	
	private String hlpDskWrtDt;	
	private String mstrId;	
	private String hlpDskPrcsYn;	
	private String hlpDskPrcsDt;	
	private String useYn;	
	private String delYn;	
	
	
	private MbrVO mbrVO;
	
	
	public MbrVO getMbrVO() {
		return mbrVO;
	}
	public void setMbrVO(MbrVO mbrVO) {
		this.mbrVO = mbrVO;
	}
	public String getHlpDskWrtId() {	
		return hlpDskWrtId;
	}	
	public void setHlpDskWrtId(String hlpDskWrtId) {	
		this.hlpDskWrtId = hlpDskWrtId;
	}	
	public String getHlpDskSbjct() {	
		return hlpDskSbjct;
	}	
	public void setHlpDskSbjct(String hlpDskSbjct) {	
		this.hlpDskSbjct = hlpDskSbjct;
	}	
	public String getHlpDskTtl() {	
		return hlpDskTtl;
	}	
	public void setHlpDskTtl(String hlpDskTtl) {	
		this.hlpDskTtl = hlpDskTtl;
	}	
	public String getHlpDskCntnt() {	
		return hlpDskCntnt;
	}	
	public void setHlpDskCntnt(String hlpDskCntnt) {	
		this.hlpDskCntnt = hlpDskCntnt;
	}	
	public String getMbrId() {	
		return mbrId;
	}	
	public void setMbrId(String mbrId) {	
		this.mbrId = mbrId;
	}	
	public String getHlpDskWrtDt() {	
		return hlpDskWrtDt;
	}	
	public void setHlpDskWrtDt(String hlpDskWrtDt) {	
		this.hlpDskWrtDt = hlpDskWrtDt;
	}	
	public String getMstrId() {	
		return mstrId;
	}	
	public void setMstrId(String mstrId) {	
		this.mstrId = mstrId;
	}	
	public String getHlpDskPrcsYn() {	
		return hlpDskPrcsYn;
	}	
	public void setHlpDskPrcsYn(String hlpDskPrcsYn) {	
		this.hlpDskPrcsYn = hlpDskPrcsYn;
	}	
	public String getHlpDskPrcsDt() {	
		return hlpDskPrcsDt;
	}	
	public void setHlpDskPrcsDt(String hlpDskPrcsDt) {	
		this.hlpDskPrcsDt = hlpDskPrcsDt;
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
