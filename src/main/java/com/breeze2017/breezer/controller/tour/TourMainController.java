package com.breeze2017.breezer.controller.tour;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.breeze2017.breezer.service.tour.TourMainService;
import com.breeze2017.security.Auth;

@Controller
@RequestMapping("/{id}/tour")
public class TourMainController {

	@Autowired
	private TourMainService tourMainService;

	@RequestMapping("")
	public String mytour(
			@PathVariable String id,
			@RequestParam(value="idx", required=false) long tourIdx,
			Model model) {

		model.addAttribute("userId", id);
		model.addAttribute("tourIdx", tourIdx);
		
		return "tour/tour_main";
	}

	@RequestMapping("1")
	public String test(){
		return "tour/test";
	}
}
