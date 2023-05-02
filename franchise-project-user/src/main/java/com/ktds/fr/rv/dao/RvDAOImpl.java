package com.ktds.fr.rv.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.rv.vo.RvVO;
import com.ktds.fr.rv.vo.SearchRvVO;

@Repository
public class RvDAOImpl extends SqlSessionDaoSupport implements RvDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	// 1-1.(제품 이력확인 후)리뷰 등록 == 이용자
	@Override
	public int createNewRv(RvVO rvVO) {
		return getSqlSession().insert("Rv.createNewRv", rvVO);
	}
	// 1-2.이용자가 쓴 리뷰 개수 조회(리뷰 쓴 적이 없어야 리뷰 등록 가능)
	@Override
	public int readCountRvByRvId(RvVO rvVO) {
		return getSqlSession().selectOne("Rv.readCountRvByRvId", rvVO);
	}	
	// 1-3. 주문서 ID를 토대로 수정일로부터 7일 이내에만 리뷰를 등록할 수 있도록 함	
	@Override
	public int createNewRvWithin7days(RvVO rvVO) {
		return getSqlSession().selectOne("Rv.createNewRvWithin7days", rvVO);
	}
	
			
	// 2-1.모든 매장의 리뷰 목록 조회 == 상위관리자, 이용자
	@Override
	public List<RvVO> readAllRvListForTopManager(SearchRvVO searchRvVO) {
		return getSqlSession().selectList("Rv.readAllRvListForTopManager", searchRvVO);
	}
	// 2-2.모든 매장의 리뷰 상세 조회 == 상위관리자, 이용자
	@Override
	public RvVO readOneRvVOForTopManagerByRvId(String rvId) {
		return getSqlSession().selectOne("Rv.readOneRvVOForTopManagerByRvId", rvId);
	}
	
	
	// 3-1.모든 매장의 리뷰 삭제 == 상위관리자
	@Override
	public int deleteAllRvVOByRvIdList(List<String> rvIdList) {
		return getSqlSession().update("Rv.deleteAllRvVOByRvIdList", rvIdList);
	}
	// 3-2.자기가 쓴 리뷰 삭제 == 이용자
	@Override
	public int deleteOneRvVOByRvId(String rvId) {
		return getSqlSession().update("Rv.deleteOneRvVOByRvId", rvId);
	}

	
}
