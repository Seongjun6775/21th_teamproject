package com.ktds.fr.rv.vo;

import com.ktds.fr.common.vo.AbstractVO;
import com.ktds.fr.mbr.vo.MbrVO;

/**
 * 리뷰(RV)
 * @author User
 *
 */
public class RvVO extends AbstractVO {		
		
	// 리뷰ID
	private String rvId; 
	// 회원 ID
	private String mbrId;
	// 주문 상세 ID
	private String odrDtlId;
	// 제목
	private String rvTtl;	
	// 내용
	private String rvCntnt;	
	// 좋아요/싫어요
	private String rvLkDslk;	
	// 등록일
	private String rvRgstDt;	
	// 수정일
	private String mdfyDt;	
	// 사용유무
	private String useYn;
	// 삭제여부
	private String delYn;	
	
	private MbrVO mbrVO;
	
	public String getRvId() {	
		return rvId;
	}	
	public void setRvId(String rvId) {	
		this.rvId = rvId;
	}	
	public String getMbrId() {	
		return mbrId;
	}	
	public void setMbrId(String mbrId) {	
		this.mbrId = mbrId;
	}	
	public String getOdrDtlId() {	
		return odrDtlId;
	}	
	public void setOdrDtlId(String odrDtlId) {	
		this.odrDtlId = odrDtlId;
	}	
	public String getRvTtl() {	
		return rvTtl;
	}	
	public void setRvTtl(String rvTtl) {	
		this.rvTtl = rvTtl;
	}	
	public String getRvCntnt() {	
		return rvCntnt;
	}	
	public void setRvCntnt(String rvCntnt) {	
		this.rvCntnt = rvCntnt;
	}	
	public String getRvLkDslk() {	
		return rvLkDslk;
	}	
	public void setRvLkDslk(String rvLkDslk) {	
		this.rvLkDslk = rvLkDslk;
	}	
	public String getRvRgstDt() {	
		return rvRgstDt;
	}	
	public void setRvRgstDt(String rvRgstDt) {	
		this.rvRgstDt = rvRgstDt;
	}	
	public String getMdfyDt() {	
		return mdfyDt;
	}	
	public void setMdfyDt(String mdfyDt) {	
		this.mdfyDt = mdfyDt;
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
	public MbrVO getMbrVO() {
		return mbrVO;
	}
	public void setMbrVO(MbrVO mbrVO) {
		this.mbrVO = mbrVO;
	}	
		
}		
