package com.laptrinhjavaweb.model;

import java.util.ArrayList;
import java.util.List;

public class AbstractClass<T> {
    private int id;
    private List<T> listResult = new ArrayList<>();
    

    public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public List<T> getListResult() {
		return listResult;
	}
	public void setListResult(List<T> listResult) {
		this.listResult = listResult;
	}
}
