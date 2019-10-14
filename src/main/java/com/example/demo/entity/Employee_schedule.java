package com.example.demo.entity;

public class Employee_schedule{
	private java.util.Date SCHEDULE_DATE;
	private int EMPLOYEEID;
	private int TIME_SLOT1;
	private int TIME_SLOT2;
	private int TIME_SLOT3;
	private int TIME_SLOT4;

	public java.util.Date getSchedule_date(){
		return SCHEDULE_DATE;
	}

	public void setSchedule_date(java.util.Date SCHEDULE_DATE){
		this.SCHEDULE_DATE=SCHEDULE_DATE;
	}

	public int getEmployeeid(){
		return EMPLOYEEID;
	}

	public void setEmployeeid(int EMPLOYEEID){
		this.EMPLOYEEID=EMPLOYEEID;
	}

	public int getTime_slot1(){
		return TIME_SLOT1;
	}

	public void setTime_slot1(int TIME_SLOT1){
		this.TIME_SLOT1=TIME_SLOT1;
	}

	public int getTime_slot2(){
		return TIME_SLOT2;
	}

	public void setTime_slot2(int TIME_SLOT2){
		this.TIME_SLOT2=TIME_SLOT2;
	}

	public int getTime_slot3(){
		return TIME_SLOT3;
	}

	public void setTime_slot3(int TIME_SLOT3){
		this.TIME_SLOT3=TIME_SLOT3;
	}

	public int getTime_slot4(){
		return TIME_SLOT4;
	}

	public void setTime_slot4(int TIME_SLOT4){
		this.TIME_SLOT4=TIME_SLOT4;
	}
}