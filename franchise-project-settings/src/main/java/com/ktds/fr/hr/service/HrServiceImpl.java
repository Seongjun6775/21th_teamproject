package com.ktds.fr.hr.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.hr.dao.HrDAO;
import com.ktds.fr.hr.vo.HrVO;

@Service
public class HrServiceImpl implements HrService {

	@Autowired
	private HrDAO hrDAO;
	
	// 채용 지원서 작성 시 업로드된 파일이 저장될 경로입니다.
	@Value("upload.hr.hrfile.path:/franchise-prj/hr/files/hrfiles")
	private String filePath;

	@Override
	public List<HrVO> readAllHr() {
		return hrDAO.readAllHr();
	}
	
	@Override
	public List<HrVO> readAllMyHr(String mbrId) {
		return hrDAO.readAllMyHr(mbrId);
	}

	@Override
	public HrVO readOneHrByHrId(String hrId) {
		return hrDAO.readOneHrByHrId(hrId);
	}

	@Override
	public boolean createNewHr(HrVO hrVO, MultipartFile uploadFile) {
		
		// 파일 경로가 있는지 확인하고, 없다면 생성합니다.
		File dir = new File(filePath);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		
		// hrVO에 업로드된 파일의 정보들을 저장합니다.
		hrVO.setOrgnFlNm(uploadFile.getOriginalFilename());
		hrVO.setFlSize(uploadFile.getSize());
		hrVO.setFlExt(StringUtils.getFilenameExtension(uploadFile.getOriginalFilename()));
		
		// 파일 이름을 암호화하기 위해 임시 생성하는 파일입니다.
		String uuidFileName = UUID.randomUUID().toString();
		File hrFile = new File(dir, uuidFileName);
		
		// 임시 생성된 파일에 업로드된 파일을 이동시킵니다.
			try {
				uploadFile.transferTo(hrFile);
			} catch (IllegalStateException | IOException e) {
				throw new ApiException("500", "파일 업로드에 실패했습니다.");
			}
		
		// hrVO에 암호화된 파일의 이름을 저장합니다.
		hrVO.setUuidFlNm(uuidFileName);
		
		return hrDAO.createNewHr(hrVO) > 0;
	}

	@Override
	public boolean updateOneHrByHrId(HrVO hrVO) {
		return hrDAO.updateOneHrByHrId(hrVO) > 0;
	}

	@Override
	public boolean deleteOneHrByHrId(String hrId) {
		return hrDAO.deleteOneHrByHrId(hrId) > 0;
	}
	
	
	
}
