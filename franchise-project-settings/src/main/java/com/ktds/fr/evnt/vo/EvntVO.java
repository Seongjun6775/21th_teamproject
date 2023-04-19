package com.ktds.fr.evnt.vo;		
		
public class EvntVO {		
	
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
	/* 이벤트 사진 */
	private String evntPht;
	/* 이벤트 사용유무 */
	private String useYn;
	/* 이벤트 삭제여부 */
	private String delYn;
	
	
	/* 페이지네이션 */
	private int viewCnt;
	private int pageCnt;
	private int pageNo;
	
	private int totalCount;
	private int lastPage;
	private int lastGroup;
	
	

	
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
	public String getEvntPht() {	
		return evntPht;
	}	
	public void setEvntPht(String evntPht) {	
		this.evntPht = evntPht;
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
		
	public int getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}
	public int getPageCnt() {
		return pageCnt;
	}
	public void setPageCnt(int pageCnt) {
		this.pageCnt = pageCnt;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getLastPage() {
		return lastPage;
	}
	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}
	public int getLastGroup() {
		return lastGroup;
	}
	public void setLastGroup(int lastGroup) {
		this.lastGroup = lastGroup;
	}
}		
