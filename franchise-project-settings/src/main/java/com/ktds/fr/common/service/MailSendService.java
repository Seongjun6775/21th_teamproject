package com.ktds.fr.common.service;

public interface MailSendService {
	
	public void mailSend(String from, String to, String title, String content );
	
	public String makeEamilForm(String email);
}
