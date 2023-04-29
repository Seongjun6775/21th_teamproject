package com.ktds.fr.common.api.vo;

public class ApiDataResponseVO extends ApiResponseVO {

	private Object data;

	public ApiDataResponseVO(String status, Object data) {
		super(status);
		this.data = data;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

}
