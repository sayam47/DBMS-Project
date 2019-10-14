package com.example.demo.entity;

public class Expenses{
	private int EXPENSEID;
	private java.util.Date DATE;
	private int ADDEDBY;

	public int getExpenseid(){
		return EXPENSEID;
	}

	public void setExpenseid(int EXPENSEID){
		this.EXPENSEID=EXPENSEID;
	}

	public java.util.Date getDate(){
		return DATE;
	}

	public void setDate(java.util.Date DATE){
		this.DATE=DATE;
	}

	public int getAddedby(){
		return ADDEDBY;
	}

	public void setAddedby(int ADDEDBY){
		this.ADDEDBY=ADDEDBY;
	}
}