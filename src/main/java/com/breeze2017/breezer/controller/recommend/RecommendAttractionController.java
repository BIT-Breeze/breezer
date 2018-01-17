package com.breeze2017.breezer.controller.recommend;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.breeze2017.breezer.vo.UserVo;
import com.breeze2017.security.Auth;
import com.breeze2017.security.AuthUser;

@Controller
@RequestMapping("/recommend")
public class RecommendAttractionController {
	
	@RequestMapping("/")
	public String searchPlace() {
		return "recommend/recommend_attraction";
	}
}
