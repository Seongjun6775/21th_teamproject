package com.ktds.fr.evnt.web;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.fr.common.util.DownloadUtil;
import com.ktds.fr.evnt.service.EvntService;
import com.ktds.fr.evnt.vo.EvntVO;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.prdt.web.PrdtController;

@Controller
public class EvntController {

	private static final Logger logger = LoggerFactory.getLogger(PrdtController.class);

	@Autowired
	private EvntService evntService;

	@Value("${upload.evnt.path:/franchise-prj/files/evnt/}")
	private String profilePath;

	// 1. 이벤트 등록  ▶▶최상위관리자 001-01
	@GetMapping("/evnt/create")
	public String createEvntPage(Model model, EvntVO evntVO) {
		model.addAttribute("evntVO", evntVO);
		return "evnt/create";
	}

	// 2. 이벤트 전체목록 조회 ▶▶최상위관리자 ▷▷중간관리자 001-01, 001-02
	@RequestMapping("/evnt/list")
	public String viewEvntListPage(Model model, EvntVO evntVO, HttpServletRequest req, @SessionAttribute("__MBR__") MbrVO mbrVO) {

//		//확인용
//		System.out.println("evntVO.getEvntId : " + evntVO.getEvntId());
//		System.out.println("evntVO.getEvntTtl : " + evntVO.getEvntTtl());
//		System.out.println("evntVO.getEvntCntnt : " + evntVO.getEvntCntnt());
//		System.out.println("evntVO.getEvntStrtDt : " + evntVO.getEvntStrtDt());
//		System.out.println("evntVO.getEvntEndDt : " + evntVO.getEvntEndDt());
//		System.out.println("evntVO.getUseYn : " + evntVO.getUseYn());

		// 기본조건으로 20개씩 조회
//		evntVO.setViewCnt(20);
		// 기본조건으로 10페이지씩 조회
//		evntVO.setPageCnt(10);
//		evntVO.setPageNo(nullToZero(req.getParameter("pageNo")));

		System.out.println("evntVO.getViewCnt() : " + evntVO.getViewCnt());
		System.out.println("evntVO.getPageCnt() : " + evntVO.getPageCnt());
		System.out.println("evntVO.getPageNo() : " + evntVO.getPageNo());
		
		List<EvntVO> evntList = evntService.readAllEvnt(evntVO);

		// 리스트 반환
		model.addAttribute("evntList", evntList);
		model.addAttribute("mbrVO", mbrVO);

		// 조회조건 기존 데이터로 세팅
		model.addAttribute("evntId", evntVO.getEvntId());
		model.addAttribute("evntTtl", evntVO.getEvntTtl());
		model.addAttribute("evntCntnt", evntVO.getEvntCntnt());
		model.addAttribute("evntStrtDt", evntVO.getEvntStrtDt());
		model.addAttribute("evntEndDt", evntVO.getEvntEndDt());
		model.addAttribute("useYn", evntVO.getUseYn());

//		model.addAttribute("evntVO", evntVO);

//		if (evntList.size() == 0) {
//			model.addAttribute("viewCnt", 20);
//			model.addAttribute("pageCnt", 1);
//			model.addAttribute("pageNo", 0);
//			model.addAttribute("totalCount", 0);
//			model.addAttribute("lastPage", 1);
//			model.addAttribute("lastGroup", 1);
//		} else {
//			model.addAttribute("viewCnt", evntVO.getViewCnt());
//			model.addAttribute("pageCnt", evntVO.getPageCnt());
//			model.addAttribute("pageNo", evntVO.getPageNo());
//			model.addAttribute("totalCount", evntList.get(0).getTotalCount());
//			model.addAttribute("lastPage", evntList.get(0).getLastPage());
//			model.addAttribute("lastGroup", evntList.get(0).getLastGroup());
//		}

		return "/evnt/list";
	}

	// 3. 이벤트 상세조회 (detail page)  ▶▶최상위관리자 ▷▷중간관리자 001-01, 001-02
	@GetMapping("/evnt/detail/{evntId}")
	public String postEvntUpdate(Model model, @PathVariable String evntId, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		EvntVO evntVO = evntService.readOneEvnt(evntId);

		System.out.println("/evnt/detail/{evntId} : " + evntId);
		System.out.println("evntVO.getEvntId : " + evntVO.getEvntId());
		System.out.println("evntVO.getEvntTtl : " + evntVO.getEvntTtl());
		System.out.println("evntVO.getEvntCntnt : " + evntVO.getEvntCntnt());
		System.out.println("evntVO.getEvntStrtDt : " + evntVO.getEvntStrtDt());
		System.out.println("evntVO.getEvntEndDt : " + evntVO.getEvntEndDt());
		System.out.println("evntVO.getOrgnFlNm : " + evntVO.getOrgnFlNm());
		System.out.println("evntVO.getUuidFlNm : " + evntVO.getUuidFlNm());
		System.out.println("evntVO.getFlSize : " + evntVO.getFlSize());
		System.out.println("evntVO.getFlExt : " + evntVO.getFlExt());
		System.out.println("evntVO.getUseYn : " + evntVO.getUseYn());
		System.out.println("evntVO.getDelYn : " + evntVO.getDelYn());

		model.addAttribute("evntVO", evntVO);
		model.addAttribute("mbrVO", mbrVO);
		return "evnt/detail";
	}

	
	// 4. 이벤트 등록 내용 수정 ▶▶최상위관리자 001-01
	@GetMapping("/evnt/update/{evntId}")
	public String postEvntUpdatepage(Model model, @PathVariable String evntId) {
		EvntVO evntVO = evntService.readOneEvnt(evntId);
//		evntVO.setEvntId(evntId);

		System.out.println("/evnt/update/{evntId} : " + evntId);
		System.out.println("evntVO.getEvntId : " + evntVO.getEvntId());
		System.out.println("evntVO.getEvntTtl : " + evntVO.getEvntTtl());
		System.out.println("evntVO.getEvntCntnt : " + evntVO.getEvntCntnt());
		System.out.println("evntVO.getEvntStrtDt : " + evntVO.getEvntStrtDt());
		System.out.println("evntVO.getEvntEndDt : " + evntVO.getEvntEndDt());
		System.out.println("evntVO.getOrgnFlNm : " + evntVO.getOrgnFlNm());
		System.out.println("evntVO.getUuidFlNm : " + evntVO.getUuidFlNm());
		System.out.println("evntVO.getFlSize : " + evntVO.getFlSize());
		System.out.println("evntVO.getFlExt : " + evntVO.getFlExt());
		System.out.println("evntVO.getUseYn : " + evntVO.getUseYn());
		System.out.println("evntVO.getDelYn : " + evntVO.getDelYn());

		model.addAttribute("evntVO", evntVO);

		return "evnt/update";

	}

	// 6. 이용자 페이지(첫화면 -> 현재진행중인 이벤트) ★☆소비자 001-04
	@RequestMapping("/evnt/ongoingList")
	public String viewEvntOngoingListPage(Model model, EvntVO evntVO, HttpServletRequest req) {

		List<EvntVO> evntList = evntService.readAllOngoingEvnt(evntVO);

		// 리스트 반환
		model.addAttribute("evntList", evntList);

		// 조회조건 기존 데이터로 세팅
		model.addAttribute("evntId", evntVO.getEvntId());
		model.addAttribute("evntTtl", evntVO.getEvntTtl());
		model.addAttribute("evntCntnt", evntVO.getEvntCntnt());
		model.addAttribute("evntStrtDt", evntVO.getEvntStrtDt());
		model.addAttribute("evntEndDt", evntVO.getEvntEndDt());
		model.addAttribute("useYn", evntVO.getUseYn());

//		model.addAttribute("evntVO", evntVO);

		if (evntList.size() == 0) {
			model.addAttribute("viewCnt", 20);
			model.addAttribute("pageCnt", 1);
			model.addAttribute("pageNo", 0);
			model.addAttribute("totalCount", 0);
			model.addAttribute("lastPage", 1);
			model.addAttribute("lastGroup", 1);
		} else {
			model.addAttribute("viewCnt", evntVO.getViewCnt());
			model.addAttribute("pageCnt", evntVO.getPageCnt());
			model.addAttribute("pageNo", evntVO.getPageNo());
			model.addAttribute("totalCount", evntList.get(0).getTotalCount());
			model.addAttribute("lastPage", evntList.get(0).getLastPage());
			model.addAttribute("lastGroup", evntList.get(0).getLastGroup());
		}

		return "evnt/ongoingList";
	}

	
	// 7. 이용자 페이지(지난이벤트) ★☆소비자 001-04
	@RequestMapping("/evnt/pastEvntList")
	public String viewEvntPastListPage(Model model, EvntVO evntVO, HttpServletRequest req) {

		List<EvntVO> evntList = evntService.readAllPastEvnt(evntVO);

		// 리스트 반환
		model.addAttribute("evntList", evntList);

		// 조회조건 기존 데이터로 세팅
		model.addAttribute("evntId", evntVO.getEvntId());
		model.addAttribute("evntTtl", evntVO.getEvntTtl());
		model.addAttribute("evntCntnt", evntVO.getEvntCntnt());
		model.addAttribute("evntStrtDt", evntVO.getEvntStrtDt());
		model.addAttribute("evntEndDt", evntVO.getEvntEndDt());
		model.addAttribute("useYn", evntVO.getUseYn());

//		model.addAttribute("evntVO", evntVO);

		if (evntList.size() == 0) {
			model.addAttribute("viewCnt", 20);
			model.addAttribute("pageCnt", 1);
			model.addAttribute("pageNo", 0);
			model.addAttribute("totalCount", 0);
			model.addAttribute("lastPage", 1);
			model.addAttribute("lastGroup", 1);
		} else {
			model.addAttribute("viewCnt", evntVO.getViewCnt());
			model.addAttribute("pageCnt", evntVO.getPageCnt());
			model.addAttribute("pageNo", evntVO.getPageNo());
			model.addAttribute("totalCount", evntList.get(0).getTotalCount());
			model.addAttribute("lastPage", evntList.get(0).getLastPage());
			model.addAttribute("lastGroup", evntList.get(0).getLastGroup());
		}

		return "evnt/pastEvntList";
	}
	
	
	
	// 8. 이용자 페이지(예정 이벤트) ★☆소비자 001-04
	@RequestMapping("/evnt/planEvntList")
	public String viewEvntPlanListPage(Model model, EvntVO evntVO, HttpServletRequest req) {

		List<EvntVO> evntList = evntService.readAllPlanEvnt(evntVO);

		// 리스트 반환
		model.addAttribute("evntList", evntList);

		// 조회조건 기존 데이터로 세팅
		model.addAttribute("evntId", evntVO.getEvntId());
		model.addAttribute("evntTtl", evntVO.getEvntTtl());
		model.addAttribute("evntCntnt", evntVO.getEvntCntnt());
		model.addAttribute("evntStrtDt", evntVO.getEvntStrtDt());
		model.addAttribute("evntEndDt", evntVO.getEvntEndDt());
		model.addAttribute("useYn", evntVO.getUseYn());

//		model.addAttribute("evntVO", evntVO);

		if (evntList.size() == 0) {
			model.addAttribute("viewCnt", 20);
			model.addAttribute("pageCnt", 1);
			model.addAttribute("pageNo", 0);
			model.addAttribute("totalCount", 0);
			model.addAttribute("lastPage", 1);
			model.addAttribute("lastGroup", 1);
		} else {
			model.addAttribute("viewCnt", evntVO.getViewCnt());
			model.addAttribute("pageCnt", evntVO.getPageCnt());
			model.addAttribute("pageNo", evntVO.getPageNo());
			model.addAttribute("totalCount", evntList.get(0).getTotalCount());
			model.addAttribute("lastPage", evntList.get(0).getLastPage());
			model.addAttribute("lastGroup", evntList.get(0).getLastGroup());
		}

		return "evnt/planEvntList";
	}

	// 이벤트 조회 ▶▶ 이벤트 상세 (detail page)
	@GetMapping("/evnt/detail_customer/{evntId}")
	public String readEvntCustomer(Model model, @PathVariable String evntId, @SessionAttribute("__MBR__") MbrVO mbrVO) {
		EvntVO evntVO = evntService.readOneEvnt(evntId);

		System.out.println("/evnt/detail_customer/{evntId} : " + evntId);
		System.out.println("evntVO.getEvntId : " + evntVO.getEvntId());
		System.out.println("evntVO.getEvntTtl : " + evntVO.getEvntTtl());
		System.out.println("evntVO.getEvntCntnt : " + evntVO.getEvntCntnt());
		System.out.println("evntVO.getEvntStrtDt : " + evntVO.getEvntStrtDt());
		System.out.println("evntVO.getEvntEndDt : " + evntVO.getEvntEndDt());
		System.out.println("evntVO.getOrgnFlNm : " + evntVO.getOrgnFlNm());
		System.out.println("evntVO.getUuidFlNm : " + evntVO.getUuidFlNm());
		System.out.println("evntVO.getFlSize : " + evntVO.getFlSize());
		System.out.println("evntVO.getFlExt : " + evntVO.getFlExt());
		System.out.println("evntVO.getUseYn : " + evntVO.getUseYn());
		System.out.println("evntVO.getDelYn : " + evntVO.getDelYn());

		model.addAttribute("evntVO", evntVO);
		model.addAttribute("mbrVO", mbrVO);
		return "evnt/detail_customer";
	}
	// 5. 사진 다운로드
	@GetMapping("/evnt/img/{filename}")
	public void downloadPosterPctr(@PathVariable String filename, HttpServletRequest request,
			HttpServletResponse response) {
		logger.debug("다운로드 프로필사진의 파일이름 : " + filename);
		File imageFile = new File(profilePath, filename);
		if (!imageFile.exists() || !imageFile.isFile()) {
			logger.debug("파일이 경로에 없어서 기본값으로 호출한다");
			filename = "default_photo.jpg";
		}
		DownloadUtil dnUtil = new DownloadUtil(response, request, profilePath + "/" + filename);
		dnUtil.download(filename);
	}

	/* null 에러 방지 */
	public int nullToZero(Object obj) {
		if (obj == null) {
			return 0;
		}
		return Integer.parseInt((String) obj);
	}
}