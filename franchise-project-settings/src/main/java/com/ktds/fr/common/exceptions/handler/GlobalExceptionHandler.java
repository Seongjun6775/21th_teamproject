package com.ktds.fr.common.exceptions.handler;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.ktds.fr.common.exceptions.IllegalRequestException;

@ControllerAdvice("com.ktds.fr")
public class GlobalExceptionHandler {

	@ExceptionHandler(IllegalRequestException.class)
	public String handleIllegalRequestException(IllegalRequestException ae) {
		return "errors/404";
	}
	
}
