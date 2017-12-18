package com.breeze2017.breezer.vo;

public class UserVo {
	private long idx;
	private String fbId;
	private String id;
	private String nickName;
	private String birth;
	private String job;
	private String joinDate;
	private String role;
	private String token;
	private String signedRequest;
	private String expiresIn;
	private String email;
	private String gender;
	private String ageRange;
	private String locale;
	private String pictureUrl;
	
	
	public long getIdx() {
		return idx;
	}
	public void setIdx(long idx) {
		this.idx = idx;
	}
	public String getFbId() {
		return fbId;
	}
	public void setFbId(String fbId) {
		this.fbId = fbId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public String getSignedRequest() {
		return signedRequest;
	}
	public void setSignedRequest(String signedRequest) {
		this.signedRequest = signedRequest;
	}
	public String getExpiresIn() {
		return expiresIn;
	}
	public void setExpiresIn(String expiresIn) {
		this.expiresIn = expiresIn;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getAgeRange() {
		return ageRange;
	}
	public void setAgeRange(String ageRange) {
		this.ageRange = ageRange;
	}
	public String getLocale() {
		return locale;
	}
	public void setLocale(String locale) {
		this.locale = locale;
	}
	public String getPictureUrl() {
		return pictureUrl;
	}
	public void setPictureUrl(String pictureUrl) {
		this.pictureUrl = pictureUrl;
	}
	@Override
	public String toString() {
		return "UserVo [idx=" + idx + ", fbId=" + fbId + ", id=" + id + ", nickName=" + nickName + ", birth=" + birth
				+ ", job=" + job + ", joinDate=" + joinDate + ", role=" + role + ", token=" + token + ", signedRequest="
				+ signedRequest + ", expiresIn=" + expiresIn + ", email=" + email + ", gender=" + gender + ", ageRange="
				+ ageRange + ", locale=" + locale + ", pictureUrl=" + pictureUrl + "]";
	}
	
	
	
	

	
	
}
