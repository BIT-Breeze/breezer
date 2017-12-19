package com.breeze2017.breezer.controller.user;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.tour.TourMainService;
import com.breeze2017.breezer.service.user.UserMainService;
import com.breeze2017.breezer.vo.TourVo;
import com.breeze2017.breezer.vo.UserVo;

@Controller
@RequestMapping("/{id}")
public class UserMainController {
	
	@Autowired
	private UserMainService userMainService;
	
	private String id = "ohhongseok_test";
	
	@RequestMapping( "" )
	public String getUser(Model model) {
		System.out.println("UserMainController");			
		UserVo vo = new UserVo();
		vo = userMainService.getUserInfo(id);	
		
		model.addAttribute("uservo", vo);
		
		return "user/user_main";
	}
	
	@RequestMapping( "/tourlist" )
	@ResponseBody
	public JSONResult getTours(String id) {
		//System.out.println("JSON REQUEST CONTROLLER");
		List<TourVo> tours = userMainService.getTours("ohhongseok_test");		
		//System.out.println("JSON REQUEST CONTROLLER2");
		//System.out.println(tours);
		return JSONResult.success(tours);
	}
		
}
