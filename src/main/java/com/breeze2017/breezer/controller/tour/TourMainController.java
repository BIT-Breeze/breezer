package com.breeze2017.breezer.controller.tour;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/tour")
public class TourMainController {

	@RequestMapping("/")
	public String mytour(HttpServletRequest request) {
		
		return "tour/tour_main";
	}
}
