package com.breeze2017.breezer.service.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breeze2017.breezer.repository.tour.TourMainDao;
import com.breeze2017.breezer.repository.user.UserMainDao;
import com.breeze2017.breezer.vo.TourVo;
import com.breeze2017.breezer.vo.UserVo;

@Service
public class UserMainService {
	
	private static final int LIST_SIZE = 6;
	private static final int PAGE_SIZE = 5;
	
	
	@Autowired
	private UserMainDao userMainDao;
	
	public UserVo getUserInfo(String id) {
		
		UserVo result = userMainDao.getUserInfo(id);
		System.out.println("UserMainService");
		return result;
		
	}	
	
	/* test code for country button */
	@Autowired
	TourMainDao tourMainDao;
	
	public List<TourVo> getTours(String id){
		System.out.println("UserMainService");
		List<TourVo> result = userMainDao.getTours(id);
		
		return result;
	}
	/* End : test code for country button */

	public Map<String, Object> getTours1(int currentPage, String keyword) {
		System.out.println("====== UserMainService - getTours1 ======");
		// controller에선 Integer로 받은 걸 명시적 형변환 없이 여기선 int로 받는다. 
		// 1. basic calculate for paging
		
		int totalCount = userMainDao.getTotalCount( keyword );
		System.out.println("totalCount : "+totalCount);
		int pageCount = (int)Math.ceil((double)totalCount/LIST_SIZE);
		// 총 페이지 수 
		System.out.println("pageCount : "+pageCount);
		int blockCount = (int)Math.ceil((double)pageCount/PAGE_SIZE);
		// 총 블락의 수, 즉 5, 10 ,15 이런식으로 페이지 번호가 분할되는 개수 
		System.out.println("blockCount : "+blockCount);
		int currentBlock = (int)Math.ceil((double)currentPage/PAGE_SIZE);
		System.out.println("currentBlock : "+currentBlock);
		if( currentPage < 1) {
			currentPage = 1;
			currentBlock = 1;
		}else if( currentPage > pageCount) {
			currentPage = pageCount;
			currentBlock = (int)Math.ceil((double)currentPage/PAGE_SIZE);
			
		}
		int beginPage = currentBlock == 0 ? 1 : (currentBlock - 1) * PAGE_SIZE + 1;		
		// 현재블럭이 0이면 시작페이지가 1이고 0이 아니면 현재블럭에서 1을뺀거에 페이지사이즈를 곱하고 1을 더한다. 
		// 즉 1, 6, 11... 형태로 증가한다. 
		int prevPage = ( currentBlock > 1 ) ? ( currentBlock-1 ) * PAGE_SIZE : 0;
		// 5, 10, 15... 형태로 증가한다. 
		int nextPage = ( currentBlock < blockCount ) ? currentBlock * PAGE_SIZE +1 : 0;
		// 6, 11, 16... 형태로 증가한다. 
		int endPage = ( nextPage > 0 ) ? (beginPage - 1) + LIST_SIZE : pageCount;
		// 리스트가 12개 있을 경우 
		List<TourVo> list = userMainDao.getTours1(keyword, currentPage, LIST_SIZE);
		System.out.println(list);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println(beginPage);
		System.out.println(prevPage);
		System.out.println(nextPage);
		System.out.println(endPage);
		
		map.put("list", list);
		map.put("totalCount", totalCount);
		map.put("listSize", LIST_SIZE);
		map.put("currentPage", currentPage);
		map.put("beginPage", beginPage);
		map.put("endPage", endPage);
		map.put("prevPage", prevPage);
		map.put("nextPage", nextPage);
		map.put("keyword", keyword);
				
		return map;
	}
}
