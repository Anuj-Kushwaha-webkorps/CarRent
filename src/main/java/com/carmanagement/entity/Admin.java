package com.carmanagement.entity;

public class Admin {
	String name;
	String email;
	String address;
	String password;
	String company_name;
	
	public Admin(){		
	}
	
	public Admin(String name, String email, String password, String address, String company_name){
		this.name = name;
		this.email = email;
		this.password = password;
		this.address = address;
		this.company_name = company_name;
	}
	
	// setter methods
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	
	// getter methods
	
	public String getName() {
		return this.name;
	}
	
	public String getEmail() {
		return this.email;
	}
	
	public String getPassword() {
		return this.password;
	}
	
	public String getAddress() {
		return this.address;
	}
	
	public String getCompany_name() {
		return this.company_name;
	}
}
