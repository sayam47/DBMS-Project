package com.example.demo.entity;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

public class User {
    @Autowired
    JdbcTemplate jdbcTemplate;

    private int id;

    private String username;

    private String password;

    private String passwordConfirm;

    public User()
    {
        
    }

    public User(Map<String,Object> arr)
    {   
        this.id= (int) arr.get("user_id");
        this.username= (String) arr.get("user_name");
        this.password= (String) arr.get("password");
        this.passwordConfirm= (String) arr.get("password");
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordConfirm() {
        return passwordConfirm;
    }

    public void setPasswordConfirm(String passwordConfirm) {
        this.passwordConfirm = passwordConfirm;
    }

}
