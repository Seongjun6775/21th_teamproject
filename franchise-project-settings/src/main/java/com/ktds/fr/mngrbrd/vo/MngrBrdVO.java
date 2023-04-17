package com.ktds.fr.mngrbrd.vo;

import java.util.List;

import com.ktds.fr.common.vo.AbstractVO;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.rpl.vo.RplVO;

public class MngrBrdVO extends AbstractVO{		
		
	private String mngrBrdId;	
	private String mngrBrdTtl;	
	private String mngrBrdCntnt;	
	private String mngrId;	
	private String mngrBrdWrtDt;	
	private String mdfyDt;	
	private String mdfyr;	
	private String useYn;	
	private String delYn;	
	private String ntcYn;
		
	private List<RplVO> rplList;
	
	private MbrVO mbrVO;
	
	public List<RplVO> getRplList() {
		return rplList;
	}
	public void setRplList(List<RplVO> rplList) {
		this.rplList = rplList;
	}
	
	public String getNtcYn() {
		return ntcYn;
	}
	public void setNtcYn(String ntcYn) {
		this.ntcYn = ntcYn;
	}
	
	

	
	public MbrVO getMbrVO() {
		return mbrVO;
	}
	public void setMbrVO(MbrVO mbrVO) {
		this.mbrVO = mbrVO;
	}
	public String getMngrBrdId() {	
		return mngrBrdId;
	}	
	public void setMngrBrdId(String mngrBrdId) {	
		this.mngrBrdId = mngrBrdId;
	}	
	public String getMngrBrdTtl() {	
		return mngrBrdTtl;
	}	
	public void setMngrBrdTtl(String mngrBrdTtl) {	
		this.mngrBrdTtl = mngrBrdTtl;
	}	
	public String getMngrBrdCntnt() {	
		return mngrBrdCntnt;
	}	
	public void setMngrBrdCntnt(String mngrBrdCntnt) {	
		this.mngrBrdCntnt = mngrBrdCntnt;
	}	
	public String getMngrId() {	
		return mngrId;
	}	
	public void setMngrId(String mngrId) {	
		this.mngrId = mngrId;
	}	
	public String getMngrBrdWrtDt() {	
		return mngrBrdWrtDt;
	}	
	public void setMngrBrdWrtDt(String mngrBrdWrtDt) {	
		this.mngrBrdWrtDt = mngrBrdWrtDt;
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
