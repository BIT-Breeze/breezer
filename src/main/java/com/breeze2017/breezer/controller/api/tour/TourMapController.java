package com.breeze2017.breezer.controller.api.tour;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.tour.TourMapService;
import com.breeze2017.breezer.vo.MapVo;

@Controller("tourMapAPIController")
@RequestMapping("/api/tour")
public class TourMapController {
	
	@Autowired
	private TourMapService tourMapService;
	
	@ResponseBody
	@RequestMapping("/location")
	public JSONResult getData() {
		List<MapVo> info = tourMapService.getData();
		
		return JSONResult.success(info);
	}

}
