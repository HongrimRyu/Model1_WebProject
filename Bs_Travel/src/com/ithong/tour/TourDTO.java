package com.ithong.tour;

import java.sql.Timestamp;

public class TourDTO {

	private int idx;
	private String id;
	private String name;
	private String course;
	private String purpose;
	private String tour_date;
	private String phone;
	
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getTour_date() {
		return tour_date;
	}
	public void setTour_date(String tour_date) {
		this.tour_date = tour_date;
	}
	private String member;
	private String memo;
	private Timestamp submit_date;
	private String email;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCourse() {
		return course;
	}
	public void setCourse(String course) {
		this.course = course;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public String getMember() {
		return member;
	}
	public void setMember(String member) {
		this.member = member;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public Timestamp getSubmit_date() {
		return submit_date;
	}
	public void setSubmit_date(Timestamp submit_date) {
		this.submit_date = submit_date;
	}
	
	
	
}
