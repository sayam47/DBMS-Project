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
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.entity.Customer;

@Transactional
@Repository
public class CustomerDAO {

    @Autowired
    JdbcTemplate template;

    public int save(Customer customer) {
        String sql = "insert into Customer values (?,?,?,?,?,?,?,?)";
        return template.update(sql, customer.getCustomer_id(), customer.getFirst_name(), customer.getLast_name(),
                customer.getCity(), customer.getState(), customer.getRevenue(), customer.getIndustry(),
                customer.getGender());
    }

    public void saveContacts(int customer_id, List<String> contact) {
        String sql = "insert into Customer_contact(customer_id , contact_number) values ";
        if (contact == null || contact.size() == 0)
            return;
        Set<String> set = new HashSet<String>(contact);
        for (String c : set)
            sql += " (" + customer_id + " , '" + c + "' ) ,";
        sql = sql.substring(0, sql.length() - 1);
        template.update(sql);
    }

    public void saveEmail(int customer_id, List<String> email) {
        String sql = "insert into Customer_email(customer_id , email_id) values ";
        if (email == null || email.size() == 0)
            return;
        Set<String> set = new HashSet<String>(email);
        for (String c : set)
            sql += " (" + customer_id + " , '" + c + "' ) ,";
        sql = sql.substring(0, sql.length() - 1);
        template.update(sql);
    }

    public List<Map<String, Object>> getFD(int customer_id) {
        String sql = "select bank_name , amount , interest_rate from Fd where customer_id = ? order by amount DESC";
        return template.queryForList(sql, customer_id);
    }

    public List<Map<String, Object>> getEQ(int customer_id) {
        String sql = "select ticker_symbol , average_buy_price , quantity from Equity where customer_id = ?";
        return template.queryForList(sql, customer_id);
    }

    public List<Map<String, Object>> getME(int customer_id) {
        String sql = "select type , average_buy_price , quantity from Metals where customer_id = ?";
        return template.queryForList(sql, customer_id);
    }

    public List<Map<String, Object>> getFU(int customer_id) {
        String sql = "select * from Funds where customer_id = ?";
        return template.queryForList(sql, customer_id);
    }

    public List<String> getContacts(int customer_id) {
        String sql = "select contact_number from Customer_contact where customer_id = ?";
        return template.queryForList(sql, String.class, customer_id);
    }

    public List<String> getEmails(int customer_id) {
        String sql = "select email_id from Customer_email where customer_id = ?";
        return template.queryForList(sql, String.class, customer_id);
    }

    public List<Map<String, Object>> getMeeting(int customer_id) {
        String sql = "select minutes ,start_time , end_time , rating , employee_id from Meeting where customer_id = ?";
        return template.queryForList(sql, customer_id);
    }

    public List<Map<String, Object>> getAllCustomer(String city, String industry ,String gender, int minrev, int maxrev, String sortby,
            String asc, String search) {
        String sql = "select * from Customer where 2 > 1";
        if (city != null && city.length() > 0)
            sql += " and city like '%" + city + "%' ";
        if (industry != null && industry.length() > 0)
            sql += " and industry like '%" + industry + "%' ";
        if (gender != null && gender.length() > 0)
            sql += " and gender like '" + gender + "%'";
        if (search != null && search.length() > 0)
            sql += " and ( first_name like '%" + search + "%'  or last_name like '%" + search + "%' ) ";

        sql += " and revenue <= " + maxrev + " and revenue >= " + minrev;
        if (sortby != null && sortby.length() > 0)
            sql += " order by " + sortby + " " + asc;
        // if (!(minrev.isEmpty && maxrev.isEmpty))
        return template.queryForList(sql);
    }

    public List<String> allCityList() {
        String sql = "select distinct(city) from Customer";
        return template.queryForList(sql, String.class);
    }

    public List<String> allIndustryList() {
        String sql = "select distinct(industry) from Customer";
        return template.queryForList(sql, String.class);
    }

    public List<Map<String, Object>> getUpcomingMeeting(int customer_id) throws ParseException
    {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();  
        String sql = "select meeting_id , minutes , start_time , end_time , rating , m.employee_id , first_name , last_name from Employee e , Meeting m where e.employee_id = m.employee_id and start_time > ?  and customer_id = ?  order by start_time DESC";
        List<Map<String, Object>> slist = template.queryForList(sql, formatter.format(date) ,customer_id);
        for(Map<String, Object> s : slist)
        {
            String sql1 = "select contact_number from Employee_contact where employee_id = ?";
            s.put("contact_no" , template.queryForList(sql1 , s.get("employee_id")));
            String sql2 = "select email_id from Employee_email where employee_id = ?";
            s.put("email_id" , template.queryForList(sql2 , s.get("employee_id")));
            s.put("start_time", formatter.parse(s.get("start_time").toString()));
            s.put("end_time", formatter.parse(s.get("end_time").toString()));
        }
        return slist;
    }

    public List<Map<String , Object > > getPastMeeting(int customer_id) throws ParseException
    {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();  
        String sql = "select meeting_id , minutes , start_time , end_time , rating , m.employee_id , first_name , last_name from Employee e , Meeting m where e.employee_id = m.employee_id and start_time <= ?  and customer_id = ? order by start_time DESC";
        List<Map<String, Object>> slist = template.queryForList(sql, formatter.format(date) ,customer_id);
        for(Map<String, Object> s : slist)
        {
            String sql1 = "select contact_number from Employee_contact where employee_id = ?";
            s.put("contact_no" , template.queryForList(sql1 , s.get("employee_id")));
            String sql2 = "select email_id from Employee_email where employee_id = ?";
            s.put("email_id" , template.queryForList(sql2 , s.get("employee_id")));
            s.put("start_time", formatter.parse(s.get("start_time").toString()));
            s.put("end_time", formatter.parse(s.get("end_time").toString()));
        }
        return slist;
    }

    public Map<String , Object> getCustomerProfile(int customer_id)
    {
        Map<String  , Object> cusDetails = template.queryForMap("select * from Customer where customer_id = ? " , customer_id);
        String sql1 = "select contact_number from Customer_contact where customer_id = ?";
        cusDetails.put("contact_no" , template.queryForList(sql1 , cusDetails.get("customer_id")));
        String sql2 = "select email_id from Customer_email where customer_id = ?";
        cusDetails.put("email_id" , template.queryForList(sql2 , cusDetails.get("customer_id")));
        // cusDetails.put("addFD" , getFD(customer_id));
        // cusDetails.put("addME", getME(customer_id));
        // cusDetails.put("allEQ" , getEQ(customer_id));
        // cusDetails.put("upcomingMeetings" , getUpcomingMeeting(customer_id));
        // cusDetails.put("pastMeetings" , getPastMeeting(customer_id));
        return cusDetails;
    }

    public Map<String , Object> getViewProfile(int customer_id) throws ParseException
    {
        List<Map<String  , Object>> cusDetails1 = template.queryForList("select * from Customer where customer_id = ? " , customer_id);
        if (cusDetails1.size() == 0)
            return null;
        Map<String , Object> cusDetails = cusDetails1.get(0);
        String sql1 = "select contact_number from Customer_contact where customer_id = ?";
        cusDetails.put("contact_no" , template.queryForList(sql1 , cusDetails.get("customer_id")));
        String sql2 = "select email_id from Customer_email where customer_id = ?";
        cusDetails.put("email_id" , template.queryForList(sql2 , cusDetails.get("customer_id")));
        cusDetails.put("addFD" , getFD(customer_id));
        cusDetails.put("allME", getME(customer_id));
        cusDetails.put("allEQ" , getEQ(customer_id));
        cusDetails.put("allFU" ,getFU(customer_id));
        cusDetails.put("upcomingMeetings" , getUpcomingMeeting(customer_id));
        cusDetails.put("pastMeetings" , getPastMeeting(customer_id));
        return cusDetails;
    }


}