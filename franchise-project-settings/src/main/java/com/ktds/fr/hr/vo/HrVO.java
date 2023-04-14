package com.ktds.fr.hr.vo;

public class HrVO {
	
	/**
	 * 채용 ID
	 */
	private String hrId;
	/**
	 * 회원 ID (지원자의 회원 ID)
	 */
	private String mbrId;
	/**
	 * 파일 ID
	 */
	private String hrFlId;
	/**
	 * 수정일
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
	 * 지원서 상태 (기본값 '접수' -> '심사중', '심사완료'도 있음)
	 */
	private String hrStat;
	/**
	 * 사용 여부 (기본값 'N')
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
