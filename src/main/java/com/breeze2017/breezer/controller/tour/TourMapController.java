package com.breeze2017.breezer.controller.tour;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.breeze2017.breezer.service.tour.TourMapService;

@Controller
public class TourMapController {
	
	@Autowired
	private TourMapService tourMapService;
	
	@RequestMapping("/map")
	public String mapTest() {
		return "tour/tour_map";
	}

}
