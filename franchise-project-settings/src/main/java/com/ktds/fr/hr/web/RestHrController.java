package com.ktds.fr.hr.web;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.ktds.fr.common.api.exceptions.ApiArgsException;
import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.common.util.DownloadUtil;
import com.ktds.fr.hr.service.HrService;
import com.ktds.fr.hr.vo.HrVO;
import com.ktds.fr.mbr.vo.MbrVO;

@RestController
public class RestHrController {
	
	// 파일 다운로드 시 파일을 찾아서 받아 올 경로입니다.
	@Value("${upload.hr.path:/franchise-prj/files/hr/}")
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
		if (hrCntnt == null || hrCntnt.trim().length() == 0) {
			throw new ApiArgsException("400", "본문이 누락되었습니다.");
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
		
		if(hrVO.getMbrVO().getMbrLvl().equals("005-01")) {
			hrVO.getMbrVO().setMbrLvl("001-02");
		}else if(hrVO.getMbrVO().getMbrLvl().equals("005-02")) {
			hrVO.getMbrVO().setMbrLvl("001-03");
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
		if (hrCntnt == null || hrCntnt.trim().length() == 0) {
			throw new ApiArgsException("400", "본문이 누락되었습니다.");
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
	
	/**
	 * 글에 업로드 된 파일을 다운받는 기능입니다.
	 * @param mbrVO 현재 접속중인 계정 정보
	 * @param hrId 다운로드 받을 파일이 있는 글 ID
	 * @param request
	 * @param response
	 */
	@GetMapping("/hr/hrfile/{hrId}")
	public ApiResponseVO downloadHrFile(@SessionAttribute("__MBR__") MbrVO mbrVO ,
								@PathVariable String hrId ,
								HttpServletRequest request ,
								HttpServletResponse response) {
		
		HrVO hr = hrService.readOneHrByHrId(hrId);
		// 파일에 접근한 사람이 파일을 업로드한 본인인지, 혹은 최고관리자인지 확인합니다.
		if (!hr.getMbrId().equals(mbrVO.getMbrId()) && !mbrVO.getMbrLvl().equals("001-01")) {
			// 둘 모두 아니라면, 접근한 사람이 회원이 지원한 지점의 점주(중간관리자)인지 확인합니다.
			if(!mbrVO.getMbrLvl().equals("001-02") && !hr.getMbrVO().getStrId().equals(mbrVO.getStrId())) {
				// 위 조건을 모두 통과하지 못했다면, 접근을 거부합니다.
				return new ApiResponseVO(ApiStatus.FAIL, "권한이 없습니다","");
			}
		}
		if (hr.getOrgnFlNm() == null || hr.getOrgnFlNm().trim().length() == 0) {
			return new ApiResponseVO(ApiStatus.MISSING_ARGS, "파일이 없습니다.","");
		}
		
		String uuid = hr.getUuidFlNm();
		String origin = hr.getOrgnFlNm();
		File hrFile = new File(filePath, uuid);
		if (hrFile.exists() && hrFile.isFile()) {
			DownloadUtil dnUtil = new DownloadUtil(response, request, filePath + "/" + uuid);
			dnUtil.download(origin);
			return new ApiResponseVO(ApiStatus.OK);
		}
		else {
			return new ApiResponseVO(ApiStatus.FAIL, "파일 다운로드에 실패했습니다.","");
		}
	}
	

}
