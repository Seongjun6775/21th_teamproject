package com.ktds.fr.evnt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.evnt.dao.EvntDAO;
import com.ktds.fr.evnt.vo.EvntVO;

@Service
public class EvntServiceImpl implements EvntService {

	@Autowired
	private EvntDAO evntDAO;

	@Override
	public boolean createNewEvnt(EvntVO evntVO) {
		return evntDAO.createNewEvnt(evntVO) > 0;
	}

	@Override
	public List<EvntVO> readAllEvnt(EvntVO evntVO) {
		return evntDAO.readAllEvnt(evntVO);
	}

	@Override
	public EvntVO readOneEvnt(EvntVO evntVO) {
		return evntDAO.readOneEvnt(evntVO);
	}

	@Override
	public boolean updateEvnt(EvntVO envtVO) {
		return evntDAO.updateEvnt(envtVO) > 0;
	}

	@Override
	public boolean updateDeleteEvnt(EvntVO evntVO) {
		return evntDAO.updateDeleteEvnt(evntVO) > 0;
	}

}