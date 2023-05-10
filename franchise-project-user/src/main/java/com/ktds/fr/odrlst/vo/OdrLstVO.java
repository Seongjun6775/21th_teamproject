package com.ktds.fr.odrlst.vo;

import java.util.List;

import com.ktds.fr.cmmncd.vo.CmmnCdVO;
import com.ktds.fr.common.vo.AbstractVO;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.odrdtl.vo.OdrDtlVO;
import com.ktds.fr.str.vo.StrVO;

public class OdrLstVO extends AbstractVO{
	/**
	 * 장바구니 ID
	 */
	private String odrLstId;
	/**
	 * 회원 ID
	 */
	private String mbrId;
	/**
	 * 주문 처리 여부
	 */
	private String odrLstOdrPrcs;
	/**
	 * 주문 등록일
	 */
	private String odrLstRgstDt;
	/**
	 * 주문 등록자 (주문을 받은 직원 ID?)
	 */
	private String odrLstRgstr;
	/**
	 * 주문 수정일
	 */
	private String mdfyDt;
	/**
	 * 주문 수정자 (수정을 확인한 직원 ID?)
	 */
	private String mdfyr;
	/**
	 * 사용 여부
	 */
	private String useYn;
	/**
	 * 삭제 여부
	 */
	private String delYn;
	/**
	 * 주문한 매장 ID
	 */
	private String strId;
	/**
	 * 주문한 매장의 정보
	 */
	private StrVO strVO;
	/**
	 * 상태변경 할 주문서 목록
	 */
	private List<String> odrLstIdList;
	/**
	 * 주문서 안의 물품들 정보
	 */
	private List<OdrDtlVO> odrDtlList;
	
	
	private CmmnCdVO cmmnCdVO;
	private MbrVO mbrVO;
	private MbrVO mdfyrMbrVO;
	
	
	/**
	 * 통계 검색용
	 */
	private String oneDay;
	private String monthly;
	private String startDt;
	private String endDt;
	
	
	

	public String getOdrLstId() {
		return odrLstId;
	}

	public void setOdrLstId(String odrLstId) {
		this.odrLstId = odrLstId;
	}

	public String getMbrId() {
		return mbrId;
	}

	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}

	public String getOdrLstOdrPrcs() {
		return odrLstOdrPrcs;
	}

	public void setOdrLstOdrPrcs(String odrLstOdrPrcs) {
		this.odrLstOdrPrcs = odrLstOdrPrcs;
	}

	public String getOdrLstRgstDt() {
		return odrLstRgstDt;
	}

	public void setOdrLstRgstDt(String odrLstRgstDt) {
		this.odrLstRgstDt = odrLstRgstDt;
	}

	public String getOdrLstRgstr() {
		return odrLstRgstr;
	}

	public void setOdrLstRgstr(String odrLstRgstr) {
		this.odrLstRgstr = odrLstRgstr;
	}

	public String getMdfyDt() {
		return mdfyDt;
	}

	public void setMdfyDt(String mdfyDt) {
		this.mdfyDt = mdfyDt;
	}

	public String getMdfyr() {
		return mdfyr;
	}

	public void setMdfyr(String mdfyr) {
		this.mdfyr = mdfyr;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getDelYn() {
		return delYn;
	}

	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	
	public String getStrId() {
		return strId;
	}

	public void setStrId(String strId) {
		this.strId = strId;
	}

	public StrVO getStrVO() {
		return strVO;
	}

	public void setStrVO(StrVO strVO) {
		this.strVO = strVO;
	}

	public List<String> getOdrLstIdList() {
		return odrLstIdList;
	}

	public void setOdrlstIdList(List<String> odrLstIdList) {
		this.odrLstIdList = odrLstIdList;
	}

	public List<OdrDtlVO> getOdrDtlList() {
		return odrDtlList;
	}

	public void setOdrDtlList(List<OdrDtlVO> odrDtlList) {
		this.odrDtlList = odrDtlList;
	}

	
	
	
	public CmmnCdVO getCmmnCdVO() {
		return cmmnCdVO;
	}

	public void setCmmnCdVO(CmmnCdVO cmmnCdVO) {
		this.cmmnCdVO = cmmnCdVO;
	}

	public MbrVO getMbrVO() {
		return mbrVO;
	}

	public void setMbrVO(MbrVO mbrVO) {
		this.mbrVO = mbrVO;
	}

	public MbrVO getMdfyrMbrVO() {
		return mdfyrMbrVO;
	}

	public void setMdfyrMbrVO(MbrVO mdfyrMbrVO) {
		this.mdfyrMbrVO = mdfyrMbrVO;
	}

	public void setOdrLstIdList(List<String> odrLstIdList) {
		this.odrLstIdList = odrLstIdList;
	}

	
	
	
	public String getMonthly() {
		return monthly;
	}

	public void setMonthly(String monthly) {
		this.monthly = monthly;
	}

	public String getOneDay() {
		return oneDay;
	}

	public void setOneDay(String oneDay) {
		this.oneDay = oneDay;
	}

	public String getStartDt() {
		return startDt;
	}

	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}

	public String getEndDt() {
		return endDt;
	}

	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	
	
	
}
