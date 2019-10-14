package com.example.demo.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.entity.Task;

@Transactional
@Repository
public class TaskDAO {

    @Autowired
    JdbcTemplate template;

    public List<Task> givenTask(int user_id) {
        String sql1 = "select * from Task where given_by = " + user_id + " order by deadline";
        List<Map<String, Object>> tasklist = template.queryForList(sql1);
        List<Task> tList = new ArrayList< Task >();
        for (Map <String , Object> p : tasklist)
        {
            Task task = new Task(p);
            String query = "select t.employee_id , first_name , last_name from Task_given_to t , Employee e where t.employee_id = e.employee_id and t.task_id = " + task.getTask_id();
            List<Map<String, Object>> data = template.queryForList(query);
            task.setEmployeeList(data);
            tList.add(task);
        }
        return tList;
    }

}