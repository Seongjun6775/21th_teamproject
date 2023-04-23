package com.ktds.fr.evnt.service;

import java.io.File;
import java.io.IOException;
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
import com.ktds.fr.prdt.service.PrdtServiceImpl;

@Service
public class EvntServiceImpl implements EvntService {

	private static final Logger logger = LoggerFactory.getLogger(PrdtServiceImpl.class);

	@Autowired
	private EvntDAO evntDAO;

	@Value("${upload.evnt.path:/franchise-prj/files/evnt/}")

	private String profilePath;

	// 1. 이벤트 등록 ▶▶상위관리자
	@Override
	public boolean createNewEvnt(EvntVO evntVO, MultipartFile uploadFile) {

		/*
		 * 나중에 수정해서 사용할 예정 !!! String srt = evntVO.getPrdtSrt(); if (srt == null ||
		 * srt.trim().length() == 0) { throw new ApiArgsException("400", "분류 선택 필요"); }
		 * String nm = evntVO.getPrdtNm(); if (nm == null || nm.trim().length() == 0) {
		 * throw new ApiArgsException("400", "이름이 비었음"); } else if (nm.length() > 20) {
		 * throw new ApiArgsException("400", "이름은 20글자를 넘을 수 없습니다."); } int prc =
		 * evntVO.getPrdtPrc(); if (prc == 0) { throw new ApiArgsException("400",
		 * "가격이 비었음"); } else if (prc > 9999999) { throw new ApiArgsException("400",
		 * "가격은 9,999,999를 넘을 수 없습니다."); }
		 */

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

		return evntDAO.createNewEvnt(evntVO) > 0;
	}

	// 2. 이벤트 전체목록 조회 ▶▶상위관리자
	@Override
	public List<EvntVO> readAllEvnt(EvntVO evntVO) {
		return evntDAO.readAllEvnt(evntVO);
	}

	// 3. 이벤트 조회(상세조회 + 참여 여부 확인) ▶중간관리자
	@Override
	public EvntVO readOneEvnt(String evntId) {
		return evntDAO.readOneEvnt(evntId);
	}

	// 4. 이벤트 결정 전,후 내용 조회 ▷상위관리자,중간관리자

	// 5. 이벤트 내용 수정 ▶▶상위관리자
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
			String fileExt = uploadFile.getContentType();
			if (!(fileExt.contains("image"))) {
				throw new ApiArgsException("400", "이미지 파일만 업로드 가능합니다.\njpg, jpeg, png, gif, bmp");
			}
			if (uploadFile != null && !uploadFile.isEmpty()) {
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

	// 6. 이벤트 수정(이벤트 참여 여부 선택 후 수정) ▶중간관리자

	// 7. 이벤트 삭제 ▶▶상위관리자
	@Override
	public boolean updateDeleteEvnt(String evntId) {
		return evntDAO.updateDeleteEvnt(evntId) > 0;
	}

	// 8. 이용자용 페이지
	@Override
	public List<EvntVO> readAllOngoingEvnt(EvntVO evntVO) {
		return evntDAO.readAllOngoingEvnt(evntVO);
	}
}