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
	private int rdCnt;
	
		
	public int getRdCnt() {
		return rdCnt;
	}
	public void setRdCnt(int rdCnt) {
		this.rdCnt = rdCnt;
	}
	private MbrVO mdfyrMbrVO;
	
	

	public MbrVO getMdfyrMbrVO() {
		return mdfyrMbrVO;
	}
	public void setMdfyrMbrVO(MbrVO mdfyrMbrVO) {
		this.mdfyrMbrVO = mdfyrMbrVO;
	}
	public String getNtcYn() {
		return ntcYn;
	}
	public void setNtcYn(String ntcYn) {
		this.ntcYn = ntcYn;
	}
	private MbrVO mbrVO;
	
	private List<RplVO> replyList;
	

	
	public MbrVO getMbrVO() {
		return mbrVO;
	}
	public void setMbrVO(MbrVO mbrVO) {
		this.mbrVO = mbrVO;
	}
	public List<RplVO> getReplyList() {
		return replyList;
	}
	public void setReplyList(List<RplVO> replyList) {
		this.replyList = replyList;
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
