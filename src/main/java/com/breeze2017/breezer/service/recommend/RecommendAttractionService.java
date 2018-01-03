package com.breeze2017.breezer.service.recommend;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.recommend.RecommendAttractionDao;
import com.breeze2017.breezer.vo.PostVo;

@Service
public class RecommendAttractionService {
	@Autowired
	private RecommendAttractionDao recommendAttractionDao;
	
	public List<PostVo> getPostInfo(List<String> searchPlaces) {
		return recommendAttractionDao.getInfo(searchPlaces);
	}
}
