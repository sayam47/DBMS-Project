package com.example.demo.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.example.demo.dao.CustomerDAO;
import com.example.demo.dao.EmployeeDAO;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    JdbcTemplate template;

    @Autowired
    CustomerDAO cusDAO;

    @Autowired
    EmployeeDAO empDAO;

    @GetMapping("/assignrole")
    public String assignRole(Model model)
    {
        List<Map<String, Object>> x1 = template.queryForList("select role_id from Role where role_name like 'new%'");
        String sql = "SELECT user_name , first_name , last_name , User.user_id , designation , date_of_birth FROM User LEFT JOIN user_role ON (User.user_id = user_role.user_id) , Employee e  WHERE (user_role.role_id IS NULL or user_role.role_id in ( 0 ";

        String sql3 = "and e.employee_id = User.user_id";
        for(Map<String, Object> i : x1)
            sql+=","+i.get("role_id");
        sql+= ") ) ";
        sql += sql3;
        List<Map<String, Object>> e = template.queryForList(sql);
        for(Map<String , Object> ee:e)
        {
            String sql1 = "select contact_number from Employee_contact where employee_id = ?";
            ee.put("contact_no" , template.queryForList(sql1 ,ee.get("user_id")));
            String sql2 = "select email_id from Employee_email where employee_id = ?";
            ee.put("email_id" , template.queryForList(sql2 , ee.get("user_id")));
        }
        model.addAttribute("item1", e);
        return "assignrole";
    }

    @PostMapping("/setroleemployee")
    public String setrole(@RequestParam("user_id") int user_id)
    {
        List<Map<String, Object>> x1=template.queryForList("select role_id from Role where role_name like 'employee%'");
        String sql="insert into user_role(user_id,role_id) values ";
        for(Map<String, Object> i : x1)
            sql+="("+user_id+","+i.get("role_id")+"), ";

        template.update(sql.substring(0, sql.length()-2));
        x1=template.queryForList("select role_id from Role where role_name like 'new%'");
        sql = "delete from user_role where user_id = " + user_id + " and role_id in ( 0 ";
        for(Map<String, Object> i : x1)
            sql+=","+i.get("role_id");
        sql+= ")";
        template.update(sql);
        return "redirect:/admin/assignrole";
    }

    @GetMapping("/change_office_hours")
    public String cofficehours(Model model , @RequestParam(name = "message" , required = false) String message)
    {
        model.addAttribute("office_hours_start", template.queryForObject("select value from Variables where variable_name = 'office_hours_start'" , String.class));
        model.addAttribute("office_hours_end", template.queryForObject("select value from Variables where variable_name = 'office_hours_end'" , String.class));
        model.addAttribute("message",message);
        return "cofficehours";
    }

    @PostMapping("/change_office_hours")
    public ModelAndView saveofficehours(@RequestParam("office_hours_start") String start , @RequestParam("office_hours_end") String end) throws ParseException
    {
        Date sdtime = new SimpleDateFormat("HH:mm").parse(start);
        Date edtime = new SimpleDateFormat("HH:mm").parse(end);
        if (!(sdtime.before(edtime)))
        {
            var mav = new ModelAndView("redirect:/admin/change_office_hours");
            mav.addObject("message", "End Time should be after Start Time");
            return mav;
        }        
        template.update("update Variables set value = ? where variable_name = 'office_hours_start'", start);
        template.update("update Variables set value = ? where variable_name = 'office_hours_end'", end); 
        return new ModelAndView("redirect:/employee");
    }

    @GetMapping("/showemp")
    public String showEmp(Model model,
        @RequestParam(name = "desg" ,required = false) String desg,
        @RequestParam(name = "sortby" ,required = false) String sortby,
        @RequestParam(name = "asc" , required = false) String asc,
        @RequestParam(name = "search" , required = false) String search
    )
    {
        model.addAttribute("desg", desg);
        model.addAttribute("search", search);
        model.addAttribute("asc", asc);
        model.addAttribute("sortby", sortby);
        model.addAttribute("allEmp", empDAO.getAllEmployee(desg , sortby , asc , search));
        model.addAttribute("allDesgList", empDAO.allDesgList());
        return "showemp";
    }

    @GetMapping("/viewemp")
    public String viewCustomer(Model model , @RequestParam("employee_id") int employee_id) throws ParseException
    {
        Map<String , Object > item1 = empDAO.getEmpProfile(employee_id);
        if (item1 == null)
            model.addAttribute("message" , "No Employee with the ID");
        else
            model.addAttribute("item1", item1);
        return "viewemp";
    }

    @GetMapping("/empanalytics")
    public String empAnalytics(Model model)
    {
        model.addAttribute("all", template.queryForList("with FC AS (select Employee.employee_id , first_name , last_name , count(Employee.employee_id) as count from Meeting , Employee  where Meeting.employee_id = Employee.employee_id group by employee_id)  select Employee.employee_id , Employee.first_name , Employee.last_name , count from Employee LEFT JOIN FC on Employee.employee_id=FC.employee_id order by count desc"));
        model.addAttribute("past", template.queryForList("with FC AS (select Employee.employee_id , first_name , last_name , count(Employee.employee_id) as count from Meeting , Employee  where Meeting.employee_id = Employee.employee_id and start_time < NOW() group by employee_id)  select Employee.employee_id , Employee.first_name , Employee.last_name , count from Employee LEFT JOIN FC on Employee.employee_id=FC.employee_id order by count desc"));
        model.addAttribute("upcoming", template.queryForList("with FC AS (select Employee.employee_id , first_name , last_name , count(Employee.employee_id) as count from Meeting , Employee  where Meeting.employee_id = Employee.employee_id and start_time >= NOW()  group by employee_id)  select Employee.employee_id , Employee.first_name , Employee.last_name , count from Employee LEFT JOIN FC on Employee.employee_id=FC.employee_id order by count desc"));
        model.addAttribute("converted", template.queryForList("with FC AS (select Employee.employee_id , first_name , last_name , count(Employee.employee_id) as count from Meeting , Employee  where Meeting.employee_id = Employee.employee_id and start_time >= NOW()  group by employee_id)  select Employee.employee_id , Employee.first_name , Employee.last_name , count from Employee LEFT JOIN FC on Employee.employee_id=FC.employee_id order by count desc"));
        return "empanalytics";
    }

}