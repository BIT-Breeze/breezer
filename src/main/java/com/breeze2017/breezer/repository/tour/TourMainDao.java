package com.breeze2017.breezer.repository.tour;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.breeze2017.breezer.vo.PostVo;

@Repository
public class TourMainDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<PostVo> getTour(String userId, int tourIdx){
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("tourIdx", tourIdx);
		
		List<PostVo> tour = sqlSession.selectList("tourMain.getTour", map);
		
		return tour;
	}
}
