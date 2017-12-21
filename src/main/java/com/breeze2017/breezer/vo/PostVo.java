package com.breeze2017.breezer.vo;

public class PostVo {
	private long idx;
	private String id;
	private String postDate;
	private String tripDate;
	private String photo;
	private String content;
	private String location;
	private String locale;
	private double lat;
	private double lon;
	private long tourIdx;
	private String category;
	private double price;
	private double score;
	private long like;
	public long getIdx() {
		return idx;
	}
	public void setIdx(long idx) {
		this.idx = idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPostDate() {
		return postDate;
	}
	public void setPostDate(String postDate) {
		this.postDate = postDate;
	}
	public String getTripDate() {
		return tripDate;
	}
	public void setTripDate(String tripDate) {
		this.tripDate = tripDate;
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
	public String getLocale() {
		return locale;
	}
	public void setLocale(String locale) {
		this.locale = locale;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLon() {
		return lon;
	}
	public void setLon(double lon) {
		this.lon = lon;
	}
	public long getTourIdx() {
		return tourIdx;
	}
	public void setTourIdx(long tourIdx) {
		this.tourIdx = tourIdx;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public long getLike() {
		return like;
	}
	public void setLike(long like) {
		this.like = like;
	}
	
	
	@Override
	public String toString() {
		return "PostVo [idx=" + idx + ", id=" + id + ", postDate=" + postDate + ", tripDate=" + tripDate + ", photo="
				+ photo + ", content=" + content + ", location=" + location + ", locale=" + locale + ", lat=" + lat
				+ ", lon=" + lon + ", tourIdx=" + tourIdx + ", category=" + category + ", price=" + price + ", score="
				+ score + ", like=" + like + "]";
	}
	
	
	
	
	
	
	

}
