package com.ktds.fr.rpl.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

public class ScriptUtils {
	  public static void init(HttpServletResponse response) {
	        response.setContentType("text/html; charset=euc-kr");
	        response.setCharacterEncoding("euc-kr");
	    }	 
	    public static void alert(HttpServletResponse response, String alertText) throws IOException {
	        init(response);
	        PrintWriter out = response.getWriter();
	        out.println("<script>alert('" + alertText + "');</script> ");
	        out.flush();
	    }
	}
