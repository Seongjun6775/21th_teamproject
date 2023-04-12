package com.ktds.fr.prdt.service;

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
import com.ktds.fr.prdt.dao.PrdtDAO;
import com.ktds.fr.prdt.vo.PrdtVO;

@Service
public class PrdtServiceImpl implements PrdtService {
	
	private static final Logger logger = LoggerFactory.getLogger(PrdtServiceImpl.class);

	@Autowired
	private PrdtDAO prdtDAO;

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
	public boolean create(PrdtVO prdtVO, MultipartFile uploadFile) {
		
		String srt = prdtVO.getPrdtSrt();
		if (srt == null || srt.trim().length() == 0) {
			throw new ApiArgsException("400", "분류 선택 필요");
		}
		String nm = prdtVO.getPrdtNm();
		if (nm == null || nm.trim().length() == 0) {
			throw new ApiArgsException("400", "이름이 비었음");
		}
		int prc = prdtVO.getPrdtPrc();
		if (prc== 0) {
			throw new ApiArgsException("400", "가격이 비었음");
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
			prdtVO.setPrdtFileId(uuidFileName);
		}
		
		return prdtDAO.create(prdtVO) > 0;
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
		
		if ((prdtVO.getPrdtFileId() == null 
				|| prdtVO.getPrdtFileId().length() == 0)
				&& prdtVO.getIsDeleteIMG().equals("N")) {
			prdtVO.setPrdtFileId(origin.getPrdtFileId());
		} else {
			isModify = true;
		}

		
		if (isModify) {
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
				prdtVO.setPrdtFileId(uuidFileName);
			} else {
				prdtVO.setPrdtFileId("none");
			}
			return prdtDAO.update(prdtVO) > 0;
		} else {
			throw new ApiException("400", "변경된 정보 없음");
		}
		
	}

	@Override
	public boolean deleteOne(String prdtId) {
		if (prdtId == null || prdtId.trim().length() == 0) {
			throw new ApiArgsException("400", "선택된 항목이 없습니다.");
		}
		return prdtDAO.deleteOne(prdtId) > 0;
	}

	@Override
	public boolean deleteSelectAll(List<String> prdtIdList) {
		System.out.println(prdtIdList.size() + "일괄삭제용 리스트크기다");
		if (prdtIdList.size()==0) {
			throw new ApiArgsException("400", "선택된 항목이 없습니다.");
		}
		return prdtDAO.deleteSelectAll(prdtIdList) > 0;
	}
	
}
