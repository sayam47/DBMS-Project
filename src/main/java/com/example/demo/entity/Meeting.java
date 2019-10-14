package com.example.demo.entity;

public class Meeting{
	private int MEETINGID;
	private int MEET_SLOT;
	private String PLACE;
	private int RATING;
	private int EMPLOYEEID;
	private int CUSTOMERID;

	public int getMeetingid(){
		return MEETINGID;
	}

	public void setMeetingid(int MEETINGID){
		this.MEETINGID=MEETINGID;
	}

	public int getMeet_slot(){
		return MEET_SLOT;
	}

	public void setMeet_slot(int MEET_SLOT){
		this.MEET_SLOT=MEET_SLOT;
	}

	public String getPlace(){
		return PLACE;
	}

	public void setPlace(String PLACE){
		this.PLACE=PLACE;
	}

	public int getRating(){
		return RATING;
	}

	public void setRating(int RATING){
		this.RATING=RATING;
	}

	public int getEmployeeid(){
		return EMPLOYEEID;
	}

	public void setEmployeeid(int EMPLOYEEID){
		this.EMPLOYEEID=EMPLOYEEID;
	}

	public int getCustomerid(){
		return CUSTOMERID;
	}

	public void setCustomerid(int CUSTOMERID){
		this.CUSTOMERID=CUSTOMERID;
	}
}