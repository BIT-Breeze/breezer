package com.breeze2017.breezer.vo;

public class RecommendVo {
	private long idx;
	private String photo;
	private String content;
	private String location;
	private double lat;
	private double lot;
	
	public RecommendVo() {}
	
	public RecommendVo(long idx, String photo, String content, String location, double lat, double lot) {
		this.idx = idx;
		this.photo = photo;
		this.content = content;
		this.location = location;
		this.lat = lat;
		this.lot = lot;
	}

	public long getIdx() {
		return idx;
	}

	public void setIdx(long idx) {
		this.idx = idx;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public double getLat() {
		return lat;
	}

	public void setLat(double lat) {
		this.lat = lat;
	}

	public double getLot() {
		return lot;
	}

	public void setLot(double lot) {
		this.lot = lot;
	}

	@Override
	public String toString() {
		return "RecommendVo [idx=" + idx + ", photo=" + photo + ", content=" + content + ", location=" + location
				+ ", lat=" + lat + ", lot=" + lot + "]";
	}
	
}
