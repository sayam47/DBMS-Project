package com.example.demo.entity;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;
public class EmployeeRowMapper implements RowMapper<Employee> {
	@Override
	public Employee mapRow(ResultSet row, int rowNum) throws SQLException {
        Employee employee = new Employee();
        employee.setEmployee_id(row.getInt("employee_id"));
        employee.setFirst_name(row.getString("first_name"));
        employee.setLast_name(row.getString("last_name"));
        employee.setDesignation(row.getString("designation"));
        employee.setDate_of_birth(row.getDate("date_of_birth"));
        return employee;
	}
} 