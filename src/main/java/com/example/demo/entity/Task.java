package com.example.demo.entity;

import java.util.Date;
import java.util.List;
import java.util.Map;

public class Task {
	private int task_id;
	private String task_desc;
	private java.util.Date given_date;
	private java.util.Date deadline;
	private int given_by;
	private int status;
	private Date done_on;

	private List<Map<String  , Object>> employeeList;


    public Task(Map<String,Object> arr)
    {   
		this.task_id = (int) arr.get("task_id");
		this.task_desc = (String) arr.get("task_desc");
		this.given_date = (Date) arr.get("given_date");
		this.deadline = (Date) arr.get("deadline");
		this.given_by = (int) arr.get("given_by");
		this.status = (int) arr.get("status");
		this.done_on = (Date) arr.get("done_on");
    }


	public int getTask_id(){
		return task_id;
	}

	public void setTask_id(int task_id){
		this.task_id=task_id;
	}

	public String getTask_desc(){
		return task_desc;
	}

	public void setTask_desc(String task_desc){
		this.task_desc=task_desc;
	}

	public java.util.Date getGiven_date(){
		return given_date;
	}

	public void setGiven_date(java.util.Date given_date){
		this.given_date=given_date;
	}

	public java.util.Date getDeadline(){
		return deadline;
	}

	public void setDeadline(java.util.Date deadline){
		this.deadline=deadline;
	}

	public int getGiven_by(){
		return given_by;
	}

	public void setGiven_by(int given_by){
		this.given_by=given_by;
	}

	public int getStatus(){
		return status;
	}

	public void setStatus(int status){
		this.status=status;
	}

	public Date getDone_on(){
		return done_on;
	}

	public void setDone_on(Date done_on){
		this.done_on=done_on;
	}

	public List<Map<String  , Object>> getEmployeeList(){
		return employeeList;
	}

	public void setEmployeeList(List<Map<String  , Object>> empList){
		this.employeeList = empList;
	}
}