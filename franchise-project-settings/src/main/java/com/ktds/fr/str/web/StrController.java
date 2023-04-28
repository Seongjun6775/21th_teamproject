package com.ktds.fr.str.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.exceptions.IllegalRequestException;
import com.ktds.fr.ctycd.service.CtyCdService;
import com.ktds.fr.ctycd.vo.CtyCdVO;
import com.ktds.fr.lctcd.service.LctCdService;
import com.ktds.fr.lctcd.vo.LctCdVO;
import com.ktds.fr.mbr.service.MbrService;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.odrlst.service.OdrLstService;
import com.ktds.fr.odrlst.vo.OdrLstVO;
import com.ktds.fr.str.service.StrService;
import com.ktds.fr.str.vo.StrVO;

@Controller
public class StrController {

	@Autowired
	private StrService strService;
	@Autowired
	private CtyCdService ctyCdService;
	@Autowired
	private LctCdService lctCdService;
	@Autowired
	private MbrService mbrService;
	@Autowired
	private OdrLstService odrLstService;
	
	@GetMapping("/str/list")
	public String viewStrListPage(@SessionAttribute("__MBR__") MbrVO mbrVO, MbrVO mbr2VO, String strId, Model model, StrVO strVO
									, @RequestParam(required = false, defaultValue = "") String searchIdx
									, @RequestParam(required = false, defaultValue = "")String keyword ,CtyCdVO ctyCdVO, LctCdVO lctCdVO) {
	    if (mbrVO.getMbrLvl().equals("001-01")) {
	    	
	    	if (searchIdx.equals("strNm")) {
	    		strVO.setStrNm(keyword);
	    	}
	    	if (searchIdx.equals("mbrId")) {
	    		strVO.setMbrId(keyword);
	    	}
	    	if (strVO.getStrCty() != null && strVO.getStrCty().trim().length() != 0) {
	    		ctyCdVO.setCtyId(strVO.getStrCty());
	    	}
	    	if (strVO.getStrLctn() != null && strVO.getStrLctn().trim().length() != 0) {
	    		lctCdVO.setLctId(strVO.getStrLctn());
	    		ctyCdVO.setLctId(strVO.getStrLctn());
	    	}
	    	
	        List<StrVO> strList = strService.readAllStrMaster(strVO);
	        List<MbrVO> mbrList = mbrService.readAllMbr(mbr2VO);
	        List<CtyCdVO> ctyList = ctyCdService.readCategory(ctyCdVO);
	        List<LctCdVO> lctList = lctCdService.readCategory(lctCdVO);
	        model.addAttribute("strList", strList);
	        model.addAttribute("mbrList", mbrList);
	        model.addAttribute("ctyList", ctyList);
	        model.addAttribute("lctList", lctList);
	        model.addAttribute("strVO", strVO);
	        model.addAttribute("mbrVO", mbrVO);
	        model.addAttribute("searchIdx", searchIdx);
	        model.addAttribute("keyword", keyword);
	        model.addAttribute("CtyCdVO", ctyCdVO);
	        model.addAttribute("LctCdVO", lctCdVO);
	        return "str/list";
	        
	    } else if (mbrVO.getMbrLvl().equals("001-02")) {
	    	return "redirect:/str/strdetailmgn/" + mbrVO.getStrId();
	    } else {
	        return "redirect:/index";
	    }
	}
	
	@GetMapping("/str/create")
	public String viewStrCreatePage() {
		return "str/create";
	}
	
	@GetMapping("/str/strdetailmst/{strId}")
	public String viewStrDetailMstPage(@SessionAttribute("__MBR__") MbrVO mbrVO, @PathVariable String strId, Model model, CtyCdVO ctyCdVO, LctCdVO lctCdVO) {
		StrVO strVO = strService.readOneStrByMaster(strId);
		List<CtyCdVO> ctyList = ctyCdService.readCategory(ctyCdVO);
	    List<LctCdVO> lctList = lctCdService.readCategory(lctCdVO);
	    mbrVO.setStrId(strId);
	    List<MbrVO> mbrList = mbrService.readAllCrewMbrByStrId(mbrVO);
	    model.addAttribute("mbrList",mbrList);
        model.addAttribute("ctyList", ctyList);
        model.addAttribute("lctList", lctList);
		model.addAttribute("strVO", strVO);
		model.addAttribute("MbrVO", mbrVO);
		return "str/strdetailmst";
		
	}
	@GetMapping("/str/strdetailmgn/{strId}")
	public String viewStrDetailMgnPage(@SessionAttribute("__MBR__") MbrVO mbrVO, @PathVariable String strId, Model model, CtyCdVO ctyCdVO, LctCdVO lctCdVO) {
		if(!mbrVO.getStrId().equals(strId)) {
			throw new IllegalRequestException();
		}
		StrVO strVO = strService.readOneStrByManager(strId);
		List<CtyCdVO> ctyList = ctyCdService.readCategory(ctyCdVO);
	    List<LctCdVO> lctList = lctCdService.readCategory(lctCdVO);
	    List<MbrVO> mbrList = mbrService.readAllCrewMbrByStrId(mbrVO);
		model.addAttribute("mbrList",mbrList);
        model.addAttribute("ctyList", ctyList);
        model.addAttribute("lctList", lctList);
		model.addAttribute("strVO", strVO);
		model.addAttribute("MbrVO", mbrVO);
		return "str/strdetailmgn";
        
	}
	
	/**
	 * 회원 기능과 연동
	 */
	@GetMapping("/str/search/{mbrLvl}")
	public String viewStrSearchPage(@PathVariable String mbrLvl,StrVO strVO, Model model) {
		model.addAttribute("strNm", strVO.getStrNm());
		model.addAttribute("strAddr", strVO.getStrAddr());
		if(mbrLvl.equals("001-02")) {
			MbrVO mbrVO = new MbrVO();
			mbrVO.setMbrLvl(mbrLvl);
			strVO.setMbrVO(mbrVO);
		}
		List<StrVO> strList = strService.readAllStrNoPagenate(strVO);
		model.addAttribute("strList",strList);
		return "mbr/str_search";
	}
	
	/**
	 * 매장의 직원들 정보 조회(전체)
	 * 
	 *@GetMapping("/str/crew/list")
	 *public String viewStrCrewPage(@SessionAttribute("__MBR__")MbrVO mbrVO, Model model) {
	 *	//
	 *	List<MbrVO> mbrList = mbrService.readAllCrewMbrByStrId(mbrVO);
	 *	model.addAttribute("mbrList",mbrList);
	 *	return "str/str_crewlist";
	 *}
	 */
	
	
	
	/**
	 * 매장에 관련된 주문서 조회
	 */
	@GetMapping("/str/odrlst")
	public String viewOdrLstForStr(Model model
			, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		StrVO strVO = strService.readOneStrByMaster(mbrVO.getStrId());
		OdrLstVO odrLstVO = new OdrLstVO();
		odrLstVO.setStrId(mbrVO.getStrId());
		
		List<OdrLstVO> ordLstList = odrLstService.readAllOdrLstForStr(odrLstVO);
		odrLstVO.setOdrLstOdrPrcs("003-04");
		List<OdrLstVO> ordLstCompleteList = odrLstService.readAllOdrLstForStr(odrLstVO);
		
		
		model.addAttribute("strVO", strVO);
		model.addAttribute("ordLstList", ordLstList);
		model.addAttribute("ordLstCompleteList", ordLstCompleteList);
		
		return "str/str_odrlst";
	}
	
	
}
