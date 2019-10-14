package com.example.demo.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
// import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
// import org.springframework.ui.Model;
// import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Collection;

import com.example.demo.service.UserService;
import com.example.demo.dao.CustomerDAO;

@Controller
@RequestMapping("/meeting")
public class MeetingController {

    @Autowired
    private UserService userService;

    @Autowired
    JdbcTemplate template;

    @Autowired
    CustomerDAO cusDAO;

    @GetMapping(value="/editmeeting")
    public String editmeeting(Model model , @RequestParam String meeting_id) 
    {
        model.addAttribute("item", template.queryForMap("select * from Meeting where meeting_id = " + meeting_id));
        return "editmeeting";
    }

    @PostMapping("/editmeeting")
    public String editmeetingsave(
        @RequestParam("meeting_id") int meeting_id,
        @RequestParam("rating") int rating,
        @RequestParam("minutes") String minutes
    )
    {
        String sql = "update Meeting set rating = ? , minutes = ?  where meeting_id = ?";
        template.update(sql, rating , minutes , meeting_id);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Collection<? extends GrantedAuthority> p = auth.getAuthorities();
        int user_id = userService.findByUsername(auth.getName()).getId();
        Boolean r = template.queryForObject("select employee_id = ? from Meeting where meeting_id = 1", Boolean.class , user_id);
        if (p.contains(new SimpleGrantedAuthority("customer")))
            return "redirect:/customer/showcustsch";
        else if (p.contains(new SimpleGrantedAuthority("employee")) && r)
            return "redirect:/employee/showschedule";
        else if (p.contains(new SimpleGrantedAuthority("admin")))
            return "redirect:/admin/showemp";
        else
            return "/error";
    }
    
}