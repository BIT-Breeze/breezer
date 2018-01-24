package com.breeze2017.breezer.controller.api.tour;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.tour.TourMapService;
import com.breeze2017.breezer.vo.MapVo;
import com.breeze2017.breezer.vo.PostVo;

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
	
	@ResponseBody
	@RequestMapping("/getmapinfo")
	public JSONResult getMapInfo(@ModelAttribute PostVo postVo) {
		List<PostVo> info = tourMapService.getMapInfo(postVo);
		System.out.println("gh : " + info.toString());
		
		if (info.size() == 0) {
			return JSONResult.fail("데이터 로딩에 실패했습니다.");
		} 
		
		return JSONResult.success(info);
	}

}
