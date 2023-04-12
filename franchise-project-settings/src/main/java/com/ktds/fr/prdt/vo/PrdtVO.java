package com.ktds.fr.prdt.vo;

import com.ktds.fr.cmmncd.vo.CmmnCdVO;
import com.ktds.fr.mbr.vo.MbrVO;

public class PrdtVO {		
		
	private String prdtId;	
	private String prdtNm;	
	private int prdtPrc;	
	private String prdtCntnt;	
	private String prdtFileId;	
	private String prdtSrt;	
	private String prdtRgstr;	
	private String prdtRgstDt;	
	private String mdfyr;	
	private String mdfyDt;	
	private String useYn;	
	private String delYn;	
	
	private CmmnCdVO cmmnCdVO;
	private MbrVO prdtRgstrMbrVO;
	private MbrVO mdfyrMbrVO;
	
	private String isDeleteIMG;
	
	public String getPrdtId() {	
		return prdtId;
	}	
	public void setPrdtId(String prdtId) {	
		this.prdtId = prdtId;
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
	public String getPrdtCntnt() {	
		return prdtCntnt;
	}	
	public void setPrdtCntnt(String prdtCntnt) {	
		this.prdtCntnt = prdtCntnt;
	}	
	public String getPrdtFileId() {	
		return prdtFileId;
	}	
	public void setPrdtFileId(String prdtFileId) {	
		this.prdtFileId = prdtFileId;
	}	
	public String getPrdtSrt() {	
		return prdtSrt;
	}	
	public void setPrdtSrt(String prdtSrt) {	
		this.prdtSrt = prdtSrt;
	}	
	public String getPrdtRgstr() {	
		return prdtRgstr;
	}	
	public void setPrdtRgstr(String prdtRgstr) {	
		this.prdtRgstr = prdtRgstr;
	}	
	public String getPrdtRgstDt() {	
		return prdtRgstDt;
	}	
	public void setPrdtRgstDt(String prdtRgstDt) {	
		this.prdtRgstDt = prdtRgstDt;
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
	public MbrVO getPrdtRgstrMbrVO() {
		return prdtRgstrMbrVO;
	}
	public void setPrdtRgstrMbrVO(MbrVO prdtRgstrMbrVO) {
		this.prdtRgstrMbrVO = prdtRgstrMbrVO;
	}
	public MbrVO getMdfyrMbrVO() {
		return mdfyrMbrVO;
	}
	public void setMdfyrMbrVO(MbrVO mdfyrMbrVO) {
		this.mdfyrMbrVO = mdfyrMbrVO;
	}
	public CmmnCdVO getCmmnCdVO() {
		return cmmnCdVO;
	}
	public void setCmmnCdVO(CmmnCdVO cmmnCdVO) {
		this.cmmnCdVO = cmmnCdVO;
	}
	public String getIsDeleteIMG() {
		return isDeleteIMG;
	}
	public void setIsDeleteIMG(String isDeleteIMG) {
		this.isDeleteIMG = isDeleteIMG;
	}
	
}		
