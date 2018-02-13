package com.breeze2017.breezer.repository.recommend;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.breeze2017.breezer.vo.LocationVo;
import com.breeze2017.breezer.vo.PostVo;
import com.breeze2017.breezer.vo.RecommendVo;

@Repository
public class RecommendAttractionDao {
	@Autowired
	private SqlSession sqlSession;
	
	// recommend
	public List<RecommendVo> getRecommends(List<String> searchAddress){
		return sqlSession.selectList("recommend.getRecommends", searchAddress);
	}
	
	// recommend By Loaction
	public List<RecommendVo> getRecommendsByLocation(List<LocationVo> location){
		return sqlSession.selectList("recommend.getRecommendsByLocation", location);
	}
	
	// mahout data
	public List<PostVo> getMahoutData(List<RecommendVo> recommend){
		System.out.println("111 : " + recommend);
		return sqlSession.selectList("recommend.getMahoutData", recommend);
	}
	
	// nearby
	public List<PostVo> getNearbyInfo(PostVo vo) {
		return sqlSession.selectList("recommend.getNearby", vo);
	}
	
	// search country
	public String getCountry(String[] address) {
		return sqlSession.selectOne("recommend.getCountry", address);
	}
}
