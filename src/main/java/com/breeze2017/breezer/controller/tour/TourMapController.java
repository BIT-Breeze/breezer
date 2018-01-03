package com.breeze2017.breezer.controller.tour;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("tourMapController")
@RequestMapping("/tourmap")
public class TourMapController {
	
	@RequestMapping("/map")
	public String mapTest() {
		return "tour/tour_map";
	}
}
