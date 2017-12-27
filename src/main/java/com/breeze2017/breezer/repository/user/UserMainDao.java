package com.breeze2017.breezer.repository.user;

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
		// 파라미터를 뭘로 해야 할지, str or obj
		UserVo result = sqlSession.selectOne("user.getUserInfo", id);
		System.out.println(result.getTours());		
		
		return result; 
	}

	public List<TourVo> getTours(String id) {
		
		System.out.println("TourMainDao");
		List<TourVo> result = sqlSession.selectList("user.gettours", id);

		
		return result;
	}

	public int getTotalCount(String keyword) {
		
		return sqlSession.selectOne("user.getTotalCount", keyword);
	}

	public List<TourVo> getTours1(String keyword, Integer page, Integer size) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("page", page);
		map.put("size", size);
		
		return sqlSession.selectList("user.gettours1",map);
	}
}
