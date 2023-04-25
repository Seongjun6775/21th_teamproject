package com.ktds.fr.rv.vo;

import com.ktds.fr.common.vo.AbstractVO;
import com.ktds.fr.mbr.vo.MbrVO;

public class SearchRvVO extends AbstractVO {

	private String type;
	
	private String search;

	private MbrVO mbrVO;
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public MbrVO getMbrVO() {
		return mbrVO;
	}

	public void setMbrVO(MbrVO mbrVO) {
		this.mbrVO = mbrVO;
	}
	
	
}
