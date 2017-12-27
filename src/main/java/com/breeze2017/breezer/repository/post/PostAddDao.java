package com.breeze2017.breezer.repository.post;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.breeze2017.breezer.vo.PostVo;


@Repository
public class PostAddDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int insert(PostVo vo) {
		return sqlSession.insert("post.insert", vo);
	}
}