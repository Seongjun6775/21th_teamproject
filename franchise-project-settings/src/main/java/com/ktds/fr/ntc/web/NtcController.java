package com.ktds.fr.ntc.web;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ktds.fr.ntc.dao.NtcDAO;
import com.ktds.fr.ntc.service.NtcService;
import com.ktds.fr.ntc.vo.NtcVO;
//import com.ktdsuniversity.admin.gnr.vo.GnrVO;

@Controller
public class NtcController {
	
	@Autowired
	private NtcService ntcService;
	
	
	@GetMapping("/ntc/list")
	public String getList(Model model) {
		List<NtcVO> ntcList = ntcService.readAllNotice();
		model.addAttribute("ntcList",ntcList);
		return "ntc/list";
	}
	

	@GetMapping("/ntc/create")
	public String CreateNotice() {
		return "ntc/create";
	}
	
	
	@GetMapping("/ntc/detail/{ntcId}")
	public String viewDetailPage(@PathVariable String ntcId, Model model) {
		NtcVO ntcVO = ntcService.readSelectedNoticeContent(ntcId);
		model.addAttribute("ntcVO",ntcVO);
		return "ntc/detail";
	}
	
}
