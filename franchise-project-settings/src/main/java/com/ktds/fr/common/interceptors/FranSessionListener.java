package com.ktds.fr.common.interceptors;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ktds.fr.common.util.SessionManager;
import com.ktds.fr.mbr.vo.MbrVO;

public class FranSessionListener implements HttpSessionListener {

	
	private static final Logger log = LoggerFactory.getLogger(FranSessionListener.class);
	
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		// 세션이 만들어질 때 수행됨.
		log.info("세션이 생성되었습니다.");
	}
	
	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		// 세션이 invalidated 됐을 때 수행.
		// 직접 invalidated();
		// session-timeout 시간이 초과해도 실행됨.
		
		// Session이 죽기 직전의 데이터
		MbrVO mbrVO = (MbrVO) se.getSession().getAttribute("__MBR__");
		// invalidated()되었을 때 null 값을 가질 수 있다.
		if (mbrVO != null) {
			log.info("{} 님의 세션이 삭제되었습니다.",mbrVO.getMbrNm());
			SessionManager.getInstance().removeSession(mbrVO.getMbrId());
		}
		
	}

}
