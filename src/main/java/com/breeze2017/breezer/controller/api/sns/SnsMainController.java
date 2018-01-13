package com.breeze2017.breezer.controller.api.sns;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.sns.SnsMainService;
import com.breeze2017.breezer.vo.SNSVo;

@Controller("SnsMainApi")
@RequestMapping("/api/sns")
public class SnsMainController {

	@Autowired
	private SnsMainService snsMainService;
	
	@ResponseBody
	@RequestMapping("/list")
	public JSONResult list(
			@RequestParam( value="idx", required=true, defaultValue="0") long idx) {
		System.out.println("====== /api/sns/list : idx : "+idx+" ======");
		List<SNSVo> list = snsMainService.getListMessage(idx);
		return JSONResult.success(list);
	}
	
	
	@ResponseBody
	@RequestMapping("/dolike")
	public JSONResult dolike(
			@RequestParam("id") String id,
			@RequestParam("flag") String flag,
			@RequestParam("type") String type,
			@RequestParam("idx") long idx ) {
		
		System.out.println("====== /api/sns/dolike ======");
		System.out.println("id : "+id+", flag : "+flag+", type : "+type+", idx : "+idx);
		snsMainService.doLikeMessage(id, flag, type, idx);
		
		
		
		return JSONResult.success("");
	}
}
