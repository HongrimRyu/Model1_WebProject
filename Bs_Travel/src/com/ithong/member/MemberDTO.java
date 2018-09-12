package com.ithong.member;

import java.sql.Timestamp;

public class MemberDTO {
	private String id;
	private String pass;
	private String nick;
	private String name;
	private int age;	
	private String gender;
	private String email;
	private String addr;
	private String Phone;
	private String creip;
	private Timestamp reg_date;
	private Timestamp exdate;
	private String modifyip;
	private String modifyid;
	private Timestamp modifydate;
	private String change_pw_date;
	private String legacy_pw;
	public String getId() {
		return id;
	}
	public String getLegacy_pw() {
		return legacy_pw;
	}
	public void setLegacy_pw(String legacy_pw) {
		this.legacy_pw = legacy_pw;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getPhone() {
		return Phone;
	}
	public void setPhone(String phone) {
		Phone = phone;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public Timestamp getExdate() {
		return exdate;
	}
	public void setExdate(Timestamp exdate) {
		this.exdate = exdate;
	}
	public String getModifyip() {
		return modifyip;
	}
	public void setModifyip(String modifyip) {
		this.modifyip = modifyip;
	}
	public String getModifyid() {
		return modifyid;
	}
	public void setModifyid(String modifyid) {
		this.modifyid = modifyid;
	}
	public Timestamp getModifydate() {
		return modifydate;
	}
	public void setModifydate(Timestamp modifydate) {
		this.modifydate = modifydate;
	}
	public String getChange_pw_date() {
		return change_pw_date;
	}
	public void setChange_pw_date(String change_pw_date) {
		this.change_pw_date = change_pw_date;
	}

	public String getCreip() {
		return creip;
	}
	public void setCreip(String creip) {
		this.creip = creip;
	}

}
