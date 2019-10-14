package com.example.demo.service;

import com.example.demo.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    JdbcTemplate jdbcTemplate;

    public void usave(User user)
    {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        jdbcTemplate.update("insert into User(user_name,password) values(?,?)", user.getUsername(),user.getPassword());
        int id = jdbcTemplate.queryForObject("select user_id from User where user_name=?", Integer.class,
                user.getUsername());
        user.setId(id);
        List<Map<String, Object>> x1=jdbcTemplate.queryForList("select role_id from Role where role_name like 'new%'");
        String sql="insert into user_role(user_id,role_id) values ";
        for(Map<String, Object> i : x1)
        sql+="("+id+","+i.get("role_id")+"), ";
        
        jdbcTemplate.update(sql.substring(0, sql.length()-2));    
    }

    @Override
    public void esave(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        jdbcTemplate.update("insert into User(user_name,password) values(?,?)", user.getUsername(),user.getPassword());
        int id = jdbcTemplate.queryForObject("select user_id from User where user_name=?", Integer.class,
                user.getUsername());
        user.setId(id);
        List<Map<String, Object>> x1=jdbcTemplate.queryForList("select role_id from Role where role_name like 'employee%'");
        String sql="insert into user_role(user_id,role_id) values ";
        for(Map<String, Object> i : x1)
        sql+="("+id+","+i.get("role_id")+"), ";
        
        jdbcTemplate.update(sql.substring(0, sql.length()-2));
    }

    @Override
    public void csave(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        jdbcTemplate.update("insert into User(user_name,password) values(?,?)", user.getUsername(),user.getPassword());
        int id = jdbcTemplate.queryForObject("select user_id from User where user_name=?", Integer.class,
                user.getUsername());
        user.setId(id);
        List<Map<String, Object>> x1=jdbcTemplate.queryForList("select role_id from Role where role_name like 'customer%'");
        String sql="insert into user_role(user_id,role_id) values ";
        for(Map<String, Object> i : x1)
        sql+="("+id+","+i.get("role_id")+"), ";
        
        jdbcTemplate.update(sql.substring(0, sql.length()-2));
    }


    @Override
    public User findByUsername(String username) {
        List < Map < String , Object > > u = jdbcTemplate.queryForList("select * from User where user_name=?", username);
        // System.out.println("\n\n" + u + "\n\n");
        if (u.size() == 0)
            return null;
        User user = new User(u.get(0));
        return user;
    }
}
