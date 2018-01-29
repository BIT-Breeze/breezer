package com.breeze2017.breezer.vo;


public class SNSVo {
	
	private String kind; // tour, post 구분
	private long idx;
	private long tourIdx; // tour/post 에 따른 idx
	private long postIdx;
	private String userId;
	private String nickName;
	private String title;
	private String content;
	private String photo;
	private String startDate;
	private String endDate;
	private double score;
	private double price;
	private long favorite;
	private String postDateTime;
	private String tripDateTime;
	private String location;
	private String pictureUrl;
	private int favoCount;
	private int postCount;
	
	
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public long getIdx() {
		return idx;
	}
	public void setIdx(long idx) {
		this.idx = idx;
	}
	public long getTourIdx() {
		return tourIdx;
	}
	public void setTourIdx(long tourIdx) {
		this.tourIdx = tourIdx;
	}
	public long getPostIdx() {
		return postIdx;
	}
	public void setPostIdx(long postIdx) {
		this.postIdx = postIdx;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public long getFavorite() {
		return favorite;
	}
	public void setFavorite(long favorite) {
		this.favorite = favorite;
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
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getPictureUrl() {
		return pictureUrl;
	}
	public void setPictureUrl(String pictureUrl) {
		this.pictureUrl = pictureUrl;
	}
	
	
	
	public int getFavoCount() {
		return favoCount;
	}
	public void setFavoCount(int favoCount) {
		this.favoCount = favoCount;
	}
	
	
	
	public int getPostCount() {
		return postCount;
	}
	public void setPostCount(int postCount) {
		this.postCount = postCount;
	}
	@Override
	public String toString() {
		return "SNSVo [kind=" + kind + ", idx=" + idx + ", tourIdx=" + tourIdx + ", postIdx=" + postIdx + ", userId="
				+ userId + ", nickName=" + nickName + ", title=" + title + ", content=" + content + ", photo=" + photo
				+ ", startDate=" + startDate + ", endDate=" + endDate + ", score=" + score + ", price=" + price
				+ ", favorite=" + favorite + ", postDateTime=" + postDateTime + ", tripDateTime=" + tripDateTime
				+ ", location=" + location + ", pictureUrl=" + pictureUrl + ", favoCount=" + favoCount + ", postCount="
				+ postCount + "]";
	}


	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
