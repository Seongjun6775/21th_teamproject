package com.ktds.fr.lgnhist.service;

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
	public List<LgnHistVO> readMbrLgnHist(String mbrId) {
		return lgnHistDAO.readMbrLgnHist(mbrId);
	}

}
