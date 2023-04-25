package com.ktds.fr.common.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ktds.fr.mbr.vo.MbrVO;

public class SessionInterceptor extends HandlerInterceptorAdapter{
	
	private Logger log = LoggerFactory.getLogger(BlockPageInterceptor.class);
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.info("seesion인터셉터{}");
		HttpSession session = request.getSession(); //session 객체 가져오기
		//세션 로그인 정보를 가져온다.
		MbrVO member = (MbrVO)session.getAttribute("__MBR__");
		
		if(member == null) {
			//로그인 페이지로 이동
			log.info("로그인 하고 와야지!");
			response.sendRedirect(request.getContextPath() + "/user/join");
			return false;
		}
		log.info("로그인을 했군...");
		return true; // Controller 실행을 계속한다.
	}

}
