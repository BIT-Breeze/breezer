package com.breeze2017.breezer.vo;

public class MapVo {
	private long idx;
	private String name;
	private String image;
	private double lat;
	private double lot;
	
	public MapVo() {}

	public MapVo(long idx, String name, String image, double lat, double lot) {
		this.idx = idx;
		this.name = name;
		this.image = image;
		this.lat = lat;
		this.lot = lot;
	}

	public long getIdx() {
		return idx;
	}

	public void setIdx(long idx) {
		this.idx = idx;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
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
		return "MapVo [idx=" + idx + ", name=" + name + ", image=" + image + ", lat=" + lat + ", lot=" + lot + "]";
	}
	
}
