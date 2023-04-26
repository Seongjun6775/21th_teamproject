package com.ktds.fr.common.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ktds.fr.mbr.vo.MbrVO;

public class BlockPageInterceptor extends HandlerInterceptorAdapter{

	private Logger log = LoggerFactory.getLogger(BlockPageInterceptor.class);
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		MbrVO member = (MbrVO)session.getAttribute("__MBR__");
		
		//세션이 없는지 체크.
		//세션이 있다 = return false;
		if(member != null) {
			response.sendRedirect(request.getContextPath() + "/");
			return false;
		}
		
		//세션이 없다 = return true;
		
		return true;
	}
	
	
}
