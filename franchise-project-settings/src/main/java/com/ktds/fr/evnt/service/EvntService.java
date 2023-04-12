package com.ktds.fr.evnt.service;

import java.util.List;

import com.ktds.fr.evnt.vo.EvntVO;

public interface EvntService {

	public boolean createNewEvnt(EvntVO evntVO);

	public List<EvntVO> readAllEvnt(EvntVO evntVO);
	
	public EvntVO readOneEvnt(EvntVO evntVO);

	public boolean updateEvnt(EvntVO envtVO);
	
	public boolean updateDeleteEvnt(EvntVO evntVO);

}