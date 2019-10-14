package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {
    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    @Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String username) {
        // System.out.print(username);
        List<Map<String, Object>> x=jdbcTemplate.queryForList("select * from User u where u.user_name=?",username);
        
        if (x.isEmpty()) throw new UsernameNotFoundException(username);
        // System.out.println(username);

        Set<GrantedAuthority> grantedAuthorities = new HashSet<>();
        
        x = jdbcTemplate.queryForList("select r.role_name from User u,Role r,user_role ur  where u.user_name=? and u.user_id=ur.user_id and r.role_id=ur.role_id",username);

        for (Map<String, Object> x1 : x) {
            grantedAuthorities.add(new SimpleGrantedAuthority((String)x1.get("role_name")));
        }
        String password=(String)jdbcTemplate.queryForObject("select password from User where user_name=?", String.class, username);
        return new org.springframework.security.core.userdetails.User(username, password,grantedAuthorities);
    }
}
