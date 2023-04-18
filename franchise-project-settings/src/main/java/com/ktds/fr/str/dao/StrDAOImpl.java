package com.ktds.fr.str.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.str.vo.StrVO;

@Repository
public class StrDAOImpl extends SqlSessionDaoSupport implements StrDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public List<StrVO> readAllStrMaster(StrVO strVO) {
		return getSqlSession().selectList("Str.readAllStrMaster", strVO);
	}

	@Override
	public StrVO readOneStrByMaster(String strId) {
		return getSqlSession().selectOne("Str.readOneStrByMaster", strId);
	}

	@Override
	public StrVO readOneStrByManager(String strId) {
		return getSqlSession().selectOne("Str.readOneStrByManager", strId);
	}

	@Override
	public int createOneStr(StrVO strVO) {
		return getSqlSession().insert("Str.createOneStr", strVO);
	}

	@Override
	public int updateOneStrByMaster(StrVO strVO) {
		return getSqlSession().update("Str.updateOneStrByMaster", strVO);
	}

	@Override
	public int updateOneStrByManager(StrVO strVO) {
		return getSqlSession().update("Str.updateOneStrByManager", strVO);
	}

	@Override
	public int deleteOneStrByStrId(String strId) {
		return getSqlSession().update("Str.deleteOneStrByStrId", strId);
	}

	@Override
	public int readBlockStrNm(StrVO strVO) {
		return getSqlSession().selectOne("Str.readBlockStrNm", strVO);
	}
	@Override
	public int readBlockStrAddr(StrVO strVO) {
		return getSqlSession().selectOne("Str.readBlockStrAddr", strVO);
	}
	@Override
	public int readBlockStrCallNum(StrVO strVO) {
		return getSqlSession().selectOne("Str.readBlockStrCallNum", strVO);
	}

	
}
