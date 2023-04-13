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

import com.ktds.fr.cmmncd.dao.CmmnCdDAO;
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
	private CmmnCdDAO cmmnCdDAO;
	
	@Value("${upload.prdt.path:/franchise-prj/files/prdt/}")
	private String profilePath;

	
	@GetMapping("/prdt/list")
	public String prdtList(PrdtVO prdtVO
			, @SessionAttribute("__MBR__") MbrVO mbrVO
			, Model model) {
		// 세션>회원의 등급이 상위관리자가 아닐경우
		if (!mbrVO.getMbrLvl().equals("001-01")) {
			return "prdt/session_error";
		}
		
		List<PrdtVO> prdtList = prdtService.readAll(prdtVO);
		List<CmmnCdVO> srtList = cmmnCdDAO.readCategory("004");
		
		// 공통코드의 분류 목록을 가져오기 위함.
//		List<CmmnCdVO> srtList = cmmnCdService.readAll("PRDT");
		
		model.addAttribute("prdtList", prdtList);
		model.addAttribute("prdtVO", prdtVO);
		model.addAttribute("srtList", srtList);
		
		return "prdt/prdt_list";
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
