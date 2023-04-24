package com.ktds.fr.prdt.vo;

import java.util.List;

import com.ktds.fr.cmmncd.vo.CmmnCdVO;
import com.ktds.fr.common.vo.AbstractVO;
import com.ktds.fr.evnt.vo.EvntVO;
import com.ktds.fr.evntprdt.vo.EvntPrdtVO;
import com.ktds.fr.mbr.vo.MbrVO;

public class PrdtVO extends AbstractVO{		
		
	private String prdtId;
	private String prdtNm;
	private int prdtPrc;
	private String prdtCntnt;
	private String prdtSrt;
	private String orgnFlNm;
	private String uuidFlNm;
	private long flSize;
	private String flExt;
	private String prdtRgstr;
	private String prdtRgstDt;
	private String mdfyr;
	private String mdfyDt;
	private String useYn;
	private String delYn;
	
	
	private CmmnCdVO cmmnCdVO;
	private MbrVO prdtRgstrMbrVO;
	private MbrVO mdfyrMbrVO;
	
	private EvntVO evntVO;
	private EvntPrdtVO evntPrdtVO;
	
	
	private List<String> prdtIdList;
	
	
	private String isDeleteImg;

	
	private int prdtPageNo;
	private int prdtPageCnt;
	private int prdtViewCnt;
	
	
	public PrdtVO() {
		this.prdtPageNo = 0;
		this.prdtPageCnt = 10;
		this.prdtViewCnt = 10;
	}
	
	
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
	public String getPrdtSrt() {	
		return prdtSrt;
	}	
	public void setPrdtSrt(String prdtSrt) {	
		this.prdtSrt = prdtSrt;
	}	
	public String getOrgnFlNm() {
		return orgnFlNm;
	}
	public void setOrgnFlNm(String orgnFlNm) {
		this.orgnFlNm = orgnFlNm;
	}
	public String getUuidFlNm() {
		return uuidFlNm;
	}
	public void setUuidFlNm(String uuidFlNm) {
		this.uuidFlNm = uuidFlNm;
	}
	public long getFlSize() {
		return flSize;
	}
	public void setFlSize(long flSize) {
		this.flSize = flSize;
	}
	public String getFlExt() {
		return flExt;
	}
	public void setFlExt(String flExt) {
		this.flExt = flExt;
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
	public EvntVO getEvntVO() {
		return evntVO;
	}
	public void setEvntVO(EvntVO evntVO) {
		this.evntVO = evntVO;
	}
	public EvntPrdtVO getEvntPrdtVO() {
		return evntPrdtVO;
	}
	public void setEvntPrdtVO(EvntPrdtVO evntPrdtVO) {
		this.evntPrdtVO = evntPrdtVO;
	}
	public List<String> getPrdtIdList() {
		return prdtIdList;
	}
	public void setPrdtIdList(List<String> prdtIdList) {
		this.prdtIdList = prdtIdList;
	}
	public String getIsDeleteImg() {
		return isDeleteImg;
	}
	public void setIsDeleteImg(String isDeleteImg) {
		this.isDeleteImg = isDeleteImg;
	}
	public int getPrdtPageNo() {
		return prdtPageNo;
	}
	public void setPrdtPageNo(int prdtPageNo) {
		this.prdtPageNo = prdtPageNo;
	}
	public int getPrdtPageCnt() {
		return prdtPageCnt;
	}
	public void setPrdtPageCnt(int prdtPageCnt) {
		this.prdtPageCnt = prdtPageCnt;
	}
	public int getPrdtViewCnt() {
		return prdtViewCnt;
	}
	public void setPrdtViewCnt(int prdtViewCnt) {
		this.prdtViewCnt = prdtViewCnt;
	}
	
}		
