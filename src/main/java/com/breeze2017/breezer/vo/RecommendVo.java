package com.breeze2017.breezer.vo;

public class RecommendVo {
	private long idx;
	private String photo;
	private String content;
	private String location;
	private float lat;
	private float lot;
	
	public RecommendVo() {}
	
	public RecommendVo(long idx, String photo, String content, String location, float lat, float lot) {
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

	public float getLat() {
		return lat;
	}

	public void setLat(float lat) {
		this.lat = lat;
	}

	public float getLot() {
		return lot;
	}

	public void setLot(float lot) {
		this.lot = lot;
	}

	@Override
	public String toString() {
		return "RecommendVo [idx=" + idx + ", photo=" + photo + ", content=" + content + ", location=" + location
				+ ", lat=" + lat + ", lot=" + lot + "]";
	}
	
}
