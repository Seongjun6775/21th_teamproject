package com.ktds.fr.evnt.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.ktds.fr.evnt.service.EvntService;
import com.ktds.fr.evnt.vo.EvntVO;

@Controller
public class EvntController {

	@Autowired
	private EvntService evntService;

	// 검색기능을 위한 변수
	private String search;
	private String keyword;

	// 1. 이벤트 작성 페이지
	@GetMapping("/evnt/create")
	public String createEvntPage(Model model, EvntVO evntVO) {
		model.addAttribute("evntVO", evntVO);
		return "evnt/create";
	}

	// 2. 이벤트 목록 조회 페이지
	@GetMapping("/evnt/list")
	public String viewEvntListPage(Model model, EvntVO evntVO) {
		List<EvntVO> evntList = evntService.readAllEvnt(evntVO);
		model.addAttribute("evntList", evntList);
		return "evnt/list";
	}

	// 3. 이벤트 상세조회
	@GetMapping("/evnt/detail/{evntId}")
	public String postEvntUpdate(Model model, @PathVariable String evntId) {
		EvntVO evntVO = evntService.readOneEvnt(evntId);
		model.addAttribute("evntVO", evntVO);
		return "evnt/detail";
	}

	// 4. 이벤트 상세조회->그대로 수정페이지로 변환

	@GetMapping("/evnt/update/{evntId}")
	public String postEvntUpdatepage(Model model, @PathVariable String evntId) {
		EvntVO evntVO = evntService.readOneEvnt(evntId);
		evntVO.setEvntId(evntId);
		model.addAttribute("evntVO", evntVO);

		return "evnt/update";

	}

	// 5. 이벤트리스트 검색기능
	/*
	 * public String viewSearchEvntPage(Model model, EvntVO evntVO, String search,
	 * String keyword) { List<EvntVO> searchList = evntService.readAllEvnt(evntVO);
	 * evntVO.setEvntTtl(search); evntVO.setEvntCntnt(search);
	 * evntVO.setEvntStrtDt(keyword); model.addAttribute(keyword, searchList);
	 * 
	 * return "evnt/list/"; }
	 */

	/*
	 * int start = pager.getPageBegin(); int end = pager.getPageEnd(); public
	 * List<EvntVO> list = evntService.readAllEvnt(Model model, search_option,
	 * keyword, start, end)
	 */
	/*
	 * // 4. 이벤트 수정 페이지
	 * 
	 * @GetMapping("/evnt/update") public String updateEvntPage(Model model, EvntVO
	 * evntVO) { model.addAttribute("evntVO", evntVO); return "evnt/update"; }
	 */

	/*
	 * // 5. 이벤트 삭제 페이지
	 * 
	 * @GetMapping("/evnt/detail/{evntId}") public String updatedeleteEvntPage(Model
	 * model, @PathVariable String evntId) { boolean deleteTF =
	 * evntService.updateDeleteEvnt(evntId); return "redirect:/evnt/list3"; }
	 */

}
