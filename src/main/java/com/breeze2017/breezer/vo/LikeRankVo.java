package com.breeze2017.breezer.vo;

public class LikeRankVo {
	private long idx;
	private long count;
	private String kind;
	private String insertDateTime;
	private long tourIdx; // post일 경우만 
	private String title; //tour=title, post=content
	private String userId;
	
	public long getIdx() {
		return idx;
	}
	public void setIdx(long idx) {
		this.idx = idx;
	}
	public long getCount() {
		return count;
	}
	public void setCount(long count) {
		this.count = count;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getInsertDateTime() {
		return insertDateTime;
	}
	public void setInsertDateTime(String insertDateTime) {
		this.insertDateTime = insertDateTime;
	}
	public long getTourIdx() {
		return tourIdx;
	}
	public void setTourIdx(long tourIdx) {
		this.tourIdx = tourIdx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "LikeRankVo [idx=" + idx + ", count=" + count + ", kind=" + kind + ", insertDateTime=" + insertDateTime
				+ ", tourIdx=" + tourIdx + ", title=" + title + ", userId=" + userId + "]";
	}
	
	
	
	
	
	
	
	

}
