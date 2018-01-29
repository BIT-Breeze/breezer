package com.breeze2017.breezer.service.user;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
	
	//private static final int LIST_SIZE = 6;
	//private static final int PAGE_SIZE = 5;	
	
	@Autowired
	private UserMainDao userMainDao;
	
	public UserVo getUserInfo(String id) {
		System.out.println("==UserMainService getUserInfo()==");
		UserVo result = userMainDao.getUserInfo(id);		

		return result;		
	}	
	
	public UserVo getOtherUserInfo(String id) {
		System.out.println("==UserMainService getUserInfo()==");
		UserVo result = userMainDao.getOtherUserInfo(id);		

		return result;		
	}	
		
	// 자기페이지 보는 쿼리
	public List<TourVo> getTours(String id, Long startNo){
		System.out.println("UserMainService - with 2 params");
		//System.out.println(id);
		//System.out.println(startNo);
		List<TourVo> result = userMainDao.getTours(id, startNo);
		
		return result;
	}
	// 다른 사람의 투어를 불러올 때 호출하는 메시지
	public List<TourVo> getTours1(String id, Long startNo) {
		System.out.println("UserMainService - with 2 params, other");

		List<TourVo> result = userMainDao.getTours1(id, startNo);
		return result;
	}

	public boolean tourDelete(String idx) {
		int count = userMainDao.tourDelete(idx);
		System.out.println("count =" + count );
		return count == 1;
		// 하나가 삭제되었다면 true가 리턴되고 삭제가 안 되었다면 false가 리턴된다. 
	}

	public void leaveLog(String authUser, String otherUser) throws IOException {
		String logMessage = authUser + 	" took a look at " +
							otherUser + "'s page"; 
		File dir;
		File file;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
		String visitedDay = sdf.format(new Date());
		System.out.println(visitedDay);
		
		dir = new File("D:\\bigdata\\breezerLog\\"+authUser);
		if(dir.exists() == false) {dir.mkdirs();}
		file = new File("D:\\bigdata\\breezerLog\\"+authUser+"\\"+visitedDay+".txt");
		if(file.exists() == false) {
			System.out.println("파일이 존재하지 않습니다.");
			file.createNewFile();
		}
			try {
				System.out.println("line 80");
				FileWriter fw = new FileWriter(file);
				fw.write(logMessage);
				System.out.println("쓰기 성공!");
				fw.flush();
				fw.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("파일생성");
		}
	// 공개 투어만 세기
	public Integer getTourNumbers(String id) {

		return userMainDao.getTourNumbers(id);
	}
	// 모든 투어 세기 
	public Integer getTotalCount(String id) {

		return userMainDao.getTotalCount(id);
	}





	
	
	

}
