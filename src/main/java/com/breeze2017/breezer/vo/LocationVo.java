package com.breeze2017.breezer.vo;

public class LocationVo {
	private double lat;
	private double lot;
	
	public LocationVo() {}
	
	public LocationVo(double lat, double lot) {
		this.lat = lat;
		this.lot = lot;
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
		return "LocationVo [lat=" + lat + ", lot=" + lot + "]";
	}

}
