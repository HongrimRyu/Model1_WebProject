package com.ithong.board;

import java.sql.Timestamp;

public class BoardDTO {
	private int board_id;
	private int board_number;
	private int idx;
	private String id;
	private String subject;
	private String content;
	private String create_ip;
	private Timestamp create_date;
	private int re_ref;
	private int re_lev;
	private int re_seq;
	private int re_depth;
	private String modify_id;
	private String modify_ip;
	private Timestamp modify_date;
	private int read_count;
	private String file;
	private boolean del_state;
	
	
	public int getRe_depth() {
		return re_depth;
	}
	public void setRe_depth(int re_depth) {
		this.re_depth = re_depth;
	}
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public int getBoard_number() {
		return board_number;
	}
	public void setBoard_number(int board_number) {
		this.board_number = board_number;
	}
	public boolean isDel_state() {
		return del_state;
	}
	public void setDel_state(boolean del_state) {
		this.del_state = del_state;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public int getRead_count() {
		return read_count;
	}
	public void setRead_count(int read_count) {
		this.read_count = read_count;
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
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreate_ip() {
		return create_ip;
	}
	public void setCreate_ip(String create_ip) {
		this.create_ip = create_ip;
	}
	public Timestamp getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Timestamp create_date) {
		this.create_date = create_date;
	}
	public int getRe_ref() {
		return re_ref;
	}
	public void setRe_ref(int re_ref) {
		this.re_ref = re_ref;
	}
	public int getRe_lev() {
		return re_lev;
	}
	public void setRe_lev(int re_lev) {
		this.re_lev = re_lev;
	}
	public int getRe_seq() {
		return re_seq;
	}
	public void setRe_seq(int re_seq) {
		this.re_seq = re_seq;
	}
	public String getModify_id() {
		return modify_id;
	}
	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}
	public String getModify_ip() {
		return modify_ip;
	}
	public void setModify_ip(String modify_ip) {
		this.modify_ip = modify_ip;
	}
	public Timestamp getModify_date() {
		return modify_date;
	}
	public void setModify_date(Timestamp modify_date) {
		this.modify_date = modify_date;
	}
}
