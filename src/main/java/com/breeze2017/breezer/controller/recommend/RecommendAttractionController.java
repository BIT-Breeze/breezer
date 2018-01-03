package com.breeze2017.breezer.controller.recommend;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/recommend")
public class RecommendAttractionController {
	
	@RequestMapping("/")
	public String searchPlace() {
		return "recommend/recommend_attraction";
	}
}
