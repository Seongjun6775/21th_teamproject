package com.ktds.fr.ntc.web;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ktds.fr.ntc.service.NtcService;
import com.ktds.fr.ntc.vo.NtcVO;
import com.ktdsuniversity.admin.gnr.vo.GnrVO;

@Controller
public class NtcController {
	
	@Autowired
	private NtcService ntcService;
	
	
	@GetMapping("/ntc/list") //http://losthost:8080//admin/gnr/list?gnr=장르명&pageNo=2&viewCnt=10
	public String viewGnrList(Model model,NtcVO ntcVO) {
		List<NtcVO> ntcList = ntcService.readAllNoticeTitleByNoticeId(ntcId); // 쿼리의 결과라서 여기에 담겨있다. grn
		
		model.addAttribute("ntcList", ntcList);
		model.addAttribute("ntcVO",ntcVO);
//		model.addAttribute("gnrNm", gnrVO.getGnrNm());
//		model.addAttribute("pageNo", gnrVO.getPageNo());
//		model.addAttribute("viewCnt", gnrVO.getViewCnt());	
		return "ntc/list";
	}
	
	@GetMapping("/ntc/search")
	public String viewGnrSearchPage(@RequestParam(required=false) String gnrNm,
										Model model) {
		
		model.addAttribute("gnrNm",gnrNm );
		if(gnrNm != null && gnrNm.length() > 0) {
			List<NtcVO> gnrList = ntcService.readAllNoticeTitleByNoticeId(ntcId);
			model.addAttribute("ntcList", ntcList);
		}
		return "ntc/search";
		
	}
}
