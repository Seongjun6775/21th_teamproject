package com.ktds.fr.rv.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.rv.dao.RvDAO;
import com.ktds.fr.rv.vo.RvVO;

@Service
public class RvServiceImpl implements RvService {

	@Autowired
	private RvDAO rvDAO;
	
	@Override
	public boolean createNewRv(RvVO rvVO) {
		return rvDAO.createNewRv(rvVO) > 0;
	}

	@Override
	public List<RvVO> readAllRvList(RvVO rvVO) {
		return rvDAO.readAllRvList(rvVO);
	}

	@Override
	public RvVO readOneRvVO(RvVO rvVO) {
		return rvDAO.readOneRvVO(rvVO);
	}

	@Override
	public List<RvVO> readAllRvByStrId(String strId) {
		return rvDAO.readAllRvByStrId(strId);
	}

	@Override
	public RvVO readOneRvVOByStrId(String strId) {
		return rvDAO.readOneRvVOByStrId(strId);
	}

	@Override
	public boolean deleteAllRvList(List<String> RvList) {
		return rvDAO.deleteAllRvList(RvList) > 0;
	}

	@Override
	public boolean deleteOneRvByRvId(String RvId) {
		return rvDAO.deleteOneRvByRvId(RvId) > 0;
	}

}
