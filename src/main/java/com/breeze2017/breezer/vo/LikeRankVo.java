package com.breeze2017.breezer.vo;

public class LikeRankVo {
	private long idx;
	private long count;
	private String kind;
	private String insertDateTime;
	private long tourIdx; // post일 경우만 
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
	
	@Override
	public String toString() {
		return "LikeRankVo [idx=" + idx + ", count=" + count + ", kind=" + kind + ", insertDateTime=" + insertDateTime
				+ ", tourIdx=" + tourIdx + "]";
	}
	
	
	

}
