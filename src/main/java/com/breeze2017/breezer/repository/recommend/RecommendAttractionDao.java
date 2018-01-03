package com.breeze2017.breezer.repository.recommend;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.breeze2017.breezer.vo.PostVo;

@Repository
public class RecommendAttractionDao {
	@Autowired
	private SqlSession sqlSession;
	
	public List<PostVo> getInfo(List<String> searchPlaces) {
		List<PostVo> info = new ArrayList<PostVo>();
		info = sqlSession.selectList("recommend.info", searchPlaces);

		return info; 
	}
}
