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
	public List<HlpDskVO> readAllHlpDsks(HlpDskVO hlpDskVO) {
		return getSqlSession().selectList("HlpDsk.readAllHlpDsks", hlpDskVO);
	}

	@Override
	public List<HlpDskVO> readAllHlpDsksPagination(String hlpDskTtl) {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("HlpDsk.readAllHlpDsksPagination",hlpDskTtl);
	}	
	@Override
	public HlpDskVO readOneHlpDskByHlpDskId(String hlpDskId) {
		return getSqlSession().selectOne("HlpDsk.readOneHlpDskByHlpDskId", hlpDskId);
	}

	
	@Override
	public int createNewHlpDsk(HlpDskVO hlpDskVO) {
		return getSqlSession().insert("HlpDsk.createNewHlpDsk", hlpDskVO);
	}

	@Override
	public int updateNewHlpDsk(HlpDskVO hlpDskVO) {
		return getSqlSession().update("HlpDsk.updateNewHlpDsk", hlpDskVO);
	}
	
	@Override
	public int deleteOneHlpDsk(String hlpDskId) {
		return getSqlSession().update("HlpDsk.deleteOneHlpDsk", hlpDskId);
	}

	@Override
	public int deleteHlpDskBySelectedHlpDskId(List<String> hlpDskId) {
		return getSqlSession().update("HlpDsk.deleteHlpDskBySelectedHlpDskId", hlpDskId);
	}
}
