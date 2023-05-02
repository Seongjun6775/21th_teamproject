package com.ktds.fr.hr.service;

import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.ktds.fr.chsrl.dao.ChSrlDAO;
import com.ktds.fr.common.api.exceptions.ApiException;
import com.ktds.fr.common.api.vo.ApiStatus;
import com.ktds.fr.common.util.ObjectUtils;
import com.ktds.fr.hr.dao.HrDAO;
import com.ktds.fr.hr.vo.HrVO;
import com.ktds.fr.mbr.dao.MbrDAO;

@Service
public class HrServiceImpl implements HrService {

	@Autowired
	private HrDAO hrDAO;
	
	@Autowired
	private MbrDAO mbrDAO;
	
	@Autowired
	private ChSrlDAO chSrlDAO;
	
	// 채용 지원서 작성 시 업로드된 파일이 저장될 경로입니다.
	@Value("${upload.hr.path:/franchise-prj/files/hr/}")
	private String filePath;

	/**
	 *  최고관리자 - 채용 게시판의 모든 글을 읽어옵니다.
	 */
	@Override
	public List<HrVO> readAllHr(HrVO hrVO) {
		// 검색 시작일을 받아옵니다. 시작일은 현재 일자 -1달입니다.
		if (hrVO.getStartDt() == null || hrVO.getStartDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String strMonth = month < 10 ? "0" + month : month + "";
			String strDay = day < 10 ? "0" + day : day + "";
			String startDt = year + "-" + strMonth + "-" + strDay;
			hrVO.setStartDt(startDt);
		}
		
		// 검색 종료일을 받아옵니다. 종료일은 현재 일자입니다.
		if (hrVO.getEndDt() == null || hrVO.getEndDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String strMonth = month < 10 ? "0" + month : month + "";
			String strDay = day < 10 ? "0" + day : day + "";
			String endDt = year + "-" + strMonth + "-" + strDay;
			hrVO.setEndDt(endDt);
		}
		
		return hrDAO.readAllHr(hrVO);
	}
	
	/**
	 * 회원 - 채용 게시판의 공지와, 내가 쓴 글 내역들을 불러옵니다.
	 */
	@Override
	public List<HrVO> readAllMyHr(HrVO hrVO) {
		return hrDAO.readAllMyHr(hrVO);
	}
	
	/**
	 *  채용 게시판에서 글 하나를 상세조회합니다.
	 */
	@Override
	public HrVO readOneHrByHrId(String hrId) {
		return hrDAO.readOneHrByHrId(hrId);
	}

	/**
	 *  채용 게시판에서 글을 작성합니다.
	 */
	@Override
	public boolean createNewHr(HrVO hrVO, MultipartFile uploadFile) {
		
		if (uploadFile != null && !uploadFile.isEmpty()) {
			// 파일 경로가 있는지 확인하고, 없다면 생성합니다.
			File dir = new File(filePath);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			
			// hrVO에 업로드된 파일의 정보들을 저장합니다.
			hrVO.setOrgnFlNm(uploadFile.getOriginalFilename());
			hrVO.setFlSize(uploadFile.getSize());
			hrVO.setFlExt(StringUtils.getFilenameExtension(uploadFile.getOriginalFilename()));
			
			// hrVO에 저장된 파일이 정해진 파일 형식이 아닐 경우, 업로드를 취소합니다.
			if (!hrVO.getFlExt().equals("hwp")) {
				throw new ApiException("500", "지정된 파일 형식이 아닙니다.");
			}
			
			// 파일 이름을 암호화하기 위해 임시 생성하는 파일입니다.
			String uuidFileName = UUID.randomUUID().toString();
			File hrFile = new File(dir, uuidFileName);
			
			// 임시 생성된 파일에 업로드된 파일을 이동시킵니다.
			try {
				uploadFile.transferTo(hrFile);
			} catch (IllegalStateException | IOException e) {
				throw new ApiException("500", "파일 업로드에 실패했습니다.");
			}
			
			// hrVO에 암호화된 파일의 이름을 저장합니다.
			hrVO.setUuidFlNm(uuidFileName);
		}
		
		return hrDAO.createNewHr(hrVO) > 0;
	}
	
	/**
	 * 채용 게시판에서 글 하나를 수정합니다.
	 */
	@Override
	public boolean updateOneHrByHrId(HrVO hrVO, MultipartFile uploadFile) {
		
		// 수정할 게시글의 원래 정보를 받아옵니다
		HrVO originalData = hrDAO.readOneHrByHrId(hrVO.getHrId());
		
		// 원래 정보를 비교하기 위해 따로 저장해 둡니다.
		// 객체 복사 -> 강사님께서 추가해 주셨습니다. originalData를 ObjectUtils을 통해 JSON 형식으로 변경한 후, HrVO 타입으로 복사합니다.
		HrVO newData = ObjectUtils.deepCopy(originalData, HrVO.class);
		
		// 수정할 값들을 비교하여, 만약 달라진 값이 있다면 true로 바꿔 수정을 실행합니다.
		boolean updateYn = false;
		// 확인할 값은 총 3가지 - 글 제목, 글 본문, 지원 직군입니다.
		if (!originalData.getHrTtl().equals(hrVO.getHrTtl())) {
			newData.setHrTtl(hrVO.getHrTtl());
			updateYn = true;
		}
		if (!originalData.getHrCntnt().equals(hrVO.getHrCntnt())) {
			newData.setHrCntnt(hrVO.getHrCntnt());
			updateYn = true;
		}
		// 지원 직군 조회는 공지가 아닌 게시글에서만 진행합니다.
		if (originalData.getNtcYn().equals("N")) {
			if (!originalData.getHrLvl().equals(hrVO.getHrLvl())) {
				newData.setHrLvl(hrVO.getHrLvl());
				updateYn = true;
			}
		}
		
		// 이전에 업로드 되어 있던 파일이 있는지 확인합니다.
		boolean isExisted = (originalData.getOrgnFlNm() != null && originalData.getOrgnFlNm().trim().length() != 0);
		// 새롭게 업로드 된 파일이 있는지 확인합니다.
		boolean isUploaded = (uploadFile != null && !uploadFile.isEmpty());
		
		// 만약 수정을 진행하며 업로드 된 파일이 있다면, 다음을 수행합니다.
		if (isUploaded) {
			// 파일 경로가 있는지 확인하고, 없다면 생성합니다.
			File dir = new File(filePath);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			
			String orgnFilename = uploadFile.getOriginalFilename();
			String fileExt = StringUtils.getFilenameExtension(uploadFile.getOriginalFilename()); 
			
			boolean differentYn = false;
			updateYn = true;
			
			// 업로드된 파일과 기존의 파일이 같은지 비교합니다.
			// 비교할 값은 총 3가지 - 파일 이름, 파일 크기, 파일 확장자입니다.
			if (!orgnFilename.equals(originalData.getOrgnFlNm())) {
				newData.setOrgnFlNm(orgnFilename);
				differentYn = true;
			}
			if (originalData.getFlSize() != uploadFile.getSize()) {
				newData.setFlSize(uploadFile.getSize());
				differentYn = true;
			}
			if (!fileExt.equals(originalData.getFlExt())) {
				newData.setFlExt(fileExt);
				differentYn = true;
			}
			
			// hrVO에 저장된 파일이 정해진 파일 형식이 아닐 경우, 업로드를 취소합니다.
			if (!StringUtils.getFilenameExtension(uploadFile.getOriginalFilename()).equals("hwp")) {
				throw new ApiException("500", "지정된 파일 형식이 아닙니다.");
			}
			
			// 파일 이름을 암호화하기 위해 임시 생성하는 파일입니다.
			String uuidFileName = UUID.randomUUID().toString();
			File hrFile = new File(dir, uuidFileName);
			
			// 임시 생성된 파일에 업로드된 파일을 이동시킵니다.
			try {
				uploadFile.transferTo(hrFile);
			} catch (IllegalStateException | IOException e) {
				throw new ApiException("500", "파일 업로드에 실패했습니다.");
			}
			// newData에 암호화된 파일의 이름을 저장합니다.
			newData.setUuidFlNm(uuidFileName);
			
			// 만약 기존에 파일이 업로드되어 있었고, 기존과 다른 파일이 새로 업로드 되었는지를 판단합니다.
			if (differentYn) {
				// 기존의 파일을 삭제합니다.
				File file = new File(filePath + File.separator + originalData.getUuidFlNm());
				file.delete();
			}
		}
		// 만약 수정 중 업로드 된 파일이 없다면, 다음을 수행합니다.
		else {
			// 기존에 업로드한 파일이 존재했고, 그 파일을 삭제하려 했는지 확인합니다.
			if (isExisted && (hrVO.getOrgnFlNm() == null || hrVO.getOrgnFlNm().trim().length() == 0)) {
				// DB에 저장될 파일 정보를 비워줍니다.
				newData.setOrgnFlNm(hrVO.getOrgnFlNm());
				newData.setUuidFlNm(hrVO.getUuidFlNm());
				newData.setFlSize(hrVO.getFlSize());
				newData.setFlExt(hrVO.getFlExt());
				// 기존의 파일을 삭제합니다.
				File file = new File(filePath + File.separator + originalData.getUuidFlNm());
				file.delete();
				// 파일이 사라져 변경점이 생겼으므로, 수정을 진행합니다.
				updateYn = true;
			}
		}
		// 변경점이 있다면 수정을 진행합니다.
		if (updateYn) {
			return hrDAO.updateOneHrByHrId(newData) > 0;
		}
		// 변경점이 없다면 ApiException을 반환합니다.
		else {
			throw new ApiException("400", "수정된 정보가 없습니다.");
		}
	}

	/**
	 *  글 하나를 삭제 처리합니다(= delYn의 값을 Y로 변경합니다).
	 */
	@Override
	public boolean deleteOneHrByHrId(String hrId) {
		return hrDAO.deleteOneHrByHrId(hrId) > 0;
	}
	
	/**
	 *  최고관리자가 글을 확인했을 시, 글의 상태를 '접수'에서 '심사중'으로 변경시킵니다.
	 */
	@Override
	public boolean updateHrStatByHrId(String hrId) {
		return hrDAO.updateHrStatByHrId(hrId) > 0;
	}
	
	/**
	 *  최고관리자 - 하나의 채용 지원에 대해서 채용 여부를 변경합니다(Y, N).
	 */
	@Override
	public boolean updateHrAprByHrId(HrVO hrVO) {
		
		boolean updateResult = hrDAO.updateHrAprByHrId(hrVO) > 0;
		if(!updateResult) {
			throw new ApiException(ApiStatus.FAIL, "오류가 발생하여 실패했습니다.");
		}
		mbrDAO.updateOneMbrLvlAndStrId(hrVO.getMbrVO());
		hrVO.getMbrVO().setOriginMbrLvl("001-04");
		chSrlDAO.createOneChHist(hrVO.getMbrVO());
		return updateResult;
	}
	
	/**
	 *  이미 접수 또는 심사중인 채용 지원이 있는지를 확인합니다.
	 */
	@Override
	public boolean checkCreateYn(String mbrId) {
		// mbrId를 기준으로 hrStat이 '접수', '심사중'인 글의 갯수를 세어서 가져옵니다.
		int check = hrDAO.checkCreateYn(mbrId);
		
		// 만약 접수되었거나 심사중인 글이 존재하지 않는다면, 글을 작성할 수 있게 합니다.
		if (check == 0) {
			return true;
		}
		return false;
	}
	
}
