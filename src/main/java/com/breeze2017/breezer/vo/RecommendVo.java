package com.breeze2017.breezer.vo;

public class RecommendVo {
	private String userId;
	private double lat;
	private double lot;
	
	public RecommendVo() {}
	
	public RecommendVo(String userId, double lat, double lot) {
		this.userId = userId;
		this.lat = lat;
		this.lot = lot;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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
		return "RecommendVo [userId=" + userId + ", lat=" + lat + ", lot=" + lot + "]";
	}
	
}
