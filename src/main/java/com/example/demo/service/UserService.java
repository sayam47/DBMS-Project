package com.example.demo.service;

import com.example.demo.entity.User;

public interface UserService {
    void esave(User user);
    void csave(User user);
    void usave(User user);
    User findByUsername(String username);
}
