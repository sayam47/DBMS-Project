package com.example.demo.entity;

import java.util.Map;

public class Role {
    private Long id;

    private String name;

    Role ( Map<String,Object> arr )
    {
        this.id= (Long) arr.get("role_id");
        this.name= (String) arr.get("role_name");
    }
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}