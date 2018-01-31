package com.breeze2017.breezer.service.post;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.post.PostDao;
import com.breeze2017.breezer.vo.PostVo;

@Service
public class PostService {

	@Autowired
	private PostDao postDao;
	
	public boolean insertPost(PostVo vo) {
		return postDao.insert(vo) == 1;
	}
	
	public boolean modifyPost(PostVo vo) {
		return postDao.update(vo) == 1;
	}
	
	public PostVo selectPost(PostVo vo) {
		return postDao.select(vo);
	}
	
	public int selectPostCount(PostVo vo) {
		return postDao.selectPostCount(vo);
	}
}