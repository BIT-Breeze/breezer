package com.breeze2017.breezer.service.recommend;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.recommend.RecommendAttractionDao;
import com.breeze2017.breezer.vo.LocationVo;
import com.breeze2017.breezer.vo.PostVo;
import com.breeze2017.breezer.vo.RecommendVo;

@Service
public class RecommendAttractionService {
	@Autowired
	private RecommendAttractionDao recommendAttractionDao;
	
	// recommend
	public List<RecommendVo> getRecommends(List<String> searchAddress){
		return recommendAttractionDao.getRecommends(searchAddress);
	}
	
	// recommend By Location
	public List<RecommendVo> getRecommendsByLocation(List<LocationVo> location){
		return recommendAttractionDao.getRecommendsByLocation(location);
	}
	
	// mahout data
	public List<PostVo> getMahoutData(List<RecommendVo> recommend){
		System.out.println("222 : " + recommendAttractionDao.getMahoutData(recommend));
		return recommendAttractionDao.getMahoutData(recommend);
	}

	// nearby
	public List<PostVo> getNearbyInfo(PostVo vo) {
		return recommendAttractionDao.getNearbyInfo(vo);
	}
	
	// search country
	public String countryDic(String[] address) {
		return recommendAttractionDao.getCountry(address);
	}
	
}
