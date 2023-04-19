package com.ktds.fr.strprdt.vo;

import java.util.List;

import com.ktds.fr.cmmncd.vo.CmmnCdVO;
import com.ktds.fr.common.vo.AbstractVO;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.prdt.vo.PrdtVO;
import com.ktds.fr.str.vo.StrVO;

public class StrPrdtVO extends AbstractVO {		
		
	private String strPrdtId;	
	private String strId;	
	private String prdtId;	
	private String mdfyr;	
	private String mdfyDt;	
	private String useYn;	
	private String delYn;	
	
	private StrVO strVO;
	private PrdtVO prdtVO;
	private CmmnCdVO cmmnCdVO;
	private MbrVO mdfyrMbrVO;	
	
	
	private List<String> strPrdtIdList;
	
	
	private int strPrdtPageNo;
	private int strPrdtPageCnt;
	private int strPrdtViewCnt;
	
	public StrPrdtVO() {
		this.strPrdtPageNo = 0;
		this.strPrdtPageCnt = 5;
		this.strPrdtViewCnt = 20;
	}
	
	public String getStrPrdtId() {	
		return strPrdtId;
	}	
	public void setStrPrdtId(String strPrdtId) {	
		this.strPrdtId = strPrdtId;
	}	
	public String getStrId() {	
		return strId;
	}	
	public void setStrId(String strId) {	
		this.strId = strId;
	}	
	public String getPrdtId() {	
		return prdtId;
	}	
	public void setPrdtId(String prdtId) {	
		this.prdtId = prdtId;
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
	
	
	public StrVO getStrVO() {
		return strVO;
	}
	public void setStrVO(StrVO strVO) {
		this.strVO = strVO;
	}
	public PrdtVO getPrdtVO() {
		return prdtVO;
	}
	public void setPrdtVO(PrdtVO prdtVO) {
		this.prdtVO = prdtVO;
	}
	public CmmnCdVO getCmmnCdVO() {
		return cmmnCdVO;
	}
	public void setCmmnCdVO(CmmnCdVO cmmnCdVO) {
		this.cmmnCdVO = cmmnCdVO;
	}
	public MbrVO getMdfyrMbrVO() {
		return mdfyrMbrVO;
	}
	public void setMdfyrMbrVO(MbrVO mdfyrMbrVO) {
		this.mdfyrMbrVO = mdfyrMbrVO;
	}
	
	
	public List<String> getStrPrdtIdList() {
		return strPrdtIdList;
	}
	public void setStrPrdtIdList(List<String> strPrdtIdList) {
		this.strPrdtIdList = strPrdtIdList;
	}

	
	public int getStrPrdtPageNo() {
		return strPrdtPageNo;
	}
	public void setStrPrdtPageNo(int strPrdtPageNo) {
		this.strPrdtPageNo = strPrdtPageNo;
	}
	public int getStrPrdtPageCnt() {
		return strPrdtPageCnt;
	}
	public void setStrPrdtPageCnt(int strPrdtPageCnt) {
		this.strPrdtPageCnt = strPrdtPageCnt;
	}
	public int getStrPrdtViewCnt() {
		return strPrdtViewCnt;
	}
	public void setStrPrdtViewCnt(int strPrdtViewCnt) {
		this.strPrdtViewCnt = strPrdtViewCnt;
	}	
		
}		
