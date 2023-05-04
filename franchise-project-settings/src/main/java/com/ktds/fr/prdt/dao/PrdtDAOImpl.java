package com.ktds.fr.prdt.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.prdt.vo.PrdtVO;

@Repository
public class PrdtDAOImpl extends SqlSessionDaoSupport implements PrdtDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public List<PrdtVO> readAll(PrdtVO prdtVO) {
		return getSqlSession().selectList("Prdt.readAll", prdtVO);
	}
	
	@Override
	public List<PrdtVO> readAllNoPagenation(PrdtVO prdtVO) {
		return getSqlSession().selectList("Prdt.readAllNoPagenation", prdtVO);
	}
	
	@Override
	public List<PrdtVO> readAllNoPagenationUseY(PrdtVO prdtVO) {
		return getSqlSession().selectList("Prdt.readAllNoPagenationUseY", prdtVO);
	}
	
	@Override
	public List<PrdtVO> readAllCustomerNoPagenation(PrdtVO prdtVO) {
		return getSqlSession().selectList("Prdt.readAllCustomerNoPagenation", prdtVO);
	}

	@Override
	public PrdtVO readOne(String prdtId) {
		return getSqlSession().selectOne("Prdt.readOne", prdtId);
	}
	
	@Override
	public List<PrdtVO> readAllCustomer(PrdtVO prdtVO) {
		return getSqlSession().selectList("Prdt.readAllCustomer", prdtVO);
	}
	
	@Override
	public int create(PrdtVO prdtVO) {
		return getSqlSession().insert("Prdt.create", prdtVO);
	}

	@Override
	public int update(PrdtVO prdtVO) {
		return getSqlSession().update("Prdt.update", prdtVO);
	}

	@Override
	public int updateAll(PrdtVO prdtVO) {
		return getSqlSession().update("Prdt.updateAll", prdtVO);
	}
	@Override
	public int deleteOne(String prdtId) {
		return getSqlSession().update("Prdt.deleteOne", prdtId);
	}

	@Override
	public int deleteSelectAll(List<String> prdtIdList) {
		return getSqlSession().update("Prdt.deleteSelectAll", prdtIdList);
	}

	@Override
	public List<PrdtVO> readAllNoPagenationEvnt(PrdtVO prdtVO) {
		return getSqlSession().selectList("Prdt.readAllNoPagenationEvnt", prdtVO);
	}


}
