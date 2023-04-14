package com.ktds.fr.hr.vo;

import com.ktds.fr.common.vo.AbstractVO;

public class HrVO extends AbstractVO {
	
	/**
	 * 채용 지원 ID
	 */
	private String hrId;
	/**
	 * 회원 ID (채용 지원자 ID)
	 */
	private String mbrId;
	/**
	 * 지원서 파일 ID
	 */
	private String hrFlId;
	/**
	 * 채용 지원 등록일
	 */
	private String hrRgstDt;
	/**
	 * 최종 수정일
	 */
	private String mdfyDt;
	/**
	 * 채용 승인 여부
	 */
	private String hrAprYn;
	/**
	 * 채용 승인 일자
	 */
	private String hrAprDt;
	/**
	 * 지원 상태 ('접수'(기본값) / '심사중' / '심사완료')
	 */
	private String hrStat;
	/**
	 * 사용 여부
	 */
	private String useYn;
	/**
	 * 삭제 여부
	 */
	private String delYn;

	public String getHrId() {
		return hrId;
	}

	public void setHrId(String hrId) {
		this.hrId = hrId;
	}

	public String getMbrId() {
		return mbrId;
	}

	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}

	public String getHrFlId() {
		return hrFlId;
	}

	public void setHrFlId(String hrFlId) {
		this.hrFlId = hrFlId;
	}

	public String getHrRgstDt() {
		return hrRgstDt;
	}

	public void setHrRgstDt(String hrRgstDt) {
		this.hrRgstDt = hrRgstDt;
	}

	public String getMdfyDt() {
		return mdfyDt;
	}

	public void setMdfyDt(String mdfyDt) {
		this.mdfyDt = mdfyDt;
	}

	public String getHrAprYn() {
		return hrAprYn;
	}

	public void setHrAprYn(String hrAprYn) {
		this.hrAprYn = hrAprYn;
	}

	public String getHrAprDt() {
		return hrAprDt;
	}

	public void setHrAprDt(String hrAprDt) {
		this.hrAprDt = hrAprDt;
	}

	public String getHrStat() {
		return hrStat;
	}

	public void setHrStat(String hrStat) {
		this.hrStat = hrStat;
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

}
