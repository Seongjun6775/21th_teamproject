package com.ktds.fr.mbr.web;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.cmmncd.service.CmmnCdService;
import com.ktds.fr.common.util.SessionManager;
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
	
//	@GetMapping("/mbr/list")
//	public String viewMbrListPage(@SessionAttribute("__MBR__")MbrVO session, Model model, MbrVO mbrVO) {
//		if(!session.getMbrLvl().equals("001-01")) {
//			//TODO 에러 페이지경로 따로 설정해주기 PRDT말고 공용으로
//			return "prdt/session_error";
//		}
//		List<MbrVO> mbrList = mbrService.readAllMbr(mbrVO);
//		List<CmmnCdVO> srtList = cmmnCdService.readCategory("001");
//		model.addAttribute("mbrList", mbrList);
//		model.addAttribute("srtList", srtList);
//		model.addAttribute("MbrVO", mbrVO);
//		
//		return "mbr/mbr_list";
//	}
//	@GetMapping("/mbr/admin/list")
//	public String viewAdminMbrListPage(@SessionAttribute("__MBR__")MbrVO session,
//									   Model model,
//									   MbrVO mbrVO) {
//		if(!session.getMbrLvl().equals("001-01")) {
//			//TODO 에러 페이지경로 따로 설정해주기 PRDT말고 공용으로
//			return "prdt/session_error";
//		}
//		List<MbrVO> mbrList = mbrService.readAllAdminMbr(mbrVO);
//		List<CmmnCdVO> srtList = cmmnCdService.readCategory("001admin");
//		model.addAttribute("mbrList", mbrList);
//		model.addAttribute("srtList", srtList);
//		model.addAttribute("MbrVO", mbrVO);
//		return "mbr/mbr_adminlist";
//	}
	@GetMapping("/mbr/pwdCheck")
	public String viewPwdCheckPage() {
		return "mbr/mbr_check";
	}
	@GetMapping("/mbr/change/pwd")
	public String viewMbrChangPwdPage() {
		return "mbr/mbr_changepwd";
	}
	@GetMapping("/mbr/info")
	public String viewMbrInfoPage(@SessionAttribute("__MBR__") MbrVO mbrVO, Model model) {
		MbrVO myMbr = mbrService.readOneMbrByMbrId(mbrVO.getMbrId());
		model.addAttribute("myMbr" ,myMbr);
		return "mbr/mbr_info";
	}
	@GetMapping("/mbr/logout")
	public String doLogout(@SessionAttribute("__MBR__")MbrVO mbrVO, HttpSession session) {
		SessionManager.getInstance().destroySession(mbrVO.getMbrId());
		LgnHistVO lgnHistVO = new LgnHistVO();
		lgnHistVO.setLgnHistActn("logout");
		lgnHistVO.setMbrId(mbrVO.getMbrId());
		lgnHistVO.setLgnHistIp(mbrVO.getMbrRcntLgnIp());
		mbrService.logoutMbr(lgnHistVO);
		return "redirect:/";
	}
	
	
	
	
}
