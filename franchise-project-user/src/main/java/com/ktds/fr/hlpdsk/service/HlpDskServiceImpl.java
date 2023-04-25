package com.ktds.fr.hlpdsk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.hlpdsk.dao.HlpDskDAO;
import com.ktds.fr.hlpdsk.vo.HlpDskVO;
@Service
public class HlpDskServiceImpl implements HlpDskService {

	@Autowired
	private HlpDskDAO hlpDskDAO; 
	
	@Override
	public List<HlpDskVO> readAllHlpDsks(HlpDskVO hlpDskVO) {
		return hlpDskDAO.readAllHlpDsks(hlpDskVO);
	}

	@Override
	public List<HlpDskVO> readAllMyHlpDsks(HlpDskVO hlpDskVO) {
		return hlpDskDAO.readAllMyHlpDsks(hlpDskVO);
	}
	
	@Override
	public List<HlpDskVO> readAllHlpDsksPagination(String mngrBrdTtl) {
		// TODO Auto-generated method stub
		return hlpDskDAO.readAllHlpDsksPagination(mngrBrdTtl);
	}
	@Override
	public HlpDskVO readOneHlpDskByHlpDskId(String hlpDskId) {
		return hlpDskDAO.readOneHlpDskByHlpDskId(hlpDskId);
	}
	
	@Override
	public boolean createNewHlpDsk(HlpDskVO hlpDskVO) {
		return hlpDskDAO.createNewHlpDsk(hlpDskVO) >0;
	}
	@Override
	public boolean updateNewHlpDsk(HlpDskVO hlpDskVO) {
		return hlpDskDAO.updateNewHlpDsk(hlpDskVO) >0;
	}
	
	
	@Override
	public boolean deleteOneHlpDsk(String hlpDskId) {
		return hlpDskDAO.deleteOneHlpDsk(hlpDskId) > 0;
	}

	@Override
	public boolean deleteHlpDskBySelectedHlpDskId(List<String> hlpDskId) {
		
		int delCount = hlpDskDAO.deleteHlpDskBySelectedHlpDskId(hlpDskId);
		boolean isSuccess = delCount == hlpDskId.size();
		if(!isSuccess) {
			throw new ApiException("500", "삭제에 실패했습니다. 요청건수:("+hlpDskId.size() +"건), 삭제건수("+delCount+"건)");
		}
		return isSuccess;
	}

}
