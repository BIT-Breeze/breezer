package com.breeze2017.breezer.repository.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.breeze2017.breezer.vo.TourVo;
import com.breeze2017.breezer.vo.UserVo;

@Repository
public class UserMainDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public UserVo getUserInfo( String id ) {
		System.out.println("===UserMainDao getUserInfo()===");
		UserVo result = sqlSession.selectOne("user.getUserInfo2", id);
		
		return result; 
	}

	public List<TourVo> getTours(String id) {
		
		System.out.println("===UserMainDao getTours()==");
		List<TourVo> result = sqlSession.selectList("user.gettours", id);
				
		return result;
	}
	
	public List<TourVo> getTours(String id, Long startNo) {
		
		System.out.println("UserMainDao- getTours with 2 params");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("startNo", startNo);
		List<TourVo> result = sqlSession.selectList("user.gettours", map);
		
		return result;
	}
	
	public int getTotalCount(String keyword) {
		
		return sqlSession.selectOne("user.getTotalCount", keyword);
	}

	public int tourDelete(TourVo tourvo) {
		int count = sqlSession.delete("user.tourDelete", tourvo);

		return count;
	}

}
