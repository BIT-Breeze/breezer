package com.breeze2017.breezer.repository.sns;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.breeze2017.breezer.vo.SNSVo;

@Repository
public class SnsMainDao {

	@Autowired
	private SqlSession sqlSession;
	
	public List<SNSVo> getList(long idx) {
		List<SNSVo> list = sqlSession.selectList("sns.getlist", idx);
		System.out.println("SNSVO TEST = "+list);
		return list;
	}	
}
