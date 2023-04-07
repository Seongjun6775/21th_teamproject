package com.ktds.fr.common.api.exceptions;

public class ApiException extends RuntimeException{

	private static final long serialVersionUID = -6836299079597955378L;
	
	private String errorCode;
	
	public ApiException(String errorCode, String message) {
		super(message);
		this.errorCode = errorCode;
	}
	public String getErrorCode() {
		return errorCode;
	}

}
