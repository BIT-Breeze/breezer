package com.breeze2017.breezer.repository.user;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.breeze2017.breezer.vo.UserVo;

@Repository
public class UserRegisterIdDao {

	@Autowired
	private SqlSession sqlSession;

	// fbid에 id 설정하기
	public int setIdByFbId(UserVo vo) {
		return sqlSession.update("userregisterid.setId", vo);
	}
	
	public int checkId(UserVo vo) {
		return sqlSession.selectOne("userregisterid.checkId", vo);
	}
}
