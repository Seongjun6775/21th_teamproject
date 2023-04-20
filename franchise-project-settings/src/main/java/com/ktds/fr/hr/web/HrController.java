package com.ktds.fr.hr.web;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.ForEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.common.util.DownloadUtil;
import com.ktds.fr.hr.service.HrService;
import com.ktds.fr.hr.vo.HrVO;
import com.ktds.fr.mbr.vo.MbrVO;

@Controller
public class HrController {
	
	@Autowired
	private HrService hrService;
	
	// 파일 다운로드 시 파일을 찾아서 받아 올 경로입니다.
	@Value("${upload.hr.path:/franchise-prj/files/hr/}")
	private String filePath;
	
	/**
	 * 접속 중인 계정의 권한을 확인하여, 권한에 맞는 페이지로 이동시킵니다.
	 * @param mbrVO 현재 접속중인 계정 정보
	 * @return 계정 권한에 맞는 페이지
	 */
	@GetMapping("/hr/list")
	public String viewHrPage(@SessionAttribute("__MBR__") MbrVO mbrVO) {
		// 최고관리자는 채용 관리 페이지로 이동시킵니다(hrmstr~)
		if (mbrVO.getMbrLvl().equals("001-01")) {
			return "redirect:/hr/hrmstrlist";
		}
		// 그 외에는 일반 회원 페이지로 이동시킵니다.(hr~)
		else if (mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03") || mbrVO.getMbrLvl().equals("001-04")){
			return "redirect:/hr/hrlist";
		}
		// 혹여나 존재할지 모르는 이상한 계정의 경우, 메인 화면으로 돌려보냅니다.
		else {
			return "redirect:/index";
		}
	}
	
	/**
	 * 최고관리자 채용 페이지 전체 조회입니다.
	 * @param mbrVO 현재 접속중인 계정 정보
	 * @param searchIdx 검색 조건
	 * @param keyword 검색 값
	 * @param model
	 * @param hrVO 검색으로 받아올 기타 조건들
	 * @return 최고관리자 채용 관리 페이지
	 */
	@GetMapping("/hr/hrmstrlist")
	public String viewHrMstrListPage(@SessionAttribute("__MBR__") MbrVO mbrVO
									, @RequestParam(required=false, defaultValue = "") String searchIdx
									, @RequestParam(required=false, defaultValue = "") String keyword
									, Model model, HrVO hrVO) {
		// 접근한 계정이 최고관리자인지 확인합니다.
		if (mbrVO.getMbrLvl().equals("001-01")) {
			// 검색 조건을 확인하여 값을 부여합니다.
			if (searchIdx.equals("hrTtl")) {
				hrVO.setHrTtl(keyword);
			}
			if (searchIdx.equals("mbrId")) {
				hrVO.setMbrId(keyword);
			}
			// 채용 게시판의 모든 게시글을 가져와 hrList로 전송합니다.
			List<HrVO> hrList = hrService.readAllHr(hrVO);
			model.addAttribute("hrList", hrList);
			// 권한 확인 및 검색을 위해 필요한 정보들을 model로 전송합니다.
			model.addAttribute("mbrVO", mbrVO);
			model.addAttribute("hrVO", hrVO);
			model.addAttribute("searchIdx", searchIdx);
			model.addAttribute("keyword", keyword);
			
			return "hr/hrmstrlist";
		}
		// 최고관리자가 아닐 경우, 다시 권한을 확인하여 적절한 페이지로 이동시킵니다.
		return "redirect:/hr/list";
	}
	
	/**
	 * 일반 회원들이 확인하는 채용 페이지입니다.
	 * @param mbrVO 현재 접속중인 계정 정보
	 * @param model
	 * @param hrVO
	 * @return 일반 회원 채용 페이지
	 */
	@GetMapping("/hr/hrlist")
	public String viewMyHrListPage(@SessionAttribute("__MBR__") MbrVO mbrVO
								  , Model model, HrVO hrVO) {
		if ((mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03") || mbrVO.getMbrLvl().equals("001-04"))) {
			
			hrVO.setMbrId(mbrVO.getMbrId());
			
			List<HrVO> myHrList = hrService.readAllMyHr(hrVO);
			model.addAttribute("myHrList", myHrList);
			model.addAttribute("mbrVO", mbrVO);
			
			return "hr/hrlist";
		}
		return "redirect:/hr/list";
	}
	
	/**
	 * 글 작성 페이지로 이동합니다.
	 * @param mbrVO 현재 접속중인 계정 정보
	 * @param model
	 * @return 글 작성 페이지
	 */
	@GetMapping("/hr/hrcreate")
	public String viewCreatePage(@SessionAttribute("__MBR__") MbrVO mbrVO
								, Model model) {
		
		boolean check = hrService.checkCreateYn(mbrVO.getMbrId());
		
		// 최고 관리자가 아닐 경우, 이미 접수되거나 심사중인 글이 있다면 글 작성이 불가능합니다.
		if (!mbrVO.getMbrLvl().equals("001-01")) {
			if (!check) {
				throw new ApiException("500", "이미 진행중인 지원 정보가 있습니다.");
			}
		}
		
		model.addAttribute("mbrVO", mbrVO);
		return "hr/hrcreate";
	}
	
	/**
	 * 최고관리자가 보는 상세 조회 페이지입니다.
	 * @param mbrVO 현재 접속중인 계정 정보
	 * @param hrId 상세 조회할 글 ID
	 * @param model
	 * @return 최고관리자 상세 조회 페이지
	 */
	@GetMapping("/hr/hrmstrdetail/{hrId}")
	public String viewMstrDetailPage(@SessionAttribute("__MBR__") MbrVO mbrVO
									, @PathVariable String hrId, Model model) {
		
		if (mbrVO.getMbrLvl().equals("001-01")) {
			
			HrVO hr = hrService.readOneHrByHrId(hrId);
			
			// 조회하는 글이 공지가 아니고, 최고관리자가 읽은 적이 없어 "접수"인 상태라면 "심사중"으로 변경시킨 후 조회합니다.
			if (hr.getNtcYn().equals("N") && hr.getHrStat().equals("접수")) {
				hrService.updateHrStatByHrId(hrId);
				hr = hrService.readOneHrByHrId(hrId);
			}
			model.addAttribute("hr", hr);
			model.addAttribute("mbrVO", mbrVO);
			
			return "hr/hrmstrdetail";
		}
		return "redirect:/hr/list";
	}
	
	/**
	 * 일반 회원이 보는 상세 조회 페이지입니다.
	 * @param mbrVO 현재 접속중인 계정 정보
	 * @param hrId 상세 조회할 글 ID
	 * @param model
	 * @return 일반 회원 상세 조회 페이지
	 */
	@GetMapping("/hr/hrdetail/{hrId}")
	public String viewDetailPage(@SessionAttribute("__MBR__") MbrVO mbrVO
								, @PathVariable String hrId, Model model) {
		
		HrVO hr = hrService.readOneHrByHrId(hrId);
		if (!hr.getMbrId().equals(mbrVO.getMbrId()) && !hr.getNtcYn().equals("Y")) {
			throw new ApiException("500", "권한이 없어 접근할 수 없습니다!");
		}
		else if (hr.getDelYn().equals("Y") && !mbrVO.getMbrLvl().equals("001-01")) {
			throw new ApiException("500", "권한이 없어 접근할 수 없습니다!");
		}
		else {
			model.addAttribute("hr", hr);
			model.addAttribute("mbrVO", mbrVO);
			
			return "hr/hrdetail";
		}
		
	}
	
	/**
	 * 글에 업로드 된 파일을 다운받는 기능입니다.
	 * @param mbrVO 현재 접속중인 계정 정보
	 * @param hrId 다운로드 받을 파일이 있는 글 ID
	 * @param request
	 * @param response
	 */
	@GetMapping("/hr/hrfile/{hrId}")
	public void downloadHrFile(@SessionAttribute("__MBR__") MbrVO mbrVO ,
								@PathVariable String hrId ,
								HttpServletRequest request ,
								HttpServletResponse response) {
		
		HrVO hr = hrService.readOneHrByHrId(hrId);
		if (!hr.getMbrId().equals(mbrVO.getMbrId()) && !mbrVO.getMbrLvl().equals("001-01")) {
			throw new ApiException("500", "권한이 없습니다");
		}
		if (hr.getOrgnFlNm() == null || hr.getOrgnFlNm().trim().length() == 0) {
			throw new ApiException("400", "파일이 없습니다.");
		}
		
		String uuid = hr.getUuidFlNm();
		String origin = hr.getOrgnFlNm();
		File hrFile = new File(filePath, uuid);
		if (hrFile.exists() && hrFile.isFile()) {
			DownloadUtil dnUtil = new DownloadUtil(response, request, filePath + "/" + uuid);
			dnUtil.download(origin);
		}
		else {
			throw new ApiException("500", "파일 다운로드에 실패했습니다.");
		}
	}
	
	/**
	 * 글 수정 페이지입니다.
	 * @param mbrVO 현재 접속중인 계정 정보
	 * @param hrId 수정할 글 ID
	 * @param model
	 * @return 글 수정 페이지
	 */
	@GetMapping("/hr/hrupdate/{hrId}")
	public String viewUpdatePage(@SessionAttribute("__MBR__") MbrVO mbrVO
									, @PathVariable String hrId, Model model) {
		
		HrVO hr = hrService.readOneHrByHrId(hrId);
		if (mbrVO.getMbrId().equals(hr.getMbrId())) {
			if (hr.getHrStat().equals("접수")) {
				model.addAttribute("hr", hr);
				model.addAttribute("mbrVO", mbrVO);
				return "hr/hrupdate";
			}
			return "redirect:/hr/list";
		}
		return "redirect:/hr/list";
	}
	

}
