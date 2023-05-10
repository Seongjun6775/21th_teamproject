package com.ktds.fr.prdt.web;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.cmmncd.service.CmmnCdService;
import com.ktds.fr.cmmncd.vo.CmmnCdVO;
import com.ktds.fr.common.util.DownloadUtil;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.prdt.service.PrdtService;
import com.ktds.fr.prdt.vo.PrdtVO;

@Controller
public class PrdtController {
	
	private static final Logger logger = LoggerFactory.getLogger(PrdtController.class);
	
	@Autowired
	private PrdtService prdtService;
	
	@Autowired
	private CmmnCdService cmmnCdService;
	
	@Value("${upload.prdt.path:/franchise-prj/files/prdt/}")
	private String profilePath;

	
	@GetMapping("/prdt/list")
	public String prdtList(PrdtVO prdtVO
			, @SessionAttribute("__MBR__") MbrVO mbrVO
			, Model model) {
		// 세션>회원의 등급이 상위관리자가 아닐경우
		if (!mbrVO.getMbrLvl().equals("001-01")) {
			if (mbrVO.getMbrLvl().equals("001-04")) {
				return "prdt/session_error";
			}
			return "redirect:/strprdt/list";
		}
		
		List<PrdtVO> prdtList = prdtService.readAll(prdtVO);
		List<CmmnCdVO> srtList = cmmnCdService.readCategory("004");
		
		model.addAttribute("prdtList", prdtList);
		model.addAttribute("prdtVO", prdtVO);
		model.addAttribute("srtList", srtList);
		
		return "prdt/prdt_list";
	}
	
	@GetMapping("/prdt/list2")
	public String prdtList2(PrdtVO prdtVO
			, Model model) {
		// 손님용 페이지 (등급상관없이 전체조회가능)
		List<PrdtVO> prdtList = prdtService.readAllCustomerNoPagenation(prdtVO);
		List<CmmnCdVO> srtList = cmmnCdService.readCategory("004");
		
		model.addAttribute("prdtList", prdtList);
		model.addAttribute("prdtVO", prdtVO);
		model.addAttribute("srtList", srtList);
		
		return "prdt/prdt_list_customer";
	}

	@GetMapping("/prdt/list2/{prdtId}")
	public String prdtDetail(@PathVariable String prdtId
			, Model model) {
		// 손님용 페이지 (등급상관없이 전체조회가능)
		PrdtVO prdtVO = prdtService.readOne(prdtId);
		List<CmmnCdVO> srtList = cmmnCdService.readCategory("004");
		
		model.addAttribute("prdtVO", prdtVO);
		model.addAttribute("srtList", srtList);
		
		return "prdt/prdt_detail";
	}
	

	@GetMapping("/prdt/img/{filename}")
	public void downloadPrflPctr(@PathVariable String filename,
								HttpServletRequest request,
								HttpServletResponse response){
		logger.debug("다운로드 프로필사진의 파일이름 : " + filename);
		File imageFile = new File(profilePath, filename);
		if (!imageFile.exists() || !imageFile.isFile()) {
			logger.debug("파일이 경로에 없어서 기본값으로 호출한다");
			filename = "default_photo.jpg";
		}
		DownloadUtil dnUtil = new DownloadUtil(response, request, profilePath + "/" + filename);
		dnUtil.download(filename);
	}
	
}
