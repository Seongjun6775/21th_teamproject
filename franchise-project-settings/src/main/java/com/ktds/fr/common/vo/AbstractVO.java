package com.ktds.fr.common.vo;

public abstract class AbstractVO {
	
	private int pageNo;
	private int viewCnt;
	private int totalCount;
	private int lastPage;
	private int lastGroup;
	private int rnum;
	
	protected AbstractVO() {
		pageNo = 0;
		viewCnt = 10;
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
