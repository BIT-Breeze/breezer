package com.breeze2017.breezer.vo;

public class PostVo {
	private long idx;
	private String userId;
	private String postDateTime;
	private String tripDateTime;
	private String photo;
	private String content;
	private String location;
	private String locale;
	private double lat;
	private double lot;
	private long tourIdx;
	private String category;
	private double price;
	private double score;
	private long favorite;
	private long dateGap;
	public long getIdx() {
		return idx;
	}
	public void setIdx(long idx) {
		this.idx = idx;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPostDateTime() {
		return postDateTime;
	}
	public void setPostDateTime(String postDateTime) {
		this.postDateTime = postDateTime;
	}
	public String getTripDateTime() {
		return tripDateTime;
	}
	public void setTripDateTime(String tripDateTime) {
		this.tripDateTime = tripDateTime;
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
	public double getLot() {
		return lot;
	}
	public void setLot(double lot) {
		this.lot = lot;
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
	public long getFavorite() {
		return favorite;
	}
	public void setFavorite(long favorite) {
		this.favorite = favorite;
	}
	public long getDateGap() {
		return dateGap;
	}
	public void setDateGap(long dateGap) {
		this.dateGap = dateGap;
	}
	@Override
	public String toString() {
		return "PostVo [idx=" + idx + ", userId=" + userId + ", postDateTime=" + postDateTime + ", tripDateTime="
				+ tripDateTime + ", photo=" + photo + ", content=" + content + ", location=" + location + ", locale="
				+ locale + ", lat=" + lat + ", lot=" + lot + ", tourIdx=" + tourIdx + ", category=" + category
				+ ", price=" + price + ", score=" + score + ", favorite=" + favorite + ", dateGap=" + dateGap + "]";
	}
	
	
}
