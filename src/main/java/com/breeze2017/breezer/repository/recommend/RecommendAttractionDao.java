package com.breeze2017.breezer.repository.recommend;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	
	// nearby
	public List<PostVo> getNearbyInfo(PostVo vo) {
		return sqlSession.selectList("recommend.getNearby", vo);
	}
	
	// search country
	public String getCountry(String[] address) {
		return sqlSession.selectOne("recommend.getCountry", address);
	}
}
