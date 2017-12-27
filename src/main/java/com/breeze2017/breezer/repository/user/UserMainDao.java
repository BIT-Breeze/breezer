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
		System.out.println("====== getTours1 ======");
		Map<String, Object> map = new HashMap<String, Object>();
		//map.put("keyword", keyword);
		System.out.println("-- before put --");
		System.out.println("keyword : "+keyword);
		System.out.println("page : "+page);
		System.out.println("size : "+size);
		
		// ??? page는 2를 입력했는데 service에서 바껴서 0으로 온다. 
		// 이걸 하드코딩으로 2로 줘보자 -> 2를 주니까 데이터가 찍혔다.
		
		//map.put("page", page);
		map.put("page", 2);
		map.put("size", size);
		map.put("keyword", keyword);
		
		System.out.println("-- map data --");
		System.out.println("keyword : "+map.get("keyword"));
		System.out.println("page : "+map.get("page"));
		System.out.println("size : "+map.get("size"));
		
		
		//List<TourVo> result = new ArrayList<TourVo>();
				//result = sqlSession.selectList("user.gettours1",map);
		
		List<TourVo> list = sqlSession.selectList("user.gettours1",map);
		
		System.out.println("list : "+list);
		return null;
	}
}
