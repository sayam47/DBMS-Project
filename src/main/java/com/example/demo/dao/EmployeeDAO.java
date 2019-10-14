package com.example.demo.dao;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.entity.Employee;
import com.example.demo.entity.EmployeeRowMapper;

@Transactional
@Repository
public class EmployeeDAO {

    @Autowired
    JdbcTemplate template;

    public int save(Employee p) {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String sql = "insert into Employee(employee_id , first_name , last_name , designation , date_of_birth ) values ("
                + p.getEmployee_id() + " , '" + p.getFirst_name() + "','" + p.getLast_name() + "','"
                + p.getDesignation() + "','" + formatter.format(p.getDate_of_birth()) + "')";
        return template.update(sql);
    }

    public Map<String, Object> getEmpById(int id) {
        String sql = "select * from Employee where employee_id=?";
        Map<String, Object> e = template.queryForMap(sql, id);
        String sql1 = "select contact_number from Employee_contact where employee_id = ?";
        e.put("contact_no", template.queryForList(sql1, id));
        String sql2 = "select email_id from Employee_email where employee_id = ?";
        e.put("email_id", template.queryForList(sql2, id));
        return e;
    }

    public List<Employee> getAllEmployees() {
        String sql = "SELECT * FROM Employee";
        // RowMapper<Article> rowMapper = new
        // BeanPropertyRowMapper<Article>(Article.class);
        RowMapper<Employee> rowMapper = new EmployeeRowMapper();
        return template.query(sql, rowMapper);
    }

    public void saveContacts(int customer_id, List<String> contact) {
        String sql = "insert into Employee_contact(employee_id , contact_number) values ";
        if (contact == null || contact.size() == 0)
            return;
        Set<String> set = new HashSet<String>(contact);
        for (String c : set)
            sql += " (" + customer_id + " , '" + c + "' ) ,";
        sql = sql.substring(0, sql.length() - 1);
        template.update(sql);
    }

    public void saveEmail(int customer_id, List<String> email) {
        String sql = "insert into Employee_email(employee_id , email_id) values ";
        if (email == null || email.size() == 0)
            return;
        Set<String> set = new HashSet<String>(email);
        for (String c : set)
            sql += " (" + customer_id + " , '" + c + "' ) ,";
        sql = sql.substring(0, sql.length() - 1);
        template.update(sql);
    }

    public List<Map<String, Object>> getUpcomingMeeting(int customer_id) throws ParseException
    {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();  
        String sql = "select meeting_id , minutes , start_time , end_time , rating , m.employee_id  , m.customer_id, first_name , last_name from Customer e , Meeting m where e.customer_id = m.customer_id and start_time > ?  and employee_id = ?";
        List<Map<String, Object>> slist = template.queryForList(sql, formatter.format(date) ,customer_id);
        for(Map<String, Object> s : slist)
        {
            String sql1 = "select contact_number from Customer_contact where customer_id = ?";
            s.put("contact_no" , template.queryForList(sql1 , s.get("customer_id")));
            String sql2 = "select email_id from Customer_email where customer_id = ?";
            s.put("email_id" , template.queryForList(sql2 , s.get("customer_id")));
            s.put("start_time", formatter.parse(s.get("start_time").toString()));
            s.put("end_time", formatter.parse(s.get("end_time").toString()));
        }
        return slist;
    }

    public List<Map<String , Object > > getPastMeeting(int customer_id) throws ParseException
    {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();  
        String sql = "select meeting_id , minutes , start_time , end_time , rating , m.employee_id , m.customer_id , first_name , last_name from Customer e , Meeting m where e.customer_id = m.customer_id and start_time <= ?  and employee_id = ?";
        List<Map<String, Object>> slist = template.queryForList(sql, formatter.format(date) ,customer_id);
        for(Map<String, Object> s : slist)
        {
            String sql1 = "select contact_number from Customer_contact where customer_id = ?";
            s.put("contact_no" , template.queryForList(sql1 , s.get("customer_id")));
            String sql2 = "select email_id from Customer_email where customer_id = ?";
            s.put("email_id" , template.queryForList(sql2 , s.get("customer_id")));
            s.put("start_time", formatter.parse(s.get("start_time").toString()));
            s.put("end_time", formatter.parse(s.get("end_time").toString()));
        }
        return slist;
    }

    public List<Map<String,  Object>> getOtherSchedule(int user_id) throws ParseException
    {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<Map<String, Object>> slist = template.queryForList("select * from Employee_schedule where employee_id = ? and description != ?", user_id , "Meeting with Customer");
        for(Map<String, Object> s : slist)
        {
            s.put("dis_start_time", formatter.parse(s.get("start_time").toString()));
            s.put("dis_end_time", formatter.parse(s.get("end_time").toString()));
        }
        return slist;
    }

    public List<String> allDesgList() {
        String sql = "select distinct(designation) from Employee";
        return template.queryForList(sql, String.class);
    }

    public List<Map<String, Object>> getAllEmployee(String desg,String sortby,String asc, String search) {
        String sql = "select * from Employee where 2 > 1";
        if (desg != null && desg.length() > 0)
            sql += " and designation like '%" + desg + "%' ";
        if (search != null && search.length() > 0)
            sql += " and ( first_name like '%" + search + "%'  or last_name like '%" + search + "%' ) ";

        if (sortby != null && sortby.length() > 0)
            sql += " order by " + sortby + " " + asc;
        return template.queryForList(sql);
    }

    public Map<String , Object> getEmpProfile(int customer_id) throws ParseException
    {
        List<Map<String  , Object>> cusDetails1 = template.queryForList("select * from Employee where employee_id = ? " , customer_id);
        if (cusDetails1.size() == 0)
            return null;
        Map<String , Object> cusDetails = cusDetails1.get(0);
        String sql1 = "select contact_number from Employee_contact where employee_id = ?";
        cusDetails.put("contact_no" , template.queryForList(sql1 , cusDetails.get("employee_id")));
        String sql2 = "select email_id from Employee_email where employee_id = ?";
        cusDetails.put("email_id" , template.queryForList(sql2 , cusDetails.get("employee_id")));
        // cusDetails.put("addFD" , getFD(customer_id));
        // cusDetails.put("allME", getME(customer_id));
        // cusDetails.put("allEQ" , getEQ(customer_id));
        // cusDetails.put("allFU" ,getFU(customer_id));
        cusDetails.put("upcomingMeetings" , getUpcomingMeeting(customer_id));
        cusDetails.put("pastMeetings" , getPastMeeting(customer_id));
        cusDetails.put("schlist", getOtherSchedule(customer_id));        
        return cusDetails;
    }


}   