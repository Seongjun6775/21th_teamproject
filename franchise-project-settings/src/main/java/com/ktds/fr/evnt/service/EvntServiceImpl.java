package com.ktds.fr.evnt.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ktds.fr.common.api.exceptions.ApiArgsException;
import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.evnt.dao.EvntDAO;
import com.ktds.fr.evnt.vo.EvntVO;
import com.ktds.fr.evntstr.dao.EvntStrDAO;
import com.ktds.fr.evntstr.vo.EvntStrVO;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.prdt.service.PrdtServiceImpl;
import com.ktds.fr.str.dao.StrDAO;
import com.ktds.fr.str.vo.StrVO;


@Service
public class EvntServiceImpl implements EvntService {

	private static final Logger logger = LoggerFactory.getLogger(PrdtServiceImpl.class);

	@Autowired
	private EvntDAO evntDAO;

	@Autowired
	private EvntStrDAO evntStrDAO;
	
	@Autowired
	private StrDAO strDAO;
	
	@Value("${upload.evnt.path:/franchise-prj/files/evnt/}")

	private String profilePath;

	
	@Override
	// 1. 이벤트 등록 ▶▶최상위관리자 001-01
	public boolean createNewEvnt(EvntVO evntVO, MultipartFile uploadFile) {

		if (uploadFile != null && !uploadFile.isEmpty()) {
			String fileExt = uploadFile.getContentType();
			if (!(fileExt.contains("image"))) {
				throw new ApiArgsException("400", "이미지 파일만 업로드 가능합니다.\njpg, jpeg, png, gif, bmp");
			}

			File dir = new File(profilePath);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			String uuidFileName = UUID.randomUUID().toString();
			File profileFile = new File(dir, uuidFileName);
			try {
				uploadFile.transferTo(profileFile);
			} catch (IllegalStateException | IOException e) {
				logger.error(e.getMessage(), e);
			}
			String originFileName = uploadFile.getOriginalFilename();
			long fileSize = uploadFile.getSize();

			evntVO.setOrgnFlNm(originFileName);
			evntVO.setUuidFlNm(uuidFileName);
			evntVO.setFlSize(fileSize);
			evntVO.setFlExt(fileExt);
		}

		boolean createResult = evntDAO.createNewEvnt(evntVO) > 0;
		if (createResult) {
			List<StrVO> strList = strDAO.readAll();
			
			EvntStrVO evntStrVO = null;
			List<EvntStrVO> evntStrList = new ArrayList<>();
			
			for(StrVO str : strList) {
				evntStrVO = new EvntStrVO();
				evntStrVO.setEvntId(evntVO.getEvntId());
				evntStrVO.setStrId(str.getStrId());
				evntStrList.add(evntStrVO);
			}
			evntStrDAO.insertAllEvntStr(evntStrList);
		}
		
		return  createResult;
		
		
	}

	@Override
	// 2. 이벤트 전체목록 조회 ▶▶최상위관리자 ▷▷중간관리자 001-01, 001-02
	public List<EvntVO> readAllEvnt(EvntVO evntVO) {
		return evntDAO.readAllEvnt(evntVO);
	}

	
	@Override
	// 3. 이벤트 상세조회 (detail page)  ▶▶최상위관리자 ▷▷중간관리자 001-01, 001-02
	public EvntVO readOneEvnt(String evntId) {
		return evntDAO.readOneEvnt(evntId);
	}

	// 4. 이벤트 등록 내용 수정 ▶▶최상위관리자 001-01
	@Override
	public boolean updateEvnt(EvntVO evntVO, MultipartFile uploadFile) {

		boolean isModify = false;
		EvntVO origin= evntDAO.readOneEvnt(evntVO.getEvntId());
		
		if (!origin.getEvntTtl().equals(evntVO.getEvntTtl())) {
			isModify = true;
		}
		if (origin.getEvntCntnt() != evntVO.getEvntCntnt()) {
			isModify = true;
		}
		if (!origin.getEvntStrtDt().equals(evntVO.getEvntStrtDt())) {
			isModify = true;
		}
		if (!origin.getEvntEndDt().equals(evntVO.getEvntEndDt())) {
			isModify = true;
		}
		
		String useYn = evntVO.getUseYn() == null ? "N" : evntVO.getUseYn() ;
		if (!origin.getUseYn().equals(useYn)) {
			isModify = true;
		}
		
		if ((evntVO.getUuidFlNm() == null 
				|| evntVO.getUuidFlNm().length() == 0)) {
			System.out.println("update 1111111");
			evntVO.setOrgnFlNm(origin.getOrgnFlNm());
			evntVO.setUuidFlNm(origin.getUuidFlNm());
			evntVO.setFlSize(origin.getFlSize());
			evntVO.setFlExt(origin.getFlExt());
		} else {
			System.out.println("update 22222 file delete");
			File file = new File(profilePath + File.separator + origin.getUuidFlNm());
			file.delete();
			
			isModify = true;
		}

		
		if (isModify) {
			
			if (uploadFile != null && !uploadFile.isEmpty()) {
				String fileExt = uploadFile.getContentType();
				if (!(fileExt.contains("image"))) {
					throw new ApiArgsException("400", "이미지 파일만 업로드 가능합니다.\njpg, jpeg, png, gif, bmp");
				}
				File dir = new File(profilePath);
				if (!dir.exists()) {
					dir.mkdirs();
				}
				String uuidFileName = UUID.randomUUID().toString();
				File profileFile = new File(dir, uuidFileName);
				try {
					uploadFile.transferTo(profileFile);
				} catch (IllegalStateException | IOException e) {
					logger.error(e.getMessage(), e);
				}
				
				String originFileName = uploadFile.getOriginalFilename();
				long fileSize = uploadFile.getSize();
				
				evntVO.setOrgnFlNm(originFileName);
				evntVO.setUuidFlNm(uuidFileName);
				evntVO.setFlSize(fileSize);
				evntVO.setFlExt(fileExt);
			}
			return evntDAO.updateEvnt(evntVO) > 0;
		} else {
			throw new ApiException("400", "변경된 정보 없음");
		}


	}

	@Override
	// 5. 이벤트 삭제 ▶▶최상위관리자 001-01
	public boolean updateDeleteEvnt(String evntId) {
		return evntDAO.updateDeleteEvnt(evntId) > 0;
	}
	

	@Override
	// 6. 이용자 페이지(첫화면 -> 현재진행중인 이벤트) ★☆소비자 001-04
	public List<EvntVO> readAllOngoingEvnt(EvntVO evntVO) {
		return evntDAO.readAllOngoingEvnt(evntVO);
	}

	@Override
	// 7. 이용자 페이지(지난이벤트) ★☆소비자 001-04
	public List<EvntVO> readAllPastEvnt(EvntVO evntVO) {
		return evntDAO.readAllPastEvnt(evntVO);
	}

	@Override
	// 8. 이용자 페이지(예정 이벤트) ★☆소비자 001-04
	public List<EvntVO> readAllPlanEvnt(EvntVO evntVO) {
		return evntDAO.readAllPlanEvnt(evntVO);
	}
}