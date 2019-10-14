package com.example.demo.entity;

public class Employee_contact{
	private String CONTACT_NUMBER;
	private int EMPLOYEEID;

	public String getContact_number(){
		return CONTACT_NUMBER;
	}

	public void setContact_number(String CONTACT_NUMBER){
		this.CONTACT_NUMBER=CONTACT_NUMBER;
	}

	public int getEmployeeid(){
		return EMPLOYEEID;
	}

	public void setEmployeeid(int EMPLOYEEID){
		this.EMPLOYEEID=EMPLOYEEID;
	}
}