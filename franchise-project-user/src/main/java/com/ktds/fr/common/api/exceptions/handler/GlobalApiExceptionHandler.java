package com.ktds.fr.common.api.exceptions.handler;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.ktds.fr.common.api.exceptions.ApiArgsException;
import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;

@RestControllerAdvice("com.ktds.fr")
public class GlobalApiExceptionHandler {
	
	@ExceptionHandler(ApiArgsException.class)
	public ApiResponseVO handleApiArgsExcetion(ApiArgsException ae) {
		return new ApiResponseVO(ApiStatus.MISSING_ARGS, ae.getMessage(), ae.getErrorCode(), "");
	}
	@ExceptionHandler(ApiException.class)
	public ApiResponseVO handleApiExcetion(ApiException ae) {
		return new ApiResponseVO(ApiStatus.FAIL, ae.getMessage(), ae.getErrorCode(), "");
	}
}
