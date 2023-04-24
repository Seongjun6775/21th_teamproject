package com.ktds.fr.rpl.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.rpl.dao.RplDAO;
import com.ktds.fr.rpl.vo.RplVO;

@Service
public class RplServiceImpl implements RplService {
	
	@Autowired
	private RplDAO rplDAO;
	
	@Override
	public boolean createNewRpl(RplVO rplVO) {
		return rplDAO.createNewRpl(rplVO) > 0;
	}

	@Override
	public boolean updateOneRpl(RplVO rplVO) {
		return rplDAO.updateOneRpl(rplVO) >0;
	}

	@Override
	public boolean deleteOneRplByRplId(String rplId) {
		return rplDAO.deleteOneRplByRplId(rplId) > 0;
	}

	@Override
	public List<RplVO> readAllRpls(RplVO rplVO) {
		return rplDAO.readAllRpls(rplVO);
	}

	@Override
	public boolean deleteRplBySelectedRplId(List<String> rplId) {
		
		int delCount = rplDAO.deleteRplBySelectedRplId(rplId);
		boolean isSuccess = delCount ==rplId.size();
		if(!isSuccess) {
			throw new ApiException("500", "삭제에 실패했습니다. 요청건수:("+rplId.size() +"건), 삭제건수("+delCount+"건)");
		}
		return isSuccess; 
	}
}
