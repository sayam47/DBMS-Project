package com.example.demo.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
// import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import com.example.demo.dao.EmployeeDAO;;



@Controller
public class HomeController {

    @Autowired
    EmployeeDAO empDAO;

    @Autowired
    JdbcTemplate template;


    @RequestMapping(value = "/")
    public String index(Model model) {
        model.addAttribute("greeting", "<center><h2>Your Gateway To Financial Freedom...!!</h2></center>");
        return "index";
    }

    // @GetMapping("/example")
    // public String newexample()
    // {
    //     return "example";
    // }

}