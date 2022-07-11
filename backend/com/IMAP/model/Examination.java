package com.IMAP.model;

import javax.servlet.http.Part;

public class Examination {
	private int id;
	private int user_id;
	private int sub_id;
	private int dept_id;
	private String year;
	private int duration;
	private String name;

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	private Part qsn;

	private String[] qsn_name;

	public String[] getQsn_name() {
		return qsn_name;
	}

	public void setQsn_name(String[] qsn_name) {
		this.qsn_name = qsn_name;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getSub_id() {
		return sub_id;
	}

	public void setSub_id(int sub_id) {
		this.sub_id = sub_id;
	}

	public int getDept_id() {
		return dept_id;
	}

	public void setDept_id(int dept_id) {
		this.dept_id = dept_id;
	}

	public Part getQsn() {
		return qsn;
	}

	public void setQsn(Part qsn) {
		this.qsn = qsn;
	}
}
