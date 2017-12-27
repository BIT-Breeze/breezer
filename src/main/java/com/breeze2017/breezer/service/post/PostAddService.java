package com.breeze2017.breezer.service.post;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.post.PostAddDao;
import com.breeze2017.breezer.vo.PostVo;


@Service
public class PostAddService {

	@Autowired
	private PostAddDao postAddDao;
	
	public boolean insertMessage(PostVo vo) {
		return postAddDao.insert(vo) == 1;
	}
}