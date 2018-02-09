package com.breeze2017.breezer.controller.tour;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.breeze2017.breezer.service.tour.TourMapService;
import com.breeze2017.breezer.vo.TourVo;
import com.breeze2017.security.Auth;

@Controller("tourMapController")
@RequestMapping("/{id}/tour")
public class TourMapController {
	
	@Autowired
	private TourMapService tourMapService;

	@RequestMapping("/map")
	public ModelAndView mapTest(@PathVariable String id,
  	                  		    @RequestParam(value="idx", required=true, defaultValue="null") long tourIdx) {
		TourVo tourVo = new TourVo();
		tourVo.setIdx(tourIdx);
		tourVo.setUserId(id);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("vo", tourMapService.getTourData(tourVo));
		mav.setViewName("tour/tour_map");
		return mav;
	}
}
