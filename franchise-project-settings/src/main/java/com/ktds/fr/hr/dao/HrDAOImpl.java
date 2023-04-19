package com.ktds.fr.hr.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.hr.vo.HrVO;

@Repository
public class HrDAOImpl extends SqlSessionDaoSupport implements HrDAO {
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public List<HrVO> readAllHr(HrVO hrVO) {
		return getSqlSession().selectList("Hr.readAllHr", hrVO);
	}
	
	@Override
	public List<HrVO> readAllMyHr(HrVO hrVO) {
		return getSqlSession().selectList("Hr.readAllMyHr", hrVO);
	}

	@Override
	public HrVO readOneHrByHrId(String hrId) {
		return getSqlSession().selectOne("Hr.readOneHrByHrId", hrId);
	}

	@Override
	public int createNewHr(HrVO hrVO) {
		return getSqlSession().insert("Hr.createNewHr", hrVO);
	}

	@Override
	public int updateOneHrByHrId(HrVO hrVO) {
		return getSqlSession().update("Hr.updateOneHrByHrId", hrVO);
	}

	@Override
	public int deleteOneHrByHrId(String hrId) {
		return getSqlSession().update("Hr.deleteOneHrByHrId", hrId);
	}
	
	@Override
	public int updateHrStatByHrId(String hrId) {
		return getSqlSession().update("Hr.updateHrStatByHrId", hrId);
	}
	
	@Override
	public int updateOneMstrHrByMrId(HrVO hrVO) {
		return getSqlSession().update("Hr.updateOneMstrHrByMrId", hrVO);
	}
	
	@Override
	public int updateHrAprByHrId(HrVO hrVO) {
		return getSqlSession().update("Hr.updateHrAprByHrId", hrVO);
	}
	
	@Override
	public int checkCreateYn(String mbrId) {
		return getSqlSession().selectOne("Hr.checkCreateYn", mbrId);
	}
	

}
