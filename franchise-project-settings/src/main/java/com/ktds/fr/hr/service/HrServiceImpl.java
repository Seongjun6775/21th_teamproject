package com.ktds.fr.hr.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.hr.dao.HrDAO;

@Service
public class HrServiceImpl implements HrService {

	@Autowired
	private HrDAO hrDAO;
	
}
