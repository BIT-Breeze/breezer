package com.breeze2017.breezer.repository.user;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.breeze2017.breezer.vo.UserVo;

@Repository
public class UserLoginDao {
	@Autowired
	private SqlSession sqlSession;
	
	
	// 회원가입
	public int joinUser(UserVo vo) {
		return sqlSession.insert("userlogin.insert", vo);
	}
	
	// fbid로 유저정보 가져오기
	public UserVo getUserByFbId(UserVo vo) {
		UserVo result = sqlSession.selectOne("userlogin.getByFbId", vo);
		return result;
	}
	
	// id로 유저정보 가져오기
	public UserVo getUserById(UserVo vo) {
		UserVo result = sqlSession.selectOne("userlogin.getById", vo);
		return result;
	}
	
	// 로그인시 fbid로 유저정보 리셋하기 
	public int resetByFbId(UserVo vo) {
		return sqlSession.update("userlogin.resetByFbId", vo);
	}
	

}
