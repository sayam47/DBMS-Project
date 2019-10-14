package com.example.demo.entity;

public class Customer{
	private int customer_id;
	private String first_name;
	private String last_name;
	private String city;
	private String state;
	private int revenue;
	private String industry;
	private String gender;

	public Customer()
	{

	}

	public Customer(int cid , String fname , String lname , String city , String state , String industry , int revenue , String gender)
	{
		this.customer_id = cid;
		this.first_name = fname;
		this.last_name = lname;
		this.city = city;
		this.state = state;
		this.industry = industry;
		this.revenue = revenue;
		this.gender = gender;
	}

	public int getCustomer_id(){
		return customer_id;
	}

	public void setCustomer_id(int customer_id){
		this.customer_id=customer_id;
	}

	public String getFirst_name(){
		return first_name;
	}

	public void setFirst_name(String first_name){
		this.first_name=first_name;
	}

	public String getLast_name(){
		return last_name;
	}

	public void setLast_name(String last_name){
		this.last_name=last_name;
	}

	public String getCity(){
		return city;
	}

	public void setCity(String city){
		this.city=city;
	}

	public String getState(){
		return state;
	}

	public void setState(String state){
		this.state=state;
	}

	public int getRevenue(){
		return revenue;
	}

	public void setRevenue(int revenue){
		this.revenue=revenue;
	}

	public String getIndustry(){
		return industry;
	}

	public void setIndustry(String industry){
		this.industry=industry;
	}

	public String getGender(){
		return gender;
	}

	public void setGender(String gender){
		this.gender=gender;
	}
}