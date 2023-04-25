package com.ktds.fr.common.service;

import java.util.List;

import com.ktds.fr.mbr.vo.MbrVO;

public interface MailSendService {
	
	public void mailSend(String from, String to, String title, String content );
	

	public String makeEmailForm(String email);
	public void makeFindIdEmailForm(String email, List<MbrVO> mbrList);
	public void makeFindPwEmailForm(MbrVO mbrVO);

}
