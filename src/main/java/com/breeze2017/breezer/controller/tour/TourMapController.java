package com.breeze2017.breezer.controller.tour;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.breeze2017.breezer.vo.TourVo;
import com.breeze2017.security.Auth;

@Controller("tourMapController")
@RequestMapping("/{id}/tour")
public class TourMapController {

	@Auth
	@RequestMapping("/map")
	public ModelAndView mapTest(@PathVariable String id,
  	                  		    @RequestParam(value="idx", required=true, defaultValue="null") long tourIdx) {
		
		TourVo vo = new TourVo();
		vo.setIdx(tourIdx);
		vo.setUserId(id);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("vo", vo);
		mav.setViewName("tour/tour_map");
		
		return mav;
	}
}
