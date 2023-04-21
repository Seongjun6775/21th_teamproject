package com.ktds.fr.evnt.vo;

import com.ktds.fr.common.vo.AbstractVO;

public class EvntVO extends AbstractVO{		
	
	/* 이벤트 ID */
	private String evntId;	
	/* 이벤트 제목 */
	private String evntTtl;	
	/* 이벤트 내용 */
	private String evntCntnt;
	/* 이벤트 시작일 */
	private String evntStrtDt;	
	/* 이벤트 종료일 */
	private String evntEndDt;	
	/* 이벤트 사용유무 */
	private String useYn;
	/* 이벤트 삭제여부 */
	private String delYn;
	
	
	/* 파일 업로드를 위함 */
	private String orgnFlNm;
	private String uuidFlNm;
	private long flSize;
	private String flExt;
	/* 파일 삭제*/
	private String isDeletePctr;
	
	
	public String getIsDeletePctr() {
		return isDeletePctr;
	}
	public void setIsDeletePctr(String isDeletePctr) {
		this.isDeletePctr = isDeletePctr;
	}
	public String getEvntId() {	
		return evntId;
	}	
	public void setEvntId(String evntId) {	
		this.evntId = evntId;
	}	
	public String getEvntTtl() {	
		return evntTtl;
	}	
	public void setEvntTtl(String evntTtl) {	
		this.evntTtl = evntTtl;
	}	
	public String getEvntCntnt() {	
		return evntCntnt;
	}	
	public void setEvntCntnt(String evntCntnt) {	
		this.evntCntnt = evntCntnt;
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
		
}		
