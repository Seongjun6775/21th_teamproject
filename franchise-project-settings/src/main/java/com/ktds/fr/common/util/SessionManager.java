package com.ktds.fr.common.util;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

public class SessionManager {

	private static SessionManager _instance;
	private final Map<String, HttpSession> sessionMap;
	
	private SessionManager() {
		sessionMap = new HashMap<>();
	}
	
	/**
	 * 요청 직렬화
	 * A => SessionManager.getInstance()
	 * , B => SessionManager.getInstance()
	 * , C => SessionManager.getInstance()
	 * 
	 * Singleton pattern
	 * @return
	 */
	public static synchronized SessionManager getInstance() {
			if (_instance == null) {
				_instance = new SessionManager();
		}
		
		return _instance;
	}
	
	public void addSession(String mbrId, HttpSession session) {
		sessionMap.put(mbrId, session);
	}
	
	public void removeSession(String mbrId) {
		sessionMap.remove(mbrId);
	}
	
	public void destroySession(String mbrId) {
		sessionMap.get(mbrId).invalidate();
		removeSession(mbrId);
	}
	
}
