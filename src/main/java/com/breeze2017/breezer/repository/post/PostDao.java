package com.breeze2017.breezer.repository.post;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.breeze2017.breezer.vo.PostVo;

@Repository
public class PostDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int update(PostVo vo) {
		return sqlSession.update("post.update", vo);
	}
	
	public int insert(PostVo vo) {
		return sqlSession.insert("post.insert", vo);
	}
	
	public PostVo select(PostVo vo) {
		return sqlSession.selectOne("post.selectPost", vo);
	}
	
	public int selectPostCount(PostVo vo) {
		return sqlSession.selectOne("post.selectPostCount", vo);
	}
}