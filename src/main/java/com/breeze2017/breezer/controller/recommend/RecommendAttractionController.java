package com.breeze2017.breezer.controller.recommend;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.breeze2017.security.Auth;

@Controller
@RequestMapping("/{id}/recommend")
public class RecommendAttractionController {
	
	@Auth
	@RequestMapping("/")
	public String searchPlace() {
		return "recommend/recommend_attraction";
	}
}
