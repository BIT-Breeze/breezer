package com.breeze2017.breezer.repository.sns;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.breeze2017.breezer.vo.LikeRankVo;
import com.breeze2017.breezer.vo.SNSVo;

@Repository
public class SnsMainDao {

	@Autowired
	private SqlSession sqlSession;

	public List<SNSVo> getList(Map<String, Object> map) {
		List<SNSVo> list = sqlSession.selectList("sns.getlist", map);
		System.out.println("SNSVO TEST = " + list);
		return list;
	}
	public void insertFavorite(String id, Object tourIdx, Object postIdx) {
		System.out.println("-- insertFavorite --");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("tourIdx", tourIdx);
		map.put("postIdx", postIdx);
		System.out.println("result : " +sqlSession.insert("sns.insertFavorite", map));
	}
	
	public void deleteTourFavorite(String id, long tourIdx) {
		System.out.println("-- deleteTourFavorite --");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("tourIdx", tourIdx);
		System.out.println("result : " +sqlSession.insert("sns.deleteTourFavorite", map));
	}
	
	public void deletePostFavorite(String id, long postIdx) {
		System.out.println("-- deletePostFavorite --");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("postIdx", postIdx);
		System.out.println("result : " +sqlSession.insert("sns.deletePostFavorite", map));
	}

	
	public void refreshTourFavorite(long idx) {
		System.out.println("-- refreshTourFavorite --");
		System.out.println("result : " +sqlSession.update("sns.refreshTourFavorite", idx));
	}
	
	public void refreshPostFavorite(long idx) {
		System.out.println("-- refreshPostFavorite --");
		System.out.println("result : " +sqlSession.update("sns.refreshPostFavorite", idx));
	}
	
	
	public List<LikeRankVo> getLikeRank(int interval) {
		List<LikeRankVo> list = sqlSession.selectList("sns.getlikerank", interval);
		System.out.println("LikeRankVo TEST = " + list);
		return list;
	}
	
	
	
}














