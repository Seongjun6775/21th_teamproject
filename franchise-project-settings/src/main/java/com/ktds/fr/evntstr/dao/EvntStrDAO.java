package com.ktds.fr.evntstr.dao;

import java.util.List;

import com.ktds.fr.evntstr.vo.EvntStrVO;

public interface EvntStrDAO {

	public List<EvntStrVO> readAllEvntStr(EvntStrVO evntStrVO);
}
