package com.ktds.fr.mbr.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.cmmncd.service.CmmnCdService;
import com.ktds.fr.cmmncd.vo.CmmnCdVO;
import com.ktds.fr.common.api.vo.ApiResponseVO;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.common.util.SessionManager;
import com.ktds.fr.lgnhist.service.LgnHistService;
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
	
	@Autowired
	private LgnHistService lgnHistService;
	
	@GetMapping("/join")
	public String viewJoinPage() {
		return "mbr/joinSite";
	}
	
	@GetMapping("/mbr/list")
	public String viewMbrListPage(@SessionAttribute("__MBR__")MbrVO session, Model model, MbrVO mbrVO) {
		log.info("리스트 사이즈 {}",mbrVO.getViewCnt());
		log.info("페이지 카운트 {}",mbrVO.getPageCnt());
		if(!session.getMbrLvl().equals("001-01")) {
			//TODO 에러 페이지경로 따로 설정해주기 PRDT말고 공용으로
			return "prdt/session_error";
		}
		List<MbrVO> mbrList = mbrService.readAllMbr(mbrVO);
		List<CmmnCdVO> srtList = cmmnCdService.readCategory("001");
		model.addAttribute("mbrList", mbrList);
		model.addAttribute("srtList", srtList);
		model.addAttribute("MbrVO", mbrVO);
		
		return "mbr/mbr_list";
	}
	@GetMapping("/mbr/admin/list")
	public String viewAdminMbrListPage(@SessionAttribute("__MBR__")MbrVO session,
									   Model model,
									   MbrVO mbrVO) {
		if(!session.getMbrLvl().equals("001-01")) {
			//TODO 에러 페이지경로 따로 설정해주기 PRDT말고 공용으로
			return "prdt/session_error";
		}
		List<MbrVO> mbrList = mbrService.readAllAdminMbr(mbrVO);
		List<CmmnCdVO> srtList = cmmnCdService.readCategory("001admin");
		model.addAttribute("mbrList", mbrList);
		model.addAttribute("srtList", srtList);
		model.addAttribute("MbrVO", mbrVO);
		return "mbr/mbr_adminlist";
	}
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
	@GetMapping("/logout")
	public String doLogout(@SessionAttribute("__MBR__")MbrVO mbrVO, HttpSession session) {
		SessionManager.getInstance().destroySession(mbrVO.getMbrId());
		LgnHistVO lgnHistVO = new LgnHistVO();
		lgnHistVO.setLgnHistActn("logout");
		lgnHistVO.setMbrId(mbrVO.getMbrId());
		lgnHistVO.setLgnHistIp(mbrVO.getMbrRcntLgnIp());
		mbrService.logoutMbr(lgnHistVO);
		return "redirect:/join";
	}
	//직원 정보 상세 조회
	@GetMapping("/mbr/detail/{mbrId}")
	public String doCrewDetail(@PathVariable String mbrId, @SessionAttribute("__MBR__")MbrVO mbrVO, Model model) {
		
		MbrVO mbr = mbrService.readOneCrewByMbrId(mbrId);
		model.addAttribute("mbr" ,mbr);
		return "mbr/mbr_admindetail";
	}
	
	/**
	 * 쪽지 작성 기능과 연동됩니다.
	 */
	@GetMapping("/mbr/search")
	public String viewMbrSearchPage(MbrVO mbrVO, Model model) {
		List<MbrVO> mbrList = mbrService.readAllMbrNoPagenation(mbrVO);
		model.addAttribute("mbrList", mbrList);
		model.addAttribute("mbrId", mbrVO.getMbrId());
		model.addAttribute("mbrNm", mbrVO.getMbrNm());
		return "mbr/mbr_search";
	}
	
	//회원 이력 조회
	@GetMapping("/mbr/select/{mbrId}")
	public String viewMbrHistPage(@PathVariable String mbrId, Model model) {
		List<LgnHistVO> histList = lgnHistService.readMbrLgnHist(mbrId);
		model.addAttribute("histList" ,histList);
		return "mbr/mbr_select";
	}

}
