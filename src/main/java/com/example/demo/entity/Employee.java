package com.example.demo.entity;

public class Employee{
	private int employee_id;
	private String first_name;
	private String last_name;
	private String designation;
	private java.util.Date date_of_birth;

	public int getEmployee_id(){
		return employee_id;
	}

	public void setEmployee_id(int employee_id){
		this.employee_id=employee_id;
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

	public String getDesignation(){
		return designation;
	}

	public void setDesignation(String designation){
		this.designation=designation;
	}

	public java.util.Date getDate_of_birth(){
		return date_of_birth;
	}

	public void setDate_of_birth(java.util.Date date_of_birth){
		this.date_of_birth=date_of_birth;
	}
}