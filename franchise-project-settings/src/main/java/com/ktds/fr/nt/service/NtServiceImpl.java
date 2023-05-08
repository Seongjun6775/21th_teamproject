package com.ktds.fr.nt.service;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.nt.dao.NtDAO;
import com.ktds.fr.nt.vo.NtVO;

@Service
public class NtServiceImpl implements NtService {
	
	@Autowired
	private NtDAO ntDAO;

	@Override
	public boolean createNewNt(NtVO ntVO) {
		return ntDAO.createNewNt(ntVO) > 0;
	}

	@Override
	public List<NtVO> readAllNt(NtVO ntVO) {
		if (ntVO.getStartDt() == null || ntVO.getStartDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String strMonth = month < 10 ? "0" + month : month + "";
			String strDay = day < 10 ? "0" + day : day + "";
			String startDt = year + "-" + strMonth + "-" + strDay;
			ntVO.setStartDt(startDt);
		}
		
		if (ntVO.getEndDt() == null || ntVO.getEndDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String strMonth = month < 10 ? "0" + month : month + "";
			String strDay = day < 10 ? "0" + day : day + "";
			String endDt = year + "-" + strMonth + "-" + strDay;
			ntVO.setEndDt(endDt);
		}
		
		return ntDAO.readAllNt(ntVO);
	}

	@Override
	public boolean updateOneNtByNtId(NtVO ntVO) {
		NtVO originalData = ntDAO.readOneNtByNtId(ntVO.getNtId());
		NtVO newData = new NtVO();
		newData.setNtId(originalData.getNtId());
		newData.setNtTtl(originalData.getNtTtl());
		newData.setNtCntnt(originalData.getNtCntnt());
		
		boolean updateYn = false;
		
		if ( !originalData.getNtTtl().equals(ntVO.getNtTtl()) ) {
			System.out.println(ntVO.getNtTtl());
			newData.setNtTtl(ntVO.getNtTtl());
			updateYn = true;
		}
		
		if ( !originalData.getNtCntnt().equals(ntVO.getNtCntnt()) ) {
			System.out.println(ntVO.getNtCntnt());
			newData.setNtCntnt(ntVO.getNtCntnt());
			updateYn = true;
		}
		
		if (updateYn) {
			return ntDAO.updateOneNtByNtId(newData) > 0;
		}
		else {
			throw new ApiException("400", "수정된 정보가 없습니다.");
		}
		
	}

	@Override
	public boolean deleteOneNtByNtId(String ntId) {
		return ntDAO.deleteOneNtByNtId(ntId) > 0;
	}
	
	@Override
	public boolean deleteNtBySelectedNtId(List<String> ntId) {
		int deleteResult = ntDAO.deleteNtBySelectedNtId(ntId);
		boolean isSuccess = deleteResult == ntId.size();
		if (!isSuccess) {
			throw new ApiException("500", "삭제에 실패했습니다 : 요청 건수 - " + ntId.size() + "건 / 삭제 건수 : " + deleteResult + "건");
		}
		return isSuccess;
	}
	
	@Override
	public NtVO readOneNtByNtId(String ntId) {
		return ntDAO.readOneNtByNtId(ntId);
	}

	@Override
	public List<NtVO> readAllMyNt(NtVO ntVO) {
		if (ntVO.getStartDt() == null || ntVO.getStartDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String strMonth = month < 10 ? "0" + month : month + "";
			String strDay = day < 10 ? "0" + day : day + "";
			String startDt = year + "-" + strMonth + "-" + strDay;
			ntVO.setStartDt(startDt);
		}
		
		if (ntVO.getEndDt() == null || ntVO.getEndDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String strMonth = month < 10 ? "0" + month : month + "";
			String strDay = day < 10 ? "0" + day : day + "";
			String endDt = year + "-" + strMonth + "-" + strDay;
			ntVO.setEndDt(endDt);
		}
		return ntDAO.readAllMyNt(ntVO);
	}
	
	@Override
	public boolean updateNtRdDtByNtId(String ntId) {
		return ntDAO.updateNtRdDtByNtId(ntId) > 0;
	}
	
	@Override
	public boolean checkOneMbr(String rcvrId) {
		return ntDAO.checkOneMbr(rcvrId) > 0;
	}
	
	@Override
	public boolean countNewNt(String mbrId) {
		return ntDAO.countNewNt(mbrId) > 0;
	}

}
