package com.example.demo.entity;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;
public class CustomerRowMapper implements RowMapper<Customer> {
	@Override
	public Customer mapRow(ResultSet row, int rowNum) throws SQLException {
        Customer customer = new Customer();
        customer.setCustomer_id(row.getInt("customer_id"));
        customer.setFirst_name(row.getString("first_name"));
        customer.setLast_name(row.getString("last_name"));
        customer.setCity(row.getString("city"));
        customer.setState(row.getString("state"));
        customer.setIndustry(row.getString("industry"));
        customer.setRevenue(row.getInt("revenue"));
        customer.setGender(row.getString("gender"));
        return customer;
	}
} 