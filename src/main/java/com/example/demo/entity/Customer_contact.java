package com.example.demo.entity;

public class Customer_contact{
	private String CONTACT_NUMBER;
	private int CUSTOMERID;

	public String getContact_number(){
		return CONTACT_NUMBER;
	}

	public void setContact_number(String CONTACT_NUMBER){
		this.CONTACT_NUMBER=CONTACT_NUMBER;
	}

	public int getCustomerid(){
		return CUSTOMERID;
	}

	public void setCustomerid(int CUSTOMERID){
		this.CUSTOMERID=CUSTOMERID;
	}
}