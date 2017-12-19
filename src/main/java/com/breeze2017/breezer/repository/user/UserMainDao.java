package com.breeze2017.breezer.repository.user;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.breeze2017.breezer.vo.UserVo;

@Repository
public class UserMainDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public UserVo getUserInfo( String id ) {
		// 파라미터를 뭘로 해야 할지, str or obj
		UserVo result = sqlSession.selectOne("user.getUserInfo", id);
				
		
		return result; 
	}
}
