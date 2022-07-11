package com.IMAP.model;

import javax.servlet.http.Part;

public class Answer {
	private int id;
	private int user_id;

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getFile_id() {
		return file_id;
	}

	public void setFile_id(int file_id) {
		this.file_id = file_id;
	}

	public String[] getAns_name() {
		return ans_name;
	}

	public void setAns_name(String[] ans_name) {
		this.ans_name = ans_name;
	}

	public Part getAns() {
		return ans;
	}

	public void setAns(Part ans) {
		this.ans = ans;
	}

	private int file_id;
	private String[] ans_name;
	private Part ans;
}
