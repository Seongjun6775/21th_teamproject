package com.ktds.fr.mbr.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.cmmncd.service.CmmnCdService;
import com.ktds.fr.cmmncd.vo.CmmnCdVO;
import com.ktds.fr.lgnhist.vo.LgnHistVO;
import com.ktds.fr.mbr.service.MbrService;
import com.ktds.fr.mbr.vo.MbrVO;

@Controller
public class MbrController {
	
	private static final Logger log = LoggerFactory.getLogger(MbrController.class);

	@Autowired
	private MbrService mbrService;

	@Autowired
	private CmmnCdService cmmnCdService;
	
	@GetMapping("/join")
	public String viewJoinPage() {
		return "mbr/joinSite";
	}
	
	@GetMapping("/mbr/list")
	public String viewMbrListPage(Model model, MbrVO mbrVO) {
		List<MbrVO> mbrList = mbrService.readAllMbr(mbrVO);
		List<CmmnCdVO> srtList = cmmnCdService.readCategory("001");
		model.addAttribute("mbrList", mbrList);
		model.addAttribute("srtList", srtList);
		log.info(mbrVO.getDelYn());
		model.addAttribute("MbrVO", mbrVO);
		
		return "mbr/mbr_list";
	}
	@GetMapping("mbr/pwdCheck")
	public String viewPwdCheckPage() {
		return "mbr/mbr_check";
	}
//	@GetMapping("/login")
//	public String viewLoginPage() {
//		return "mbr/login";
//	}
//	@GetMapping("/regist")
//	public String viewMbrRegistPage() {
//		return "mbr/mbr_regist";
//	}
	@GetMapping("/logout")
	public String doLogout(@SessionAttribute("__MBR__")MbrVO mbrVO, HttpSession session) {
		session.invalidate();
		LgnHistVO lgnHistVO = new LgnHistVO();
		lgnHistVO.setLgnHistActn("logout");
		lgnHistVO.setMbrId(mbrVO.getMbrId());
		lgnHistVO.setLgnHistIp(mbrVO.getMbrRcntLgnIp());
		return "redirect:/join";
	}
	
	
}
