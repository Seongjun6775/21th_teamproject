package com.ktds.fr.odrdtl.vo;

import com.ktds.fr.common.vo.AbstractVO;
import com.ktds.fr.evnt.vo.EvntVO;
import com.ktds.fr.evntprdt.vo.EvntPrdtVO;
import com.ktds.fr.mbr.vo.MbrVO;
import com.ktds.fr.odrlst.vo.OdrLstVO;
import com.ktds.fr.prdt.vo.PrdtVO;
import com.ktds.fr.str.vo.StrVO;

public class OdrDtlVO extends AbstractVO{
	
	/**
	 * 주문상세 ID
	 */
	private String odrDtlId;
	/**
	 * 주문서 ID
	 */
	private String odrLstId;
	/**
	 * 주문한 상품 ID
	 */
	private String odrDtlPrdtId;
	/**
	 * 주문한 상품 갯수
	 */
	private int odrDtlPrdtCnt;
	/**
	 * 주문한 매장 ID
	 */
	private String odrDtlStrId;
	/**
	 * 사용 여부
	 */
	private String useYn;
	/**
	 * 삭제 여부
	 */
	private String delYn;
	/**
	 * 주문한 회원 ID
	 */
	private String mbrId;
	/**
	 * 주문시 단가
	 */
	private int odrDtlPrc;
	/**
	 * 주문한 상품의 정보
	 */
	private PrdtVO prdtVO;
	/**
	 * 주문한 매장의 정보
	 */
	private StrVO strVO;
	/**
	 * 주문 상품의 이벤트 정보
	 */
	private EvntVO evntVO;
	private EvntPrdtVO evntPrdtVO;
	
	private OdrLstVO odrLstVO;

	
	private MbrVO mbrVO;
	
	/**
	 * 통계 검색용
	 */
	private String oneDay;
	private String monthly;
	private String yearly;
	private String startDt;
	private String endDt;
	
	private String groupBy;
	private String orderBy;
	
	private long sumPrc;
	private int sumCnt;
	
	
	
	
	public String getOdrDtlId() {
		return odrDtlId;
	}

	public void setOdrDtlId(String odrDtlId) {
		this.odrDtlId = odrDtlId;
	}

	public String getOdrLstId() {
		return odrLstId;
	}

	public void setOdrLstId(String odrLstId) {
		this.odrLstId = odrLstId;
	}

	public String getOdrDtlPrdtId() {
		return odrDtlPrdtId;
	}

	public void setOdrDtlPrdtId(String odrDtlPrdtId) {
		this.odrDtlPrdtId = odrDtlPrdtId;
	}

	public int getOdrDtlPrdtCnt() {
		return odrDtlPrdtCnt;
	}

	public void setOdrDtlPrdtCnt(int odrDtlPrdtCnt) {
		this.odrDtlPrdtCnt = odrDtlPrdtCnt;
	}

	public String getOdrDtlStrId() {
		return odrDtlStrId;
	}

	public void setOdrDtlStrId(String odrDtlStrId) {
		this.odrDtlStrId = odrDtlStrId;
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

	public String getMbrId() {
		return mbrId;
	}

	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}
	
	public int getOdrDtlPrc() {
		return odrDtlPrc;
	}

	public void setOdrDtlPrc(int odrDtlPrc) {
		this.odrDtlPrc = odrDtlPrc;
	}

	public PrdtVO getPrdtVO() {
		return prdtVO;
	}

	public void setPrdtVO(PrdtVO prdtVO) {
		this.prdtVO = prdtVO;
	}

	public StrVO getStrVO() {
		return strVO;
	}

	public void setStrVO(StrVO strVO) {
		this.strVO = strVO;
	}

	public EvntVO getEvntVO() {
		return evntVO;
	}

	public void setEvntVO(EvntVO evntVO) {
		this.evntVO = evntVO;
	}

	public EvntPrdtVO getEvntPrdtVO() {
		return evntPrdtVO;
	}

	public void setEvntPrdtVO(EvntPrdtVO evntPrdtVO) {
		this.evntPrdtVO = evntPrdtVO;
	}
	
	public OdrLstVO getOdrLstVO() {
		return odrLstVO;
	}

	public void setOdrLstVO(OdrLstVO odrLstVO) {
		this.odrLstVO = odrLstVO;
	}

	

	public MbrVO getMbrVO() {
		return mbrVO;
	}

	public void setMbrVO(MbrVO mbrVO) {
		this.mbrVO = mbrVO;
	}

	public String getOneDay() {
		return oneDay;
	}

	public void setOneDay(String oneDay) {
		this.oneDay = oneDay;
	}

	public String getMonthly() {
		return monthly;
	}

	public void setMonthly(String monthly) {
		this.monthly = monthly;
	}

	public String getYearly() {
		return yearly;
	}

	public void setYearly(String yearly) {
		this.yearly = yearly;
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

	
	public String getGroupBy() {
		return groupBy;
	}

	public void setGroupBy(String groupBy) {
		this.groupBy = groupBy;
	}

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	public long getSumPrc() {
		return sumPrc;
	}

	public void setSumPrc(long sumPrc) {
		this.sumPrc = sumPrc;
	}

	public int getSumCnt() {
		return sumCnt;
	}

	public void setSumCnt(int sumCnt) {
		this.sumCnt = sumCnt;
	}

	

}
