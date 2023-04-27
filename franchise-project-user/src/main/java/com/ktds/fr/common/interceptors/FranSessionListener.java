package com.ktds.fr.common.interceptors;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ktds.fr.common.util.SessionManager;
import com.ktds.fr.mbr.vo.MbrVO;

public class FranSessionListener implements HttpSessionListener{

	
	private static final Logger log = LoggerFactory.getLogger(FranSessionListener.class);
	
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		log.info("세션이 생성되었습니다.");
	}
	
	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		MbrVO mbrVO = (MbrVO) se.getSession().getAttribute("__MBR__");
		if(mbrVO != null) {
			log.info("{} 님의 세션이 삭제되었습니다.",mbrVO.getMbrNm());
			SessionManager.getInstance().removeSession(mbrVO.getMbrId());
		}
	}

	
}
