package com.ktds.fr.hlpdsk.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.hlpdsk.service.HlpDskService;
import com.ktds.fr.hlpdsk.vo.HlpDskVO;
import com.ktds.fr.mbr.vo.MbrVO;

@Controller
public class HlpDskController {
	
	
	@Autowired
	private HlpDskService hlpDskService;
	
	@GetMapping("/hlpdsk/list_user")
	public String viewHlpDskUser() {
		return "hlpdsk/list_user";
	}
	@GetMapping("/hlpdsk/list")
	public String viewHlpDsklistPage(Model model,HlpDskVO hlpDskVO,
						@SessionAttribute("__MBR__") MbrVO mbrVO,
						@RequestParam(required = false,defaultValue="")String searchIdx,
						@RequestParam(required = false,defaultValue="")String searchKeyword) {
		
		if(mbrVO.getMbrLvl().equals("001-04")) {
			hlpDskVO.setMbrId(mbrVO.getMbrId());
			List<HlpDskVO> myHlpDskList = hlpDskService.readAllMyHlpDsks(hlpDskVO);
			model.addAttribute("hlpDskVO", hlpDskVO);
			model.addAttribute("mbrVO", mbrVO);
			model.addAttribute("myHlpDskList", myHlpDskList);
			return "hlpdsk/list";
		}
	
		
		if(searchIdx.equals("Wrtr")){ 
			hlpDskVO.setMbrVO(new MbrVO());
			hlpDskVO.getMbrVO().setMbrNm(searchKeyword);
		}		
		if(searchIdx.equals("hlpDskTtl")) {
			hlpDskVO.setHlpDskTtl(searchKeyword);
		}
		if(searchIdx.equals("hlpDskCntnt")) {
			hlpDskVO.setHlpDskCntnt(searchKeyword);
		} 
		List<HlpDskVO> hlpDskList = hlpDskService.readAllHlpDsks(hlpDskVO);
		model.addAttribute("hlpDskList", hlpDskList);
		model.addAttribute("hlpDskVO", hlpDskVO);
		model.addAttribute("mbrVO", mbrVO);
		
		model.addAttribute("searchIdx", searchIdx);
		model.addAttribute("searchKeyword", searchKeyword);

		
		return "hlpdsk/mngr_list";
	}
	
	
	@GetMapping("/hlpdsk/{hlpDskId}")
	public String viewHlpDskDetailPage(@PathVariable String hlpDskId,Model model,HlpDskVO hlpDskVO,				
								@SessionAttribute("__MBR__") MbrVO mbrVO) {
		HlpDskVO hlpDsk = hlpDskService.readOneHlpDskByHlpDskId(hlpDskId);
		
		model.addAttribute("hlpDsk", hlpDsk);
		model.addAttribute("mbrVO", mbrVO);
		model.addAttribute("mbrNm", mbrVO.getMbrNm());
		model.addAttribute("mbrId",mbrVO.getMbrId());

		return "hlpdsk/detail";
	}
	
	@GetMapping("/hlpdsk/write")
	public String viewHlpDskWritePage(@SessionAttribute("__MBR__")MbrVO mbrVO, Model model) {
		model.addAttribute("mbrId",mbrVO.getMbrId());
		return "hlpdsk/write";
	}

}
