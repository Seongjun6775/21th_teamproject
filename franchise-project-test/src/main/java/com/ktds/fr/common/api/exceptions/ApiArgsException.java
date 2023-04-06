package com.ktds.fr.common.api.exceptions;

public class ApiArgsException extends ApiException{

	private static final long serialVersionUID = 5655214713536476037L;
	
	public ApiArgsException(String errorCode, String message) {
		super(errorCode, message);
	}


}
