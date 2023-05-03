package com.ktds.fr.hr.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.ktds.fr.common.api.exceptions.ApiArgsException;
import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.hr.service.HrService;
import com.ktds.fr.hr.vo.HrVO;
import com.ktds.fr.mbr.vo.MbrVO;

@RestController
public class RestHrController {
	
	// 파일 다운로드 시 파일을 찾아서 받아 올 경로입니다.
	/* @Value("${upload.hr.path:/franchise-prj/files/hr/}") */
	@Value("${upload.hr.path:/files/hr/}")
	private String filePath;
	
	@Autowired
	private HrService hrService;
	
	@PostMapping("/api/hr/create")
	public ApiResponseVO createNewHr(@SessionAttribute("__MBR__") MbrVO mbrVO, HrVO hrVO
									, MultipartFile uploadFile) {
		// 필수 값들의 null 체크를 진행하기 위해 해당 값들을 저장합니다.
		String hrTtl = hrVO.getHrTtl();
		String hrCntnt = hrVO.getHrCntnt();
		String hrLvl = hrVO.getHrLvl();
		
		// null 체크를 진행합니다.
		if (hrTtl == null || hrTtl.trim().length() == 0) {
			throw new ApiArgsException("400", "제목이 누락되었습니다.");
		}
		if (!mbrVO.getMbrLvl().equals("001-01")) {
			if (hrLvl == null || hrLvl.trim().length() == 0) {
				throw new ApiArgsException("400", "지원 직군이 누락되었습니다.");
			}
		}
		
		// 필수 값들이 비어있지 않다면, 글을 작성합니다.
		boolean createResult = hrService.createNewHr(hrVO, uploadFile);
		
		if (createResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	@PostMapping("/api/hr/delete/{hrId}")
	public ApiResponseVO deleteOneHrByHrId(@PathVariable String hrId,
										   @SessionAttribute("__MBR__") MbrVO mbrVO) {
		// 글 작성자의 정보를 조회합니다.
		HrVO mbrCheck = hrService.readOneHrByHrId(hrId);
		
		// 글 작성자와 현재 접속중인 사람이 다르다면, 삭제 요청을 차단합니다.
		if (!mbrVO.getMbrId().equals(mbrCheck.getMbrId())) {
			return new ApiResponseVO(ApiStatus.FAIL, "잘못된 접근입니다.", "/hr/list");
		}
		// 문제가 없다면 삭제를 진행하고, 결과값을 받아옵니다.
		boolean deleteResult = hrService.deleteOneHrByHrId(hrId);
		
		if (deleteResult) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	@PostMapping("/api/hr/updateapr")
	public ApiResponseVO updateHrAprByHrId(@SessionAttribute("__MBR__") MbrVO mbrVO, HrVO hrVO) {
		// 접속중인 계정이 최고관리자가 아니라면, 채용 여부를 수정할 수 없게 방지합니다.
		if (!mbrVO.getMbrLvl().equals("001-01")) {
			return new ApiResponseVO(ApiStatus.FAIL, "잘못된 접근입니다.", "/hr/list");
		}
		// 최고관리자가 맞다면, 채용 여부를 수정하고 결과를 받아옵니다.

		if(hrVO.getHrLvl().equals("005-01")&&hrVO.getHrAprYn().equals("Y")) {
			hrVO.getMbrVO().setMbrLvl("001-02");
		}else if(hrVO.getHrLvl().equals("005-02")&&hrVO.getHrAprYn().equals("Y")) {
			hrVO.getMbrVO().setMbrLvl("001-03");
		}else {
			hrVO.getMbrVO().setMbrLvl("001-04");
		}
		
		hrVO.getMbrVO().setMdfyr(mbrVO.getMbrNm());
		boolean isSuccess = hrService.updateHrAprByHrId(hrVO);
		
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
	}
	
	
	@PostMapping("/api/hr/update/{hrId}")
	public ApiResponseVO updateOneHrByHrId(@PathVariable String hrId,
										   @SessionAttribute("__MBR__") MbrVO mbrVO, HrVO hrVO
										 , MultipartFile uploadFile) {
		
		// 수정 권한을 확인하기 위해 수정할 글의 정보를 받아옵니다.
		HrVO hr = hrService.readOneHrByHrId(hrId);
		// 만약 접속중인 계정이 수정 요청이 발생한 글의 작성자가 아니라면, 수정 요청을 차단합니다.
		if (!hr.getMbrId().equals(mbrVO.getMbrId())) {
			return new ApiResponseVO(ApiStatus.FAIL, "잘못된 접근입니다.", "/hr/list");
		}
		
		// 필수값의 null 체크를 진행하기 위해, 해당 값들을 받아와 저장합니다.
		String hrTtl = hrVO.getHrTtl();
		String hrCntnt = hrVO.getHrCntnt();
		String hrLvl = hrVO.getHrLvl();
		
		// null 체크를 진행합니다.
		if (hrTtl == null || hrTtl.trim().length() == 0) {
			throw new ApiArgsException("400", "제목이 누락되었습니다.");
		}
		if (!mbrVO.getMbrLvl().equals("001-01")) {
			if (hrLvl == null || hrLvl.trim().length() == 0) {
				throw new ApiArgsException("400", "지원 직군이 누락되었습니다.");
			}
		}
		
		// 문제가 없다면, 수정을 진행하고 결과값을 받아옵니다.
		boolean isSuccess = hrService.updateOneHrByHrId(hrVO, uploadFile);
		
		if (isSuccess) {
			return new ApiResponseVO(ApiStatus.OK);
		}
		return new ApiResponseVO(ApiStatus.FAIL);
		
		
	}
	
	
}
