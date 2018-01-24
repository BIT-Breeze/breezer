package com.breeze2017.breezer.controller.user;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.user.UserMainService;
import com.breeze2017.breezer.vo.TourVo;
import com.breeze2017.breezer.vo.UserVo;
import com.breeze2017.security.AuthUser;

@Controller
@RequestMapping("/{id}")
public class UserMainController {
	
	@Autowired
	private UserMainService userMainService;
	
	@RequestMapping( "" )
	public String getUser(@AuthUser UserVo authUser,
						  @PathVariable String id,
							Model model) {
		System.out.println("====== UserMainController : /{id} ======");				
		
		if(authUser.getId().equals(id)) {
		UserVo uservo = userMainService.getUserInfo(authUser.getId());

		List<String> list = userMainService.getCountries(authUser.getId());
		int numOfCountries = list.size();
		String countries = userMainService.countCountries(list);
		uservo.setNumOfcountries(numOfCountries);
		uservo.setCountries(countries);
		model.addAttribute("uservo",uservo);
		model.addAttribute("uservo2",uservo);

		} else {

		UserVo uservo = userMainService.getUserInfo(authUser.getId());
		UserVo uservo2 = userMainService.getOtherUserInfo(id);
		List<String> list = userMainService.getCountries(authUser.getId());
		int numOfCountries = list.size();
		String countries = userMainService.countCountries(list);
		uservo.setNumOfcountries(numOfCountries);
		uservo.setCountries(countries);
		
			if(uservo2.getId() != null) {
			model.addAttribute("uservo", uservo);
			model.addAttribute("uservo2", uservo2);
			} else {
				model.addAttribute("uservo",uservo);
				model.addAttribute("uservo2",uservo);				
			}
		}
		return "user/user_main";
	}
	
	@RequestMapping( "/tourlist" )
	@ResponseBody
	public JSONResult getTours(
			@AuthUser UserVo authUser,
			@PathVariable String id,
			@RequestParam( value="no", required=true)Long no
			) {	
		System.out.println("======JSON REQUEST CONTROLLER======"+ no);
		System.out.println(authUser.getId());
		System.out.println(id);

		if(authUser.getId().equals(id)) {
			System.out.println("자기 페이지를 보는 쿼리 ");		
			List<TourVo> tours = userMainService.getTours(id,no);		
		
			if(tours.isEmpty()) {
				return JSONResult.fail("더 이상 데이터가 존재하지 않습니다.");
			}
			System.out.println(tours);
			return JSONResult.success(tours);
			
		} else {
			System.out.println("타인 페이지를 보는 쿼리");
			//타인페이지를 볼때 로그를 남긴다. 

			List<TourVo> tours = userMainService.getTours1(id, no);
			// 다른사람의 페이지는 secret 이 1인 게시물은 가져오지 않는 쿼리
			if(tours.isEmpty()) {
				return JSONResult.fail("더 이상 데이터가 존재하지 않습니다.");
			}
			// 로그 남기는 메소드 
			try {
				userMainService.leaveLog(authUser.getId(), id);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return JSONResult.success(tours);
						
		}
	}
	
	@ResponseBody
	@RequestMapping(
			value = "/tourdelete",
			method = RequestMethod.GET
			)
	public JSONResult delete(@RequestParam(value="idx",required=true) String idx, 
							 @AuthUser UserVo authUser,	
							 @PathVariable String id,
							 Model model) {
		// @authUser 인자로 넣고 자기 투어 아니면 못지우게 
		if(authUser.getId().equals(id)) {
		boolean bSuccess = 
				userMainService.tourDelete(idx);
		System.out.println(bSuccess);
		System.out.println(idx);
		
		return JSONResult.success( bSuccess ? idx : -1);
		
		} else {						
			
			return JSONResult.fail("타인의 게시글을 지울 수 없습니다.");
		}
	}
			
}
