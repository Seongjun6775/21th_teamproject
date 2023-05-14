package com.ktds.fr.lgnhist.service;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.lgnhist.dao.LgnHistDAO;
import com.ktds.fr.lgnhist.vo.LgnHistVO;

@Service
public class LgnHistServiceImpl implements LgnHistService {

	@Autowired
	private LgnHistDAO lgnHistDAO;

	@Override
	public List<LgnHistVO> readMbrLgnHist(LgnHistVO lgnHistVO) {
		if(lgnHistVO.getStartDt() == null || lgnHistVO.getStartDt().length()==0) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH)+1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String strMonth = month < 10 ? "0" + month : month + "";
			String strDay = day < 10 ? "0" + day : day + "";
			
			String startDt = year+ "-" + strMonth + "-" + strDay;
			lgnHistVO.setStartDt(startDt);
		}
		if(lgnHistVO.getEndDt() == null || lgnHistVO.getEndDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String strMonth = month < 10 ? "0" + month : month + "";
			String strDay = day < 10 ? "0" + day : day + "";
			
			String endDt = year + "-" + strMonth + "-" + strDay;
			lgnHistVO.setEndDt(endDt);
		}
		
		return lgnHistDAO.readMbrLgnHist(lgnHistVO);
	}

}
