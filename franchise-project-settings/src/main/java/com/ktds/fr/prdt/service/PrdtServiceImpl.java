package com.ktds.fr.prdt.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
		
		// TODO 파일 업로드 대기...완성되면 주석해제할것 
//		if (uploadFile != null && !uploadFile.isEmpty()) {
//			File dir = new File(profilePath);
//			if (!dir.exists()) {
//				dir.mkdirs();
//			}
//			String uuidFileName = UUID.randomUUID().toString();
//			File profileFile = new File(dir, uuidFileName);
//			try {
//				uploadFile.transferTo(profileFile);
//			} catch (IllegalStateException | IOException e) {
//				logger.error(e.getMessage(), e);
//			}
//			prdtVO.setPrdtFileId(uuidFileName);
//		}
		prdtVO.setPrdtFileId("sample_file_name");
		
		return prdtDAO.create(prdtVO) > 0;
	}

	@Override
	public boolean update(PrdtVO prdtVO, MultipartFile uploadFile) {
		
		boolean isModify = false;
		PrdtVO origin= prdtDAO.readOne(prdtVO.getPrdtId());
		if (!prdtVO.getPrdtNm().equals(origin.getPrdtNm())) {
			isModify = true;
		}
		if (prdtVO.getPrdtPrc() != origin.getPrdtPrc()) {
			isModify = true;
		}
		if (!prdtVO.getPrdtNm().equals(origin.getPrdtNm())) {
			isModify = true;
		}
		if (!prdtVO.getPrdtSrt().equals(origin.getPrdtSrt())) {
			isModify = true;
		}
		if (!prdtVO.getUseYn().equals(origin.getUseYn())) {
			isModify = true;
		}
		
		// TODO 파일 업로드 대기...완성되면 주석해제할것 
//		if (uploadFile != null && !uploadFile.isEmpty()) {
//			File dir = new File(profilePath);
//			if (!dir.exists()) {
//				dir.mkdirs();
//			}
//			String uuidFileName = UUID.randomUUID().toString();
//			File profileFile = new File(dir, uuidFileName);
//			try {
//				uploadFile.transferTo(profileFile);
//			} catch (IllegalStateException | IOException e) {
//				logger.error(e.getMessage(), e);
//			}
//			prdtVO.setPrdtFileId(uuidFileName);
//		}
		
		prdtVO.setPrdtFileId("sample_file_name");
		
		if (isModify) {
			return prdtDAO.update(prdtVO) > 0;
		} else {
			throw new ApiException("400", "변경된 정보 없음");
		}
		
	}

	@Override
	public boolean deleteOne(String prdtId) {
		return prdtDAO.deleteOne(prdtId) > 0;
	}

	@Override
	public boolean deleteSelectAll(List<String> prdtIdList) {
		return prdtDAO.deleteSelectAll(prdtIdList) > 0;
	}
	
}
