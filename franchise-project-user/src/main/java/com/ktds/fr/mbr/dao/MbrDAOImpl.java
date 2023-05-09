package com.ktds.fr.mbr.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.mbr.vo.MbrVO;

@Repository
public class MbrDAOImpl extends SqlSessionDaoSupport implements MbrDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public String readSaltMbrById(String mbrId) {
		return getSqlSession().selectOne("Mbr.readSaltMbrById",mbrId);
	}

	@Override
	public String readLgnBlockYnById(String mbrId) {
		return getSqlSession().selectOne("Mbr.readLgnBlockYnById",mbrId);
	}

	@Override
	public MbrVO readOneMbrByMbrIdAndMbrPwd(MbrVO mbrVO) {
		return getSqlSession().selectOne("Mbr.readOneMbrByMbrIdAndMbrPwd",mbrVO);
	}

	@Override
	public int updateMbrLgnSucc(MbrVO mbrVO) {
		return getSqlSession().update("Mbr.updateMbrLgnSucc",mbrVO);
	}

	@Override
	public int updateMbrLgnFail(MbrVO mbrVO) {
		return getSqlSession().update("Mbr.updateMbrLgnFail",mbrVO);
	}

	@Override
	public int updateMbrLgnBlock(MbrVO mbrVO) {
		return getSqlSession().update("Mbr.updateMbrLgnBlock",mbrVO);
	}
	
	@Override
	public int readOneMbrLgnFailCnt(String mbrId) {
		return getSqlSession().selectOne("Mbr.readOneMbrLgnFailCnt", mbrId);
	}

	@Override
	public int readCountMbrById(String mbrId) {
		return getSqlSession().selectOne("Mbr.readCountMbrById",mbrId);
	}

	@Override
	public int createNewMbr(MbrVO mbrVO) {
		return getSqlSession().insert("Mbr.createNewMbr",mbrVO);
	}

//	@Override
//	public List<MbrVO> readAllMbr(MbrVO mbrVO) {
//		return getSqlSession().selectList("Mbr.readAllMbr", mbrVO);
//	}

//	@Override
//	public List<MbrVO> readAllAdminMbr(MbrVO mbrVO) {
//		return getSqlSession().selectList("Mbr.readAllAdminMbr",mbrVO);
//	}

	@Override
	public int updateOneMbr(MbrVO mbrVO) {
		return getSqlSession().update("Mbr.updateOneMbr",mbrVO);
	}

	@Override
	public int deleteOneMbr(String mbrId) {
		return getSqlSession().update("Mbr.deleteOneMbr",mbrId);
	}

	@Override
	public MbrVO readOneMbrByPwd(MbrVO mbrVO) {
		return getSqlSession().selectOne("Mbr.readOneMbrByPwd", mbrVO);
	}
	@Override
	public MbrVO readOneMbrByMbrId(String mbrId) {
		return getSqlSession().selectOne("Mbr.readOneMbrByMbrId",mbrId);
	}
	@Override
	public int updateOneMbrPwd(MbrVO mbrVO) {
		return getSqlSession().update("Mbr.updateOneMbrPwd",mbrVO);
	}
	@Override
	public List<MbrVO> readMbrByMbrEml(MbrVO mbrVO) {
		return getSqlSession().selectList("Mbr.readMbrByMbrEml",mbrVO);
	}
//	@Override
//	public int updateOneMbrLvlAndStrId(MbrVO mbrVO) {
//		return getSqlSession().update("Mbr.updateOneMbrLvlAndMbrStrId", mbrVO);
//	}
//	@Override
//	public int deleteOneMbrAdminByMbrId(MbrVO mbrVO) {
//		return getSqlSession().update("Mbr.deleteOneMbrAdminByMbrId", mbrVO);
//	}
}
