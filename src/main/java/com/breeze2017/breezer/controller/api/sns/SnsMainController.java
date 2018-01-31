package com.breeze2017.breezer.controller.api.sns;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.sns.SnsMainService;
import com.breeze2017.breezer.vo.LikeRankVo;
import com.breeze2017.breezer.vo.SNSVo;

@Controller("SnsMainApi")
@RequestMapping("/api/sns")
public class SnsMainController {

	@Autowired
	private SnsMainService snsMainService;
	
	@ResponseBody
	@RequestMapping("/list")
	public JSONResult list(
			@RequestParam( value="idx", required=true, defaultValue="0") long idx,
			@RequestParam("userid") String userId) {
		System.out.println("====== /api/sns/list : idx : "+idx+", id : "+userId+" ======");
		
		// 그뭐냐.. 해당 포스트의 내가 좋아요를 했는지 알려면 내 아이디를 보내줘야해.. 그래서 맵 사용
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("idx", idx);
		map.put("myid", userId);
		
		List<SNSVo> list = snsMainService.getListMessage(map);
		return JSONResult.success(list);
	}
	
	
	@ResponseBody
	@RequestMapping("/dolike")
	public JSONResult dolike(
			@RequestParam("id") String id,
			@RequestParam("flag") String flag, // up or down
			@RequestParam("type") String type, // tour or post
			@RequestParam("idx") long idx ) {  
		
		System.out.println("====== /api/sns/dolike ======");
		System.out.println("id : "+id+", flag : "+flag+", type : "+type+", idx : "+idx);
		snsMainService.doLikeMessage(id, flag, type, idx);
		
		
		
		return JSONResult.success("");
	}
	
	@ResponseBody
	@RequestMapping("/likerank")
	public JSONResult likerank(
			@RequestParam( value="interval", required=true, defaultValue="-1") int interval ) {
		System.out.println("====== /api/sns/likerank -> interval : "+interval+" ======");
		
		List<LikeRankVo> list = snsMainService.getLikeRankMessage(interval);
		
		
		return JSONResult.success(list);
	}
}
