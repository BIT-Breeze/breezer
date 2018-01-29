package com.breeze2017.breezer.controller.api.tour;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.tour.TourMainHeaderService;
import com.breeze2017.breezer.vo.TourVo;
import com.breeze2017.security.Auth;

@Controller("tourMainHeaderAPIController")
@RequestMapping("/{id}/api/tourheader")
public class TourMainHeaderController {

	@Autowired
	private TourMainHeaderService tourMainHeaderService;

	@Auth
	@ResponseBody
	@RequestMapping("")
	public JSONResult getTourInfo( @RequestParam (value="idx", required=false) Long tourIdx ) {
		System.out.println("== TourMainHeaderController getTourInfo ==");	

		TourVo tour = tourMainHeaderService.getTourInfo(tourIdx);

		return JSONResult.success(tour);
	}
	
	
	@Auth
	@ResponseBody
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public JSONResult tourModify( 
			@RequestParam (value="idx", required=false) Long tourIdx,
			@ModelAttribute TourVo vo 
		) {
		
		System.out.println("== TourMainHeaderController modify ==");
		
		System.out.println("before modify vo : " + vo );
		
		tourMainHeaderService.modify(vo);
		
		System.out.println("modified vo :" + vo );
		System.out.println("== tour info 수정 완료 <DB 저장> ==");
		
		
		// modify후 select
		TourVo tour = tourMainHeaderService.getTourInfo(tourIdx);

		return JSONResult.success(tour);
		
	}
	
}
