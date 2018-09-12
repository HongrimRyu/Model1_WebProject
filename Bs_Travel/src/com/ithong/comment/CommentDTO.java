package com.ithong.comment;

import java.sql.Timestamp;

public class CommentDTO {
	private int board_id;
	private int idx;
	private int comment_idx;
	private String id;
	private int c_idx;
	private int c_lev;
	private int c_seq;
	private String content;
	private String ip;
	private Timestamp crate_date;
	private String modifyIP;
	private String modifyID;
	private Timestamp modifyDate;
	private String legacy_content;
	private String del_state;
	private String ref_id;
	
	public String getRef_id() {
		return ref_id;
	}
	public void setRef_id(String ref_id) {
		this.ref_id = ref_id;
	}
	public String getDel_state() {
		return del_state;
	}
	public void setDel_state(String del_state) {
		this.del_state = del_state;
	}
	public String getLegacy_content() {
		return legacy_content;
	}
	public void setLegacy_content(String legacy_content) {
		this.legacy_content = legacy_content;
	}
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public int getComment_idx() {
		return comment_idx;
	}
	public void setComment_idx(int comment_idx) {
		this.comment_idx = comment_idx;
	}
	public int getC_idx() {
		return c_idx;
	}
	public void setC_idx(int c_idx) {
		this.c_idx = c_idx;
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
	public int getC_lev() {
		return c_lev;
	}
	public void setC_lev(int c_lev) {
		this.c_lev = c_lev;
	}
	public int getC_seq() {
		return c_seq;
	}
	public void setC_seq(int c_seq) {
		this.c_seq = c_seq;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public Timestamp getCrate_date() {
		return crate_date;
	}
	public void setCrate_date(Timestamp crate_date) {
		this.crate_date = crate_date;
	}
	public String getModifyIP() {
		return modifyIP;
	}
	public void setModifyIP(String modifyIP) {
		this.modifyIP = modifyIP;
	}
	public String getModifyID() {
		return modifyID;
	}
	public void setModifyID(String modifyID) {
		this.modifyID = modifyID;
	}
	public Timestamp getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(Timestamp modifyDate) {
		this.modifyDate = modifyDate;
	}
	
}
