package com.breeze2017.breezer.vo;

public class TourVo {
	private long idx;
	private String userId;
	private long seq;
	private String title;
	private String startDate;
	private String endDate;
	private double score;
	private String mainPhoto;
	private long postCount;
	private long hit;
	private int secret; //1 : true, 0: false
	private int rn;
	
	
	
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
	public long getSeq() {
		return seq;
	}
	public void setSeq(long seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public String getMainPhoto() {
		return mainPhoto;
	}
	public void setMainPhoto(String mainPhoto) {
		this.mainPhoto = mainPhoto;
	}
	public long getPostCount() {
		return postCount;
	}
	public void setPostCount(long postCount) {
		this.postCount = postCount;
	}
	public long getHit() {
		return hit;
	}
	public void setHit(long hit) {
		this.hit = hit;
	}
	public int getSecret() {
		return secret;
	}
	public void setSecret(int secret) {
		this.secret = secret;
	}
	public int getRn() {
		return rn;
	}
	public void setRn(int rn) {
		this.rn = rn;
	}
	@Override
	public String toString() {
		return "TourVo [idx=" + idx + ", userId=" + userId + ", seq=" + seq + ", title=" + title + ", startDate="
				+ startDate + ", endDate=" + endDate + ", score=" + score + ", mainPhoto=" + mainPhoto + ", postCount="
				+ postCount + ", hit=" + hit + ", secret=" + secret + ", rn=" + rn + "]";
	}
	
	
	
	
	
	
	
	
	
	
	
}
