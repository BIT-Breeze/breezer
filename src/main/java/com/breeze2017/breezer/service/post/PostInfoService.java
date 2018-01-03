package com.breeze2017.breezer.service.post;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.post.PostInfoDao;
import com.breeze2017.breezer.vo.PostVo;

@Service
public class PostInfoService {

	@Autowired
	private PostInfoDao postInfoDao;
	
	public List<PostVo> getPostInfo(List<String> searchPlaces) {
		return postInfoDao.getInfo(searchPlaces);
	}
}
