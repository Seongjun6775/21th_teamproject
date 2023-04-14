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
	public List<HrVO> readAllHr() {
		return null;
	}

	@Override
	public HrVO readOneHrByHrId(String hrId) {
		return null;
	}

	@Override
	public int createNewHr(HrVO hrVO) {
		return 0;
	}

	@Override
	public int updateOneHrByHrId(HrVO hrVO) {
		return 0;
	}

	@Override
	public int deleteOneHrByHrId(String hrId) {
		return 0;
	}
	
	

}
