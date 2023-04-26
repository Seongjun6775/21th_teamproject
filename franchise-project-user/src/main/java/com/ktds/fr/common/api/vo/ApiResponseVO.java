package com.ktds.fr.common.api.vo;

public class ApiResponseVO {
	
	private String status;
	private String message;
	private String errorCode;
	private String redirectURL;
	
	public ApiResponseVO() {

	}

	public ApiResponseVO(String status) {
		this.status = status;
		this.message = "";
		this.errorCode = "";
		this.redirectURL = "";
	}

	public ApiResponseVO(String status, String redirectURL) {
		this.status = status;
		this.message = "";
		this.errorCode = "";
		this.redirectURL = redirectURL;
	}

	public ApiResponseVO(String status, String message, String redirectURL) {
		this.status = status;
		this.message = message;
		this.errorCode = "";
		this.redirectURL = redirectURL;
	}

	public ApiResponseVO(String status, String message, String errorCode, String redirectURL) {
		this.status = status;
		this.message = message;
		this.errorCode = errorCode;
		this.redirectURL = redirectURL;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}

	public String getRedirectURL() {
		return redirectURL;
	}

	public void setRedirectURL(String redirectURL) {
		this.redirectURL = redirectURL;
	}

}
