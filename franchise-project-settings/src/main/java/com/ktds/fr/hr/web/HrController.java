package com.ktds.fr.hr.web;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	@Value("${upload.hr.path:/franchise-prj/files/hr/}")
	private String filePath;
	
	@GetMapping("/hr/list")
	public String viewHrPage(@SessionAttribute("__MBR__") MbrVO mbrVO) {
		if (mbrVO.getMbrLvl().equals("001-01")) {
			return "redirect:/hr/mstrlist";
		}
		else if (mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03") || mbrVO.getMbrLvl().equals("001-04")){
			return "redirect:/hr/hrlist";
		}
		else {
			return "redirect:/index";
		}
	}
	
	@GetMapping("/hr/mstrlist")
	public String viewHrMstrListPage(@SessionAttribute("__MBR__") MbrVO mbrVO
									, Model model, HrVO hrVO) {
		
		if (mbrVO.getMbrLvl().equals("001-01")) {
			
			List<HrVO> hrList = hrService.readAllHr(hrVO);
			model.addAttribute("hrList", hrList);
			model.addAttribute("mbrVO", mbrVO);
			
			return "hr/mstrlist";
		}
		
		return "redirect:/hr/list";
	}
	
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
	
	@GetMapping("/hr/create")
	public String viewCreatePage(@SessionAttribute("__MBR__") MbrVO mbrVO
								, Model model) {
		
		boolean check = hrService.checkCreateYn(mbrVO.getMbrId());
		
		if (!check) {
			throw new ApiException("500", "이미 진행중인 지원 정보가 있습니다.");
		}
		
		model.addAttribute("mbrVO", mbrVO);
		return "hr/create";
	}
	
	@GetMapping("/hr/mstrdetail/{hrId}")
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
			
			return "hr/mstrdetail";
		}
		return "redirect:/hr/list";
	}
	
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
	
	@GetMapping("/hr/update/{hrId}")
	public String viewUpdatePage(@SessionAttribute("__MBR__") MbrVO mbrVO
									, @PathVariable String hrId, Model model) {
		
		HrVO hr = hrService.readOneHrByHrId(hrId);
		if (mbrVO.getMbrId().equals(hr.getMbrId())) {
			model.addAttribute("hr", hr);
			model.addAttribute("mbrVO", mbrVO);
			return "hr/hrupdate";
		}
		return "redirect:/hr/list";
	}
	

}
