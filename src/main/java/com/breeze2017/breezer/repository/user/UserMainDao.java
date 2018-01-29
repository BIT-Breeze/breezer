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
		UserVo result = sqlSession.selectOne("user.getUserInfo", id);
		List<String> list = sqlSession.selectList("user.getCountries", id);
		String countries = list.toString();
		countries = countries.replace("[", "");
		countries = countries.replace("]", "");
		countries = countries.replace(",", " ");	
		result.setCountries(countries);
		return result; 
	}
	
	public UserVo getOtherUserInfo( String id ) {
		System.out.println("===UserMainDao getUserInfo()===");
		UserVo result = sqlSession.selectOne("user.getOtherUserInfo", id);
		
		return result; 
	}
	// 자기 투어 가져오기 
	public List<TourVo> getTours(String id, Long startNo) {
		
		System.out.println("UserMainDao- getTours with 2 params");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("startNo", startNo);
		List<TourVo> result = sqlSession.selectList("user.gettours", map);
		System.out.println(result);
		return result;
	}
	
	public List<TourVo> getTours1(String id, Long startNo) {
		
		System.out.println("UserMainDao- getTours with 2 params, others");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("startNo", startNo);
		List<TourVo> result = sqlSession.selectList("user.gettours1", map);
		
		return result;
	}
	// 해당 유저의 모든 투어의 수 세기
	public int getTotalCount(String keyword) {
		
		return sqlSession.selectOne("user.getTotalCount", keyword);
	}
	// 해당 유저의 공개 투어의 수 세기
	public int getTourNumbers(String keyword) {

		return sqlSession.selectOne("user.getTourNumbers", keyword);
	}


	public int tourDelete(String idx) {
		int countPost = sqlSession.delete("user.allPostDelete", idx);	
		int countTour = sqlSession.delete("user.tourDelete", idx);
	
		return countTour;
	}

	public List<String> getCountries(String id) {
		List<String> result = sqlSession.selectList("user.getCountries",id);
		return result;
	}




}
