package com.yar9.learn;

public class District {
	public int id;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String name;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public District(int id, String name) {
		super();
		this.id = id;
		this.name = name;
	}
	public District() {
		// TODO Auto-generated constructor stub
	}
	
}
