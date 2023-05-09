package com.ktds.fr.nt.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.nt.service.NtService;
import com.ktds.fr.nt.vo.NtVO;

@Controller
public class NtController {
	
	@Autowired
	private NtService ntService;
	
	/**
	 * '쪽지관리'를 눌러 페이지에 접근하면 권한 체크를 실행합니다
	 * @param mbrVO 현재 로그인 계정 정보
	 * @return 계정에 맞는 페이지
	 */
	@GetMapping("nt/list")
	public String viewNtPage(@SessionAttribute("__MBR__") MbrVO mbrVO) {
		if (mbrVO.getMbrLvl().equals("001-01")) {
			return "redirect:/nt/ntmstrlist";
		}
		else if (mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03")) {
			return "redirect:/nt/ntmngrlist";
		}
		else if (mbrVO.getMbrLvl().equals("001-04")){
			return "redirect:/nt/ntlist";
		}
		else {
			return "redirect:/index";
		}
	}
	
	
	/**
	 * 최고관리자 계정의 경우 모든 쪽지 목록 조회가 가능한 mstrlist로 이동합니다.
	 * @param mbrVO 현재 로그인 계정 정보
	 * @param model
	 * @param ntVO pagenation 구현용 + 날짜 정보 + 검색 정보 저장용
	 * @param searchVal 검색 정보 저장용 파라미터 - 검색 인덱스 (제목, 수신인, 발신인)
	 * @param keyword 검색 정보 저장용 파라미터 - 검색 값
	 * @param checkNtRdDt 검색 정보 저장용 파라미터 - 수신 여부
	 * @param checkDelYn 검색 정보 저장용 파라미터 - 삭제 여부
	 * @return 최고관리자 쪽지 전체 조회 페이지
	 */
	@GetMapping("/nt/ntmstrlist")
	public String viewMstrNtListPage(@SessionAttribute("__MBR__") MbrVO mbrVO
									, Model model, NtVO ntVO
									, @RequestParam(required=false, defaultValue = "") String searchVal
									, @RequestParam(required=false, defaultValue = "") String keyword
									, @RequestParam(required=false, defaultValue = "") String checkNtRdDt
									, @RequestParam(required=false, defaultValue = "") String checkDelYn) {
		
		if (mbrVO.getMbrLvl().equals("001-01")) {
			// 검색 정보를 ntVO에 저장해 둡니다.
			if (searchVal.equals("ntTtl")) {
				ntVO.setNtTtl(keyword);
			}
			else if (searchVal.equals("sndrId")) {
				ntVO.setSndrId(keyword);
			}
			else if (searchVal.equals("rcvrId")) {
				ntVO.setRcvrId(keyword);
			}
			ntVO.setUseYn(checkNtRdDt);
			ntVO.setDelYn(checkDelYn);
			List<NtVO> allNtList = ntService.readAllNt(ntVO);
			
			model.addAttribute("allNtList", allNtList);
			model.addAttribute("ntVO", ntVO);
			model.addAttribute("searchVal", searchVal);
			model.addAttribute("keyword", keyword);
			model.addAttribute("checkNtRdDt", checkNtRdDt);
			model.addAttribute("checkDelYn", checkDelYn);
			
			return "nt/ntmstrlist";
		}
		// 최고관리자 계정이 아닌 경우, list로 돌려보내 권한에 맞는 페이지로 이동시킵니다.
		return "redirect:/nt/list";
	}
	
	/**
	 * 최고관리자 계정의 경우, 쪽지를 작성할 수 있습니다.
	 * @param mbrVO 현재 로그인 계정 정보
	 * @param model
	 * @return 쪽지 작성 페이지
	 */
	@GetMapping("/nt/ntcreate")
	public String viewNtCreatePage(@SessionAttribute("__MBR__") MbrVO mbrVO, Model model) {
		
		if (mbrVO.getMbrLvl().equals("001-01") || mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03")) {
			model.addAttribute("mbrVO", mbrVO);
			
			return "nt/ntcreate";
		}
		// 최고관리자 계정이 아닌 경우, list로 돌려보내 권한에 맞는 페이지로 이동시킵니다.
		return "redirect:/nt/list";
	}
	
	/**
	 * 최고관리자 계정의 경우, 쪽지를 작성할 수 있습니다.
	 * @param mbrVO 현재 로그인 계정 정보
	 * @param model
	 * @return 쪽지 작성 페이지
	 */
	@GetMapping("/nt/ntcreate/{mbrId}")
	public String viewNtCreatePage(@SessionAttribute("__MBR__") MbrVO mbrVO
								, @PathVariable String mbrId, Model model) {
		
		if (mbrVO.getMbrLvl().equals("001-01") || mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03")) {
			if (mbrVO.getMbrId().equals(mbrId)) {
				return "nt/500sendtome";
			}
			
			model.addAttribute("mbrVO", mbrVO);
			model.addAttribute("rcvrId", mbrId);
			
			return "nt/ntcreate";
		}
		// 최고관리자 계정이 아닌 경우, list로 돌려보내 권한에 맞는 페이지로 이동시킵니다.
		return "redirect:/nt/list";
	}
	
	/**
	 * 최고관리자 계정의 경우, 삭제된 쪽지를 포함해 모든 쪽지를 상세조회 할 수 있습니다.
	 * @param mbrVO 현재 로그인 계정 정보
	 * @param ntId 조회할 쪽지의 Id
	 * @param model
	 * @return 선택한 쪽지 상세 정보 조회 페이지
	 */
	@GetMapping("/nt/ntmstrdetail/{ntId}")
	public String viewMstrNtDetailPage(@SessionAttribute("__MBR__") MbrVO mbrVO
									 , @PathVariable String ntId, Model model) {
		
		if (mbrVO.getMbrLvl().equals("001-01")) {
			NtVO nt = ntService.readOneNtByNtId(ntId);
			// 만약 쪽지를 받는 사람이 접속한 최고관리자 본인이고, 아직 삭제되지 않은 쪽지라면 수신 여부를 '수신'으로 변경합니다.
			if (nt.getRcvrId().equals(mbrVO.getMbrId()) && nt.getDelYn().equals("N")) {
				ntService.updateNtRdDtByNtId(ntId);
			}
			// 수신 여부를 업데이트한 내용을 다시 한번 불러와서 model로 전달합니다.
			nt = ntService.readOneNtByNtId(ntId);
			model.addAttribute("nt", nt);
			
			// detail 페이지에서 쪽지 수정을 할 수 있는데, 자신이 작성한 쪽지만 수정할 수 있습니다.
			// 만약 ${mbrVO.mbrId}가 쪽지의 sndrId와 다르다면 수정을 할 수 없습니다.
			model.addAttribute("mbrVO", mbrVO);
			
			return "nt/ntmstrdetail";
		}
		// 최고관리자 계정이 아닌 경우, list로 돌려보내 권한에 맞는 페이지로 이동시킵니다.
		return "redirect:/nt/list";
	}
	/**
	 * 최고관리자 계정의 경우, 아직 수신되지 않은 쪽지를 수정할 수 있습니다.
	 * @param mbrVO 현재 로그인 계정 정보
	 * @param ntId 수정할 쪽지의 Id
	 * @param model
	 * @return 선택한 쪽지 수정 페이지
	 */
	@GetMapping("nt/ntupdate/{ntId}")
	public String viewNtUpdatePage(@SessionAttribute("__MBR__") MbrVO mbrVO
								 , @PathVariable String ntId, Model model) {
		if (mbrVO.getMbrLvl().equals("001-01")) {
			NtVO nt = ntService.readOneNtByNtId(ntId);
			model.addAttribute("nt", nt);
			
			return "nt/ntupdate";
		}
		// 최고관리자 계정이 아닌 경우, list로 돌려보내 권한에 맞는 페이지로 이동시킵니다.
		return "redirect:/nt/list";
	}
	
	/**
	 * 관리자(중간,하위) 계정의 경우, 자신이 받은 쪽지 목록을 조회할 수 있는 페이지로 이동합니다.
	 * @param mbrVO 현재 로그인 계정 정보
	 * @param model
	 * @param ntVO pagenation 구현용 + 날짜 정보 + 검색 정보 저장용
	 * @param searchVal 검색 정보 저장용 파라미터 - 검색 인덱스 (제목, 발신인)
	 * @param keyword 검색 정보 저장용 파라미터 - 검색 값
	 * @return 관리자 쪽지 전체 조회 페이지
	 */
	@GetMapping("/nt/ntmngrlist")
	public String viewMngrNtListPage(@SessionAttribute("__MBR__") MbrVO mbrVO
									, Model model, NtVO ntVO
									, @RequestParam(required=false, defaultValue = "") String searchVal
									, @RequestParam(required=false, defaultValue = "") String keyword){
		if (mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03")) {
			if (searchVal.equals("ntTtl")) {
				ntVO.setNtTtl(keyword);
			}
			else if (searchVal.equals("sndrId")) {
				ntVO.setSndrId(keyword);
			}
			
			ntVO.setRcvrId(mbrVO.getMbrId());
			List<NtVO> myNtList = ntService.readAllMyNt(ntVO);
			model.addAttribute("myNtList", myNtList);
			model.addAttribute("mbrVO", mbrVO);
			model.addAttribute("ntVO", ntVO);
			model.addAttribute("searchVal", searchVal);
			model.addAttribute("keyword", keyword);
			
			return "nt/ntmngrlist";
		}
		// 관리자 계정이 아닌 경우, list로 돌려보내 권한에 맞는 페이지로 이동시킵니다.
		return "redirect:/nt/list";
	}
	
	/**
	 * 관리자 계정의 경우, 자기가 받은 쪽지를 상세 조회할 수 있습니다.
	 * @param mbrVO 현재 로그인 계정 정보
	 * @param ntId 조회할 쪽지의 Id
	 * @param model
	 * @return 선택한 쪽지 상세 정보 조회 페이지
	 */
	@GetMapping("/nt/ntmngrdetail/{ntId}")
	public String viewMngrNtDetailPage(@SessionAttribute("__MBR__") MbrVO mbrVO
									   , @PathVariable String ntId
									   , Model model) {
		
		if (mbrVO.getMbrLvl().equals("001-02") || mbrVO.getMbrLvl().equals("001-03")) {
			ntService.updateNtRdDtByNtId(ntId);
			NtVO nt = ntService.readOneNtByNtId(ntId);
			
			// 이미 삭제된 쪽지 URL을 직접 입력하여 강제로 들어가려 할 경우, list 화면으로 돌려보냅니다.
			if (nt.getDelYn().equals("Y")) {
				return "redirect:/nt/list";
			}
			// 자기가 받지 않은 쪽지로 강제 이동하려 해도, list 화면으로 돌려보냅니다.
			if (!nt.getRcvrId().equals(mbrVO.getMbrId())) {
				return "redirect:/nt/list";
			}
			model.addAttribute("nt", nt);
			
			return "nt/ntmngrdetail";
		}
		// 관리자 계정이 아닌 경우, list로 돌려보내 권한에 맞는 페이지로 이동시킵니다.
		return "redirect:/nt/list";
	}
	
	/**
	 * 회원 계정의 경우, 자신이 받은 쪽지 목록을 조회할 수 있는 페이지로 이동합니다.
	 * 관리자 페이지와 기능적으로 다른 점은 없고, css가 좀 더 꾸며질 예정입니다.
	 * @param mbrVO 현재 로그인 계정 정보
	 * @param model
	 * @param ntVO pagenation 구현용 + 날짜 정보 + 검색 정보 저장용
	 * @param searchVal 검색 정보 저장용 파라미터 - 검색 인덱스 (제목, 발신인)
	 * @param keyword 검색 정보 저장용 파라미터 - 검색 값
	 * @return 회원 쪽지 전체 조회 페이지
	 */
	@GetMapping("/nt/ntlist")
	public String viewNtListPage(@SessionAttribute("__MBR__") MbrVO mbrVO
									 , Model model, NtVO ntVO
									 , @RequestParam(required=false, defaultValue = "") String searchVal
									 , @RequestParam(required=false, defaultValue = "") String keyword){
		if (mbrVO.getMbrLvl().equals("001-04")) {
			if (searchVal.equals("ntTtl")) {
				ntVO.setNtTtl(keyword);
			}
			else if (searchVal.equals("sndrId")) {
				ntVO.setSndrId(keyword);
			}
			
			ntVO.setRcvrId(mbrVO.getMbrId());
			List<NtVO> myNtList = ntService.readAllMyNt(ntVO);
			model.addAttribute("myNtList", myNtList);
			model.addAttribute("ntVO", ntVO);
			model.addAttribute("searchVal", searchVal);
			model.addAttribute("keyword", keyword);
			
			return "nt/ntlist";
		}
		// 회원 계정이 아닌 경우, list로 돌려보내 권한에 맞는 페이지로 이동시킵니다.
		return "redirect:/nt/list";
	}
	
	/**
	 * 회원 계정의 경우, 자기가 받은 쪽지를 상세 조회할 수 있습니다.
	 * @param mbrVO 현재 로그인 계정 정보
	 * @param ntId 조회할 쪽지의 Id
	 * @param model
	 * @return 선택한 쪽지 상세 정보 조회 페이지
	 */
	@GetMapping("/nt/ntdetail/{ntId}")
	public String viewNtDetailPage(@SessionAttribute("__MBR__") MbrVO mbrVO,
									   @PathVariable String ntId,
									   Model model) {
		
		if (mbrVO.getMbrLvl().equals("001-04")) {
			ntService.updateNtRdDtByNtId(ntId);
			NtVO nt = ntService.readOneNtByNtId(ntId);
			
			// 이미 삭제된 쪽지 URL을 직접 입력하여 강제로 들어가려 할 경우, list 화면으로 돌려보냅니다.
			if (nt.getDelYn().equals("Y")) {
				return "redirect:/nt/list";
			}
			model.addAttribute("nt", nt);
			
			return "nt/ntdetail";
		}
		// 회원 계정이 아닌 경우, list로 돌려보내 권한에 맞는 페이지로 이동시킵니다.
		return "redirect:/nt/list";
	}
	
	

}
