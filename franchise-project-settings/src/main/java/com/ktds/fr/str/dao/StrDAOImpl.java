package com.ktds.fr.str.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.mbr.vo.MbrVO;
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
	public int readBlockStrNm(String strNm) {
		return getSqlSession().selectOne("Str.readBlockStrNm", strNm);
	}
	@Override
	public int readBlockStrAddr(String strAddr) {
		return getSqlSession().selectOne("Str.readBlockStrAddr", strAddr);
	}
	@Override
	public int readBlockStrCallNum(String strCallNum) {
		return getSqlSession().selectOne("Str.readBlockStrCallNum", strCallNum);
	}

	@Override
	public int readBlockStrByMan(String strId) {
		return getSqlSession().selectOne("Str.readBlockStrByMan", strId);
	}
	
	/**
	 * 회원 기능과 연동
	 */
	@Override
	public List<StrVO> readAllStrNoPagenate(StrVO strVO) {
		return getSqlSession().selectList("Str.readAllStrNoPagenate", strVO);
	}

	@Override
	public List<StrVO> readAll() {
		return getSqlSession().selectList("Str.readAll");
	}
	@Override
	public int readOneStrByMbrId(String mbrId) {
		return getSqlSession().selectOne("Str.readOneStrByMbrId",mbrId);
	}
	
	@Override
	public int deleteOneManagerByMbrId(String mbrId) {
		return getSqlSession().update("Str.deleteOneManagerByMbrId", mbrId);
	}
	
	@Override
	public int updateOneStrByStrIdAndMbrId(MbrVO mbrVO) {
		return getSqlSession().update("Str.updateOneStrByStrIdAndMbrId", mbrVO);
	}
	
	@Override
	public List<StrVO> readAllUseY(String ctyId) {
		return getSqlSession().selectList("Str.readAllUseY", ctyId);
	}
	
}
