package com.ktds.fr.common.service;

import java.util.List;

public interface MailSendService {
	
	public void mailSend(String from, String to, String title, String content );
	
	public String makeEmailForm(String email);
	public void makeFindIdEmailForm(String email, List<String> mbrId);
	public String makeFindPwEmailForm(String email);

}
