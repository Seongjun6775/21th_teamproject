package com.ktds.fr.common.vo;

public abstract class AbstractVO {
	
	/**
	 * 검색에 이용
	 * 시작 날짜
	 */
	private String startDt;
	/**
	 * 검색에 이용
	 * 종료 날짜
	 */
	private String endDt;
	/**
	 * 페이지네이션에 이용
	 * 보여질 페이지 번호
	 */
	private int pageNo;
	/**
	 * 페이지네이션에 이용
	 * 한 페이지에 보여질 개수
	 */
	private int viewCnt;
	/**
	 * 페이지네이션에 이용
	 * 불러온 열의 총 개수 
	 */
	private int totalCount;
	/**
	 * 페이지네이션에 이용
	 * 그룹으로 묶을 페이지 개수(*그룹 : 페이지의 묶음)
	 */
	private int pageCnt;
	/**
	 * 페이지네이션에 이용
	 * 마지막 페이지(*페이지 : 열의 묶음)
	 */
	private int lastPage;
	/**
	 * 페이지네이션에 이용
	 * 그룹의 마지막 번호(*그룹 : 페이지의 묶음)
	 */
	private int lastGroup;
	/**
	 * 페이지네이션에 이용
	 * 결과로 나온 각 열의 번호
	 */
	private int rnum;
	
	protected AbstractVO() {
		this.pageNo = 0;
		this.pageCnt = 10;
		this.viewCnt = 10;
	}
	
	public String getStartDt() {
		return startDt;
	}
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	
	
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getPageCnt() {
		return pageCnt;
	}
	public void setPageCnt(int pageCnt) {
		this.pageCnt = pageCnt;
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
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	
}

