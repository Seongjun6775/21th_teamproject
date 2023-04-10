package com.ktds.fr.rv.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.rv.vo.RvVO;

@Repository
public class RvDAOImpl extends SqlSessionDaoSupport implements RvDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public int createNewRv(RvVO rvVO) {
		return getSqlSession().insert("Rv.createNewRv", rvVO);
	}

	@Override
	public List<RvVO> readAllRvList(RvVO rvVO) {
		return getSqlSession().selectList("Rv.readAllRvList", rvVO);
	}

	@Override
	public RvVO readOneRvVO(RvVO rvVO) {
		return getSqlSession().selectOne("Rv.readOneRvVO", rvVO);
	}

	@Override
	public List<RvVO> readAllRvByStrId(String strId) {
		return getSqlSession().selectList("Rv.readAllRvByStrId", strId);
	}

	@Override
	public RvVO readOneRvVOByStrId(String strId) {
		return getSqlSession().selectOne("Rv.readOneRvVOByStrId", strId);
	}

	@Override
	public int deleteAllRvList(List<String> RvList) {
		return getSqlSession().update("Rv.deleteAllRvList", RvList);
	}

	@Override
	public int deleteOneRvByRvId(String RvId) {
		return getSqlSession().update("Rv.deleteOneRvByRvId", RvId);
	}
			
}
