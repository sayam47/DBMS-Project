package com.example.demo.validator;

import com.example.demo.entity.*;
import com.example.demo.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CustomUserValidator {

    @Autowired
    private UserService userService;

    public String validate(User user) {

        if (user.getUsername() == null)
        return "Enter a username";

        if (user.getUsername().length() < 3 || user.getUsername().length() > 50) {
            return "Length of username must be between 3 to 50";
        }

        if (userService.findByUsername(user.getUsername()) != null) {
            return "username already exists";
        }

        if (user.getPassword() == null)
        {
            return "Please enter a password";
        }

        if (user.getPassword().length() < 4 || user.getPassword().length() > 32) {
            return "Password length must be between 4 and 50";
        }

        if (!user.getPasswordConfirm().equals(user.getPassword())) {
            return "Confirm Password do not match";
        }

        return "";
    }
}
