package com.example.demo.controllers;

import java.util.Collection;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class UserController {

    @GetMapping("/new/askrole")
    public String askrole() {
        return "askrole";
    }

    @GetMapping("/login")
    public String login(Model model, String error, String logout) {
        if (error != null)
            model.addAttribute("error", "Your username and password is invalid.");

        if (logout != null)
            model.addAttribute("message", "You have been logged out successfully.");

        return "login";
    }

    @GetMapping("/signup")
    public String signup(Model model,
        @RequestParam(name = "cmessage" , defaultValue = "" ,required = false) String cmessage,
        @RequestParam(name = "emessage" , defaultValue = "" ,required = false) String emessage
    )
    {
        model.addAttribute("cmessage", cmessage);
        model.addAttribute("emessage", emessage);
        return "signup";
    }

    @GetMapping("/redirecttohome")
    public String redirecttohome()
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Collection<? extends GrantedAuthority> authorities = auth.getAuthorities();
        if (authorities.contains(new SimpleGrantedAuthority("admin")))
        {
            return "redirect:/employee";
        }
        else if (authorities.contains(new SimpleGrantedAuthority("customer")))
        {
            return "redirect:/customer";
        }
        else if (authorities.contains(new SimpleGrantedAuthority("employee")))
        {
            return "redirect:/employee";
        }
        else if (authorities.contains(new SimpleGrantedAuthority("new")))
        {
            return "redirect:/new/askrole";
        }
        else
        {
            return "redirect:/";
        }

    }
}
