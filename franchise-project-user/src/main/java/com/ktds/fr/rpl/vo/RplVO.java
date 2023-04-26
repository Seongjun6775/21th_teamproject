package com.ktds.fr.rpl.vo;

import com.ktds.fr.common.vo.AbstractVO;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.mngrbrd.vo.MngrBrdVO;

public class RplVO extends AbstractVO{		
	
	private int depth;
	
	private String rplId;	
	private String rplCntnt;	
	private String mbrId;	
	private String altclId;
	private String rplPrntRpl;	
	private String rplWrtDt;	
	private String mdfyDt;	
	private String useYn;	
	private String delYn;	
	
	private MbrVO mbrVO;
	private MngrBrdVO mngrbrdVO;
	
	
	
	public MngrBrdVO getMngrbrdVO() {
		return mngrbrdVO;
	}
	public void setMngrbrdVO(MngrBrdVO mngrbrdVO) {
		this.mngrbrdVO = mngrbrdVO;
	}
	public MbrVO getMbrVO() {
		return mbrVO;
	}
	public void setMbrVO(MbrVO mbrVO) {
		this.mbrVO = mbrVO;
	}
	

	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
		
	public String getRplId() {	
		return rplId;
	}	
	public void setRplId(String rplId) {	
		this.rplId = rplId;
	}	
	public String getRplCntnt() {	
		return rplCntnt;
	}
	public void setRplCntnt(String rplCntnt) {	
		this.rplCntnt = rplCntnt;
	}
	
	public String getAltclId() {
		return altclId;
	}
	public void setAltclId(String altclId) {
		this.altclId = altclId;
	}
	public String getMbrId() {	
		return mbrId;
	}	
	public void setMbrId(String mbrId) {	
		this.mbrId = mbrId;
	}	

	public String getRplPrntRpl() {	
		return rplPrntRpl;
	}	
	public void setRplPrntRpl(String rplPrntRpl) {	
		this.rplPrntRpl = rplPrntRpl;
	}	
	public String getRplWrtDt() {	
		return rplWrtDt;
	}	
	public void setRplWrtDt(String rplWrtDt) {	
		this.rplWrtDt = rplWrtDt;
	}	
	public String getMdfyDt() {	
		return mdfyDt;
	}	
	public void setMdfyDt(String mdfyDt) {	
		this.mdfyDt = mdfyDt;
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