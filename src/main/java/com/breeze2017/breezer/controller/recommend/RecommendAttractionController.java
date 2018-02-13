package com.breeze2017.breezer.controller.recommend;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.breeze2017.security.Auth;

@Controller
@RequestMapping("/{id}/recommend")
public class RecommendAttractionController {
	
	@Auth
	@RequestMapping("/")
	public ModelAndView searchPlace(@PathVariable String id) {
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("userId", id);
		mav.setViewName("recommend/recommend_attraction");
		return mav;
	}
}
