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
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;
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
		
		/* 나중에 수정해서 사용할 예정 !!! 
		 * String srt = evntVO.getPrdtSrt(); if (srt == null || srt.trim().length() ==
		 * 0) { throw new ApiArgsException("400", "분류 선택 필요"); } String nm =
		 * evntVO.getPrdtNm(); if (nm == null || nm.trim().length() == 0) { throw new
		 * ApiArgsException("400", "이름이 비었음"); } else if (nm.length() > 20) { throw new
		 * ApiArgsException("400", "이름은 20글자를 넘을 수 없습니다."); } int prc =
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
		
		/*
		 * //★☆★deepCopy 오류로 인해 다시보기!!!! 나머지는 맞는거같음. // 수정할 게시글의 원래 정보 받기 EvntVO
		 * originalData = evntDAO.readOneEvnt(evntVO.getEvntId());
		 * 
		 * // 원래 정보를 비교하기 위해 따로 저장 // 객체 복사. originalData를 ObjectUtils을 통해 JSON 형식으로 변경한
		 * 후, EvntVO 타입으로 복사합니다. EvntVO newData = ObjectUtils.deepCopy(originalData,
		 * EvntVO.class);
		 * 
		 * // 수정할 값들을 비교 후 변경 값이 있다면 true로 바꿔 수정을 실행 boolean updateYn = false; // 이전에
		 * 업로드 되어 있던 파일이 있는지 확인 boolean isExisted = (originalData.getOrgnFlNm() != null
		 * && originalData.getOrgnFlNm().trim().length() != 0); // 새롭게 업로드 된 파일이 있는지 확인
		 * boolean isUploaded = (uploadFile != null && !uploadFile.isEmpty());
		 * 
		 * // 변경파일있으면 수행 if (isUploaded) { // 파일 경로가 있는지 확인하고, 없다면 생성합니다. File dir = new
		 * File(profilePath); if (!dir.exists()) { dir.mkdirs(); }
		 * 
		 * String orgnFilename = uploadFile.getOriginalFilename(); String fileExt =
		 * StringUtils.getFilenameExtension(uploadFile.getOriginalFilename());
		 * 
		 * boolean differentYn = false; updateYn = true;
		 * 
		 * // 기존파일,업로드파일 같은지 비교. // 비교할 값 : 파일 이름, 파일 크기, 파일 확장자입니다. if
		 * (!orgnFilename.equals(originalData.getOrgnFlNm())) {
		 * newData.setOrgnFlNm(orgnFilename); differentYn = true; } if
		 * (originalData.getFlSize() != uploadFile.getSize()) {
		 * newData.setFlSize(uploadFile.getSize()); differentYn = true; } if
		 * (!fileExt.equals(originalData.getFlExt())) { newData.setFlExt(fileExt);
		 * differentYn = true; }
		 * 
		 * // 파일 이름을 암호화하기 위해 임시 생성하는 파일입니다. String uuidFileName =
		 * UUID.randomUUID().toString(); File evntFile = new File(dir, uuidFileName);
		 * 
		 * // 임시 생성된 파일에 업로드된 파일을 이동시킵니다. try { uploadFile.transferTo(evntFile); } catch
		 * (IllegalStateException | IOException e) { throw new ApiException("500",
		 * "파일 업로드에 실패했습니다."); } // newData에 암호화된 파일의 이름을 저장합니다.
		 * newData.setUuidFlNm(uuidFileName);
		 * 
		 * // 만약 기존에 파일이 업로드되어 있었고, 기존과 다른 파일이 새로 업로드 되었는지를 판단합니다. if (differentYn) { //
		 * 기존의 파일을 삭제합니다. File file = new File(profilePath + File.separator +
		 * originalData.getUuidFlNm()); file.delete(); } } // 만약 수정 중 업로드 된 파일이 없다면, 다음을
		 * 수행합니다. else { // 기존에 업로드한 파일이 존재했고, 그 파일을 삭제하려 했는지 확인합니다. if (isExisted &&
		 * (evntVO.getOrgnFlNm() == null || evntVO.getOrgnFlNm().trim().length() == 0))
		 * { // DB에 저장될 파일 정보를 비워줍니다. newData.setOrgnFlNm(evntVO.getOrgnFlNm());
		 * newData.setUuidFlNm(evntVO.getUuidFlNm());
		 * newData.setFlSize(evntVO.getFlSize()); newData.setFlExt(evntVO.getFlExt());
		 * // 기존의 파일을 삭제합니다. File file = new File(profilePath + File.separator +
		 * originalData.getUuidFlNm()); file.delete(); // 파일이 사라져 변경점이 생겼으므로, 수정을 진행합니다.
		 * updateYn = true; } } // 변경점이 있다면 수정을 진행합니다. if (updateYn) { return
		 * evntDAO.updateEvnt(newData) > 0; } // 변경점이 없다면 ApiException을 반환합니다. else {
		 * throw new ApiException("400", "수정된 정보가 없습니다."); }
		 */

		/*
		 * boolean isModify = false; evntDAO.updateEvnt(envtVO); EvntVO evntVO = new
		 * EvntVO();
		 * 
		 * if ((evntVO .getUuidFlNm() == null || evntVO.getUuidFlNm().length() == 0) &&
		 * evntVO.getIsDeletePctr().equals("N")) {
		 * evntVO.setOrgnFlNm(origin.getOrgnFlNm());
		 * evntVO.setUuidFlNm(origin.getUuidFlNm());
		 * evntVO.setFlSize(origin.getFlSize()); evntVO.setFlExt(origin.getFlExt()); }
		 * else { File file = new File(profilePath + File.separator +
		 * origin.getUuidFlNm()); file.delete();
		 * 
		 * isModify = true; }
		 * 
		 * 
		 * if (isModify) { String fileExt = uploadFile.getContentType(); if
		 * (!(fileExt.contains("image"))) { throw new ApiArgsException("400",
		 * "이미지 파일만 업로드 가능합니다.\njpg, jpeg, png, gif, bmp"); } if (uploadFile != null &&
		 * !uploadFile.isEmpty()) { File dir = new File(profilePath); if (!dir.exists())
		 * { dir.mkdirs(); } String uuidFileName = UUID.randomUUID().toString(); File
		 * profileFile = new File(dir, uuidFileName); try {
		 * uploadFile.transferTo(profileFile); } catch (IllegalStateException |
		 * IOException e) { logger.error(e.getMessage(), e); }
		 * 
		 * String originFileName = uploadFile.getOriginalFilename(); long fileSize =
		 * uploadFile.getSize();
		 * 
		 * evntVO.setOrgnFlNm(originFileName); evntVO.setUuidFlNm(uuidFileName);
		 * evntVO.setFlSize(fileSize); evntVO.setFlExt(fileExt); } return
		 * evntDAO.updateEvnt(evntVO) > 0; } else { throw new ApiException("400",
		 * "변경된 정보 없음");
		 * 
		 * }
		 */
		  return false;
		  
		  // return evntDAO.updateEvnt(envtVO) > 0;
		 
		
	}
	
	// 6. 이벤트 수정(이벤트 참여 여부 선택 후 수정) ▶중간관리자

	
	// 7. 이벤트 삭제 ▶▶상위관리자
	@Override
	public boolean updateDeleteEvnt(String evntId) {
		return evntDAO.updateDeleteEvnt(evntId) > 0;
	}
}