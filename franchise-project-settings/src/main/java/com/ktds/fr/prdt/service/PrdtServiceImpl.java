package com.ktds.fr.prdt.service;

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
import com.ktds.fr.prdt.dao.PrdtDAO;
import com.ktds.fr.prdt.vo.PrdtVO;
import com.ktds.fr.str.dao.StrDAO;
import com.ktds.fr.str.vo.StrVO;
import com.ktds.fr.strprdt.dao.StrPrdtDAO;
import com.ktds.fr.strprdt.vo.StrPrdtVO;

@Service
public class PrdtServiceImpl implements PrdtService {
	
	private static final Logger logger = LoggerFactory.getLogger(PrdtServiceImpl.class);

	@Autowired
	private PrdtDAO prdtDAO;
	
	@Autowired
	private StrPrdtDAO strPrdtDAO;
	
	@Autowired
	private StrDAO strDAO;

	@Value("${upload.prdt.path:/franchise-prj/files/prdt/}")
	private String profilePath;

	@Override
	public List<PrdtVO> readAll(PrdtVO prdtVO) {
		return prdtDAO.readAll(prdtVO);
	}

	@Override
	public PrdtVO readOne(String prdtId) {
		return prdtDAO.readOne(prdtId);
	}
	
	@Override
	public List<PrdtVO> readAllCustomer(PrdtVO prdtVO) {
		return prdtDAO.readAllCustomer(prdtVO);
	}

	@Override
	public boolean create(PrdtVO prdtVO, MultipartFile uploadFile) {

		String srt = prdtVO.getPrdtSrt();
		if (srt == null || srt.trim().length() == 0) {
			throw new ApiArgsException("400", "분류 선택 필요");
		}
		String nm = prdtVO.getPrdtNm();
		if (nm == null || nm.trim().length() == 0) {
			throw new ApiArgsException("400", "이름이 비었음");
		} else if (nm.length() > 20) {
			throw new ApiArgsException("400", "이름은 20글자를 넘을 수 없습니다.");
		}
		int prc = prdtVO.getPrdtPrc();
		if (prc == 0) {
			throw new ApiArgsException("400", "가격이 비었음");
		} else if (prc > 9999999) {
			throw new ApiArgsException("400", "가격은 9,999,999를 넘을 수 없습니다.");
		}

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
			
			prdtVO.setOrgnFlNm(originFileName);
			prdtVO.setUuidFlNm(uuidFileName);
			prdtVO.setFlSize(fileSize);
			prdtVO.setFlExt(fileExt);
		}
		
		boolean isSuccess = prdtDAO.create(prdtVO) > 0;
		
		if (isSuccess) {
			StrVO strVO = new StrVO();
			List<StrVO> strList = strDAO.readAllStrMaster(strVO);
			
			StrPrdtVO strPrdtVO = null;
			List<StrPrdtVO> strPrdtList = new ArrayList<>();
			
			for (StrVO str : strList) {
				strPrdtVO = new StrPrdtVO();
				strPrdtVO.setStrId(str.getStrId());	// 반복도는 매장 id, 바뀔값
				strPrdtVO.setPrdtId(prdtVO.getPrdtId());	//현재 등록된 상품 id
				strPrdtVO.setMdfyr(prdtVO.getMdfyr());	//현재등록된 등록자 id
				strPrdtList.add(strPrdtVO);
			}
			strPrdtDAO.create(strPrdtList);
		}
		
		return isSuccess;
	}

	@Override
	public boolean update(PrdtVO prdtVO, MultipartFile uploadFile) {
		
		String srt = prdtVO.getPrdtSrt();
		if (srt == null || srt.trim().length() == 0) {
			throw new ApiArgsException("400", "분류 선택 필요");
		}
		String nm = prdtVO.getPrdtNm();
		if (nm == null || nm.trim().length() == 0) {
			throw new ApiArgsException("400", "이름이 비었음");
		} else if (nm.length() > 20) {
			throw new ApiArgsException("400", "이름은 20글자를 넘을 수 없습니다.");
		}
		int prc = prdtVO.getPrdtPrc();
		if (prc== 0) {
			throw new ApiArgsException("400", "가격이 비었음");
		}
		
		
		boolean isModify = false;
		PrdtVO origin= prdtDAO.readOne(prdtVO.getPrdtId());
		if (!origin.getPrdtNm().equals(prdtVO.getPrdtNm())) {
			isModify = true;
		}
		if (origin.getPrdtPrc() != prdtVO.getPrdtPrc()) {
			isModify = true;
		}
		if (!origin.getPrdtNm().equals(prdtVO.getPrdtNm())) {
			isModify = true;
		}
		if (!origin.getPrdtSrt().equals(prdtVO.getPrdtSrt())) {
			isModify = true;
		}
		String useYn = prdtVO.getUseYn() == null ? "N" : prdtVO.getUseYn() ;
		if (!origin.getUseYn().equals(useYn)) {
			isModify = true;
		}
		
		if ((prdtVO.getUuidFlNm() == null 
				|| prdtVO.getUuidFlNm().length() == 0)
				&& prdtVO.getIsDeleteImg().equals("N")) {
			prdtVO.setOrgnFlNm(origin.getOrgnFlNm());
			prdtVO.setUuidFlNm(origin.getUuidFlNm());
			prdtVO.setFlSize(origin.getFlSize());
			prdtVO.setFlExt(origin.getFlExt());
		} else {
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
				
				prdtVO.setOrgnFlNm(originFileName);
				prdtVO.setUuidFlNm(uuidFileName);
				prdtVO.setFlSize(fileSize);
				prdtVO.setFlExt(fileExt);
			}
			return prdtDAO.update(prdtVO) > 0;
		} else {
			throw new ApiException("400", "변경된 정보 없음");
		}
		
	}

	@Override
	public boolean updateAll(PrdtVO prdtVO) {
		String useYn = prdtVO.getUseYn();
		if (useYn == null || useYn.trim().length() == 0) {
			throw new ApiArgsException("400", "사용유무 선택 필요");
		}
		return prdtDAO.updateAll(prdtVO) > 0;
	}
	
	@Override
	public boolean deleteOne(String prdtId) {
		if (prdtId == null || prdtId.trim().length() == 0) {
			throw new ApiArgsException("400", "선택된 항목이 없습니다.");
		}
		boolean result = prdtDAO.deleteOne(prdtId) > 0;
		if (result) {
			strPrdtDAO.deletePrdtId(prdtId);
		}
		return result;
	}

	@Override
	public boolean deleteSelectAll(List<String> prdtIdList) {
		System.out.println(prdtIdList.size() + "일괄삭제용 리스트크기다");
		if (prdtIdList.size()==0) {
			throw new ApiArgsException("400", "선택된 항목이 없습니다.");
		}
		boolean result = prdtDAO.deleteSelectAll(prdtIdList) > 0;
		if (result) {
			strPrdtDAO.deletePrdtList(prdtIdList);
		}
		return result;
	}

	
}
