package com.ktds.fr.hlpdsk.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.fr.hlpdsk.vo.HlpDskVO;
@Repository
public class HlpDskDAOImpl extends SqlSessionDaoSupport implements HlpDskDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public List<HlpDskVO> readAllMngrBrds(HlpDskVO hlpDskVO) {
		return getSqlSession().selectList("HlpDsk.readAllMngrBrds", hlpDskVO);
	}

	@Override
	public HlpDskVO readOneMngrBrdByMngrBrdId(String hlpDskId) {
		return getSqlSession().selectOne("HlpDsk.readOneMngrBrdByMngrBrdId", hlpDskId);
	}

	@Override
	public int createNewHlpDsk(HlpDskVO hlpDskVO) {
		return getSqlSession().insert("HlpDsk.createNewHlpDsk", hlpDskVO);
	}

	@Override
	public int deleteOneHlpDsk(String hlpDskId) {
		return getSqlSession().update("HlpDsk.deleteOneHlpDsk", hlpDskId);
	}

	@Override
	public int deleteHlpDskBySelectedHlpDskId(List<String> hlpDskId) {
		return getSqlSession().update(null, hlpDskId);
	}
}
