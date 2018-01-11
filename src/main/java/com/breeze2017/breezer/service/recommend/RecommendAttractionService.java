package com.breeze2017.breezer.service.recommend;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.recommend.RecommendAttractionDao;
import com.breeze2017.breezer.vo.PostVo;
import com.breeze2017.breezer.vo.RecommendVo;

@Service
public class RecommendAttractionService {
	@Autowired
	private RecommendAttractionDao recommendAttractionDao;
	
	public List<PostVo> getPostInfo(List<String> searchPlaces) {
		return recommendAttractionDao.getInfo(searchPlaces);
	}
	
	// recommend
	public List<RecommendVo> getRecommends(List<String> searchAddress){
		return recommendAttractionDao.getRecommends(searchAddress);
	}

	// nearby
	/*public List<PostVo> getNearbyInfo(String searchAddress) {
		return postDao.getNearbyInfo(searchAddress);
	}*/
}
