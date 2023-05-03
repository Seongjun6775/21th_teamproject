package com.ktds.fr.str.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.fr.ctycd.dao.CtyCdDAO;
import com.ktds.fr.ctycd.vo.CtyCdVO;
import com.ktds.fr.lctcd.dao.LctCdDAO;
import com.ktds.fr.lctcd.vo.LctCdVO;
import com.ktds.fr.prdt.dao.PrdtDAO;
import com.ktds.fr.prdt.vo.PrdtVO;
import com.ktds.fr.str.dao.StrDAO;
import com.ktds.fr.str.vo.StrVO;
import com.ktds.fr.strprdt.dao.StrPrdtDAO;
import com.ktds.fr.strprdt.vo.StrPrdtVO;

@Service
public class StrServiceImpl implements StrService {

	@Autowired
	private StrDAO strDAO;
	
	@Autowired
	private LctCdDAO lctCdDAO;
	
	@Autowired
	private CtyCdDAO ctyCdDAO;
	
	@Autowired
	private StrPrdtDAO strPrdtDAO;
	
	@Autowired
	private PrdtDAO prdtDAO;
	
	@Override
	public List<StrVO> readAllStrMaster(StrVO strVO) {
		return strDAO.readAllStrMaster(strVO);
	}

	@Override
	public StrVO readOneStrByMaster(String strId) {
		return strDAO.readOneStrByMaster(strId);
	}

	@Override
	public StrVO readOneStrByManager(String strId) {
		return strDAO.readOneStrByManager(strId);
	}

	@Override
	public boolean createOneStr(StrVO strVO) {
		
		boolean isSuccess = strDAO.createOneStr(strVO) > 0;
		//시 ,도 멤버 작성
		if (isSuccess) {
	        CtyCdVO ctyCdVO = strVO.getCtyCdVO();
	        LctCdVO lctCdVO = strVO.getLctCdVO();

	        // 시, 도시 정보가 존재하지 않으면 생성
	        if (ctyCdDAO.read(ctyCdVO.getCtyId()) == null) {
	        	strDAO.createOneStr(strVO);
	        }

	        if (lctCdDAO.read() == null) {
	        	strDAO.createOneStr(strVO);
	        }
	    }
		// 매장이 생성되었을 때, 생성된 매장에 현재 등록되어 있는 모든 상품을 등록
		if (isSuccess) {
			
			PrdtVO prdtVO = new PrdtVO();
			List<PrdtVO> prdtList = prdtDAO.readAllNoPagenation(prdtVO);
			StrPrdtVO strPrdtVO = null;
			List<StrPrdtVO> strPrdtList = new ArrayList<>();
			
			for (PrdtVO prdt : prdtList) {
				strPrdtVO = new StrPrdtVO();
				strPrdtVO.setPrdtId(prdt.getPrdtId());
				strPrdtVO.setStrId(strVO.getStrId());
				strPrdtVO.setMdfyr(strVO.getMdfyr());
				strPrdtList.add(strPrdtVO);
			}
			strPrdtDAO.create(strPrdtList);
		}
		return isSuccess;
	}

	@Override
	public boolean updateOneStrByMaster(StrVO strVO) {
		return strDAO.updateOneStrByMaster(strVO) > 0;
	}

	@Override
	public boolean updateOneStrByManager(StrVO strVO) {
		return strDAO.updateOneStrByManager(strVO) > 0;
	}

	@Override
	public boolean deleteOneStrByStrId(String strId) {
		return strDAO.deleteOneStrByStrId(strId) > 0;
	}

	@Override
	public boolean readBlockStrNm(String strNm) {
		return strDAO.readBlockStrNm(strNm) > 0;
	}
	@Override
	public boolean readBlockStrAddr(String strAddr) {
		return strDAO.readBlockStrAddr(strAddr) > 0;
	}
	@Override
	public boolean readBlockStrCallNum(String strCallNum) {
		return strDAO.readBlockStrCallNum(strCallNum) > 0;
	}

	@Override
	public boolean readBlockStrByMan(String strId) {
		return strDAO.readBlockStrByMan(strId) > 0;
	}
	
	/**
	 * 회원기능과 연동
	 */
	@Override
	public List<StrVO> readAllStrNoPagenate(StrVO strVO) {
		return strDAO.readAllStrNoPagenate(strVO);
	}

	@Override
	public List<CtyCdVO> readCategory(String lctId) {
		return strDAO.readCategory(lctId);
	}
	/**
	 * 매장별 상품등록시 사용 ... 사용유무에 관계없이 목록가져옴
	 */
	@Override
	public List<StrVO> readAll() {
		return strDAO.readAll();
	}
	
	/**
	 *  손님이 매장 조회할 때 사용 ... 사용유무 Y
	 */
	@Override
	public List<StrVO> readAllUseY(String ctyId) {
		return strDAO.readAllUseY(ctyId);
	}

}

