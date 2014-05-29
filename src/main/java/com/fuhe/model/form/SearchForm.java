package com.fuhe.model.form;

import java.io.UnsupportedEncodingException;

public class SearchForm {

	private String keyword;
	
	private String address;
	
	private String dateLoop;//时间区间
	
	private String industry;

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDateLoop() {
		return dateLoop;
	}

	public void setDateLoop(String dateLoop) {
		this.dateLoop = dateLoop;
	}

	public String getIndustry() {
		return industry;
	}

	public void setIndustry(String industry) {
		this.industry = industry;
	}
	
	
}
