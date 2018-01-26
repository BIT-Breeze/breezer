package com.breeze2017.breezer.controller.api.tour;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.tour.TourMainHeaderService;
import com.breeze2017.breezer.vo.TourVo;

@Controller("tourMainHeaderAPIController")
@RequestMapping("/api/tourheader")
public class TourMainHeaderController {

	@Autowired
	private TourMainHeaderService tourMainHeaderService;

	@ResponseBody
	@RequestMapping("")
	public JSONResult getTourInfo(
			@RequestParam (value="idx", required=false) long tourIdx,
			Model model
			) {
			
		System.out.println("controller idx : " + tourIdx);
			
		TourVo tour = tourMainHeaderService.getTourInfo(tourIdx);
		System.out.println("tour >> " + tour);
		/*System.out.println("aaaa : " + tour.toString());*/
			
		return JSONResult.success(tour);
	}
	
	
	
	
	
	/*	@Auth
	@ResponseBody
	@RequestMapping(value="tour/modify", method=RequestMethod.POST)
	public String tourModify( @ModelAttribute TourVo vo, @PathVariable String id) {
		System.out.println(">> TourAddController tour/modify");

		vo.setUserId(id);
		
		System.out.println("modify vo : " + vo );
		
		tourAddService.modify(vo);

		System.out.println("after vo :" + vo );
		
		return "";
		
	}*/

	
	
	
	
/*	
	@Auth
	@RequestMapping(value="tour/modify", method=RequestMethod.POST)
	public String tourModify( 
			@RequestParam(value="title", required=false) String title,
			@RequestParam(value="startDate", required=false) String startDate,
			@RequestParam(value="endDate", required=false) String endDate,
			@RequestParam(value="idx", required=false) Long idx,
			@RequestParam(value="mainPhoto", required=false) String mainPhoto,
			Model model
			) {
		
		System.out.println(">> TourAddController tour/modify");
		
		TourVo vo = new TourVo();
		vo.setTitle(title);
		vo.setStartDate(startDate);
		vo.setEndDate(endDate);
		vo.setIdx(idx);
		vo.setMainPhoto(mainPhoto);

		System.out.println(vo);
		
		tourAddService.modify(vo);
		
		return "redirect:/{id}/tour?idx="+vo.getIdx();
		
	}*/
	
}
