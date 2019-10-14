package com.example.demo.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.Authentication;
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
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.example.demo.entity.Employee;
import com.example.demo.entity.Task;
import com.example.demo.entity.User;
import com.example.demo.service.SecurityService;
import com.example.demo.service.UserService;
import com.example.demo.validator.CustomUserValidator;
import com.example.demo.dao.CustomerDAO;
import com.example.demo.dao.EmployeeDAO;
import com.example.demo.dao.TaskDAO;;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    EmployeeDAO empDAO;

    @Autowired
    JdbcTemplate template;

    @Autowired
    TaskDAO taskDAO;

    @Autowired
    CustomerDAO cusDAO;

    @Autowired
    CustomUserValidator customuserValidator;

    @PostMapping("/signup")
    public ModelAndView empSignup(@RequestParam("username") String username, @RequestParam("password") String password,
            @RequestParam("cpassword") String cpassword, @RequestParam("fname") String fname,
            @RequestParam("lname") String lname, @RequestParam("desg") String desg,
            @RequestParam("bdate") String sbdate , @RequestParam("contact[]") List<String> contact,
            @RequestParam("email[]") List<String> email            
    ) throws ParseException 
    {
        Date bdate = new SimpleDateFormat("yyyy-MM-dd").parse(sbdate);
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setPasswordConfirm(cpassword);
        
        var mav = new ModelAndView();

        String error = customuserValidator.validate(user);
        
        for (String c : contact)
        {
            if (c.length() != 10 || c.indexOf("0") == 0)
            {
                error = "Contact number is incorrect";
            }
        }


        if (error.length() > 0)
        {
            mav.setViewName("redirect:/signup");
            mav.addObject("emessage", error);
            return mav;
        }

        userService.usave(user);
        // userService.esave(user);
        securityService.autoLogin(user.getUsername(), user.getPasswordConfirm());
        user = userService.findByUsername(username);

        Employee employee = new Employee();
        employee.setEmployee_id(user.getId());
        employee.setFirst_name(fname);
        employee.setLast_name(lname);
        employee.setDesignation(desg);
        employee.setDate_of_birth(bdate);

        empDAO.save(employee);
        empDAO.saveContacts(user.getId(), contact);
        empDAO.saveEmail(user.getId(), email);

        return new ModelAndView("redirect:/new/askrole");
    }

    @GetMapping("/tasks")
    public String showAddTask(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();
        User user = userService.findByUsername(username);
        String psql = "select t1.task_id , t1.task_desc , t1.given_date , t1.deadline , e.first_name , e.last_name from Task t1 , Task_given_to t2 , Employee e where t1.given_by = e.employee_id and t1.task_id = t2.task_id and t2.employee_id = "
                + user.getId() + " and t1.status = 0 order by deadline";
        String csql = "select t1.task_id , t1.done_on , t1.task_desc , t1.given_date , t1.deadline , e.first_name , e.last_name from Task t1 , Task_given_to t2 , Employee e where t1.given_by = e.employee_id and t1.task_id = t2.task_id and t2.employee_id = "
                + user.getId() + " and t1.status = 1 order by deadline";  
        List<Map<String, Object>> completedList = template.queryForList(csql);
        List<Map<String, Object>> incompletedList = template.queryForList(psql);
        model.addAttribute("completedList", completedList);
        model.addAttribute("incompletedList", incompletedList);
        return "emptask";
    }

    @PostMapping("/tasks/setComplete")
    public String setComplete(@RequestParam("complete_task_id") int task_id)
    {
        String sql = "update Task set status = 1 where task_id = " + task_id;
        template.update(sql);
        return "redirect:/employee/tasks";
    }

    @GetMapping("/giventask")
    public String givenTask(Model model)
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        List < Task > all_task = taskDAO.givenTask(user_id);
        model.addAttribute("all_task", all_task);
        return "giventask";
    }

    @GetMapping("/addtask")
    public String addTask(Model model , @RequestParam(name = "message" , required = false) String message)
    {
        String query = "select employee_id , first_name , last_name from Employee";
        List<Map<String, Object>> data = template.queryForList(query);
        model.addAttribute("allEmp", data);
        model.addAttribute("message", message);
        return "addtask";
    }

    @PostMapping("/addtask")
    public ModelAndView saveAddTask(Model model ,
        @RequestParam("task_desc") String task_desc,
        @RequestParam("deadline") String sdeadline,
        @RequestParam("employee[]") List<String> employees
    ) throws ParseException
    {
        // System.out.println("\n\n\n" + employees + "\n\n\n");
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");  
        Date deadline = new SimpleDateFormat("yyyy-MM-dd").parse(sdeadline);
        // System.out.println("\n\n\n" + new Date() + "\n\n\n");
        if (deadline.before(new Date()))
        {
            var mav = new ModelAndView("redirect:/employee/addtask");
            mav.addObject("message", "Deadline is on/before today");
            return mav;
        }
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String sql = "insert into Task(task_desc , deadline , given_by ) values ( '" + task_desc + "' , '" + formatter.format(deadline) + "'," + user_id + ")";
        template.execute(sql);
        int task_id = template.queryForObject("select LAST_INSERT_ID()" , Integer.class);
        Set<String> set = new HashSet<String>(employees);
        for(String employee_id : set)
        {
            String sql1 = "insert into Task_given_to values ( " + task_id + " , "  + employee_id + ")";
            template.execute(sql1);
        }
        return new ModelAndView("redirect:/employee/giventask");
    }


    @GetMapping("")
    public String employeeHome()
    {
        return "Home";
    }

    @GetMapping("/addschedule")
    public String addSchedule(Model model , @RequestParam(name = "errormsg" , required = false) String errormsg)
    {    
        model.addAttribute("message", errormsg);
        return "addschedule";
    }

    @PostMapping("/addschedule")
    public ModelAndView saveAddSchedule(Model model ,
        @RequestParam("desc") String  desc,
        @RequestParam("sdate") String  sdate,
        @RequestParam("edate") String  edate,
        @RequestParam("stime") String  stime,
        @RequestParam("etime") String  etime
    ) throws ParseException
    {
        Date sdtime = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(sdate + " " + stime);
        Date edtime = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(sdate + " " + etime);
 
        var mav = new ModelAndView("redirect:/employee/addschedule");

        SimpleDateFormat parser = new SimpleDateFormat("HH:mm");
        Date nine = parser.parse(template.queryForObject("select value from Variables where variable_name = 'office_hours_start'", String.class));
        Date seventeen = parser.parse(template.queryForObject("select value from Variables where variable_name = 'office_hours_end'", String.class));
        if (sdtime.before(new Date()))
        {
            mav.addObject("errormsg", "Start time is before today");
            return mav;
        }
        if (parser.parse(stime).before(nine))
        {
            mav.addObject("errormsg", "Too early");
            return mav;
        }

        if (parser.parse(etime).after(seventeen))
        {
            mav.addObject("errormsg", "Too late");
            return mav;
        }
        if (!(sdtime.before(edtime)))
        {
            mav.addObject("errormsg", "End Time should be after Start Time");
            return mav;
        }

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();

        String sql = String.format("select employee_id from Employee_schedule where (( '%1$s' >= start_time and '%2$s' <= end_time) or ( '%1$s' <= start_time and '%2$s' >= start_time) or ( '%1$s' <= end_time and '%2$s' >= end_time)) and employee_id = %3$s",
        (sdate + " " + stime) , (sdate + " " + etime) , user_id);

        List<Integer> sid = template.queryForList(sql, Integer.class);

        if (!(sid.isEmpty()))
        {
            mav.addObject("errormsg", "You are already busy");
            return mav;
        }

        sql = "insert into Employee_schedule values ( " + user_id + " , '" + sdate + " " + stime + "' , '" + edate + " " + etime + "','" + desc + "' )";
        template.execute(sql);
        return new ModelAndView("redirect:/employee/showschedule");
    }

    @GetMapping("/showschedule")
    public String showSchedule(Model model) throws ParseException
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        model.addAttribute("upcomingMeetings", empDAO.getUpcomingMeeting(user_id));
        model.addAttribute("pastMeetings", empDAO.getPastMeeting(user_id));
        model.addAttribute("schlist", empDAO.getOtherSchedule(user_id));
        return "showschedule";
    }

    @PostMapping("/deletesch")
    public String deleteSchedule(Model model, @RequestParam("start_time") String start_time) throws ParseException
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        Date sdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(start_time);
        String sql = "delete from Employee_schedule where employee_id = ? and start_time = ?";
        template.update(sql, user_id ,  sdate);
        return "redirect:/employee/showschedule";
    }

    @GetMapping("/profile")
    public String showProfile(Model model)
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        model.addAttribute("item", empDAO.getEmpById(user_id));
        return "employee_profile";
    }

    @GetMapping("/editprofile")
    public String editProfile(Model model ,@RequestParam("employee_id") int employee_id)
    {
        model.addAttribute("item", empDAO.getEmpById(employee_id));
        return "empeditprofile";
    }

    @PostMapping("/editprofile")
    public ModelAndView saveeditprofile(Model model ,
        @RequestParam("fname") String fname,
        @RequestParam("lname") String lname, @RequestParam("desg") String desg,
        @RequestParam("bdate") String sbdate , @RequestParam(name = "newcontact[]" , required = false) List<String> newcontact,
        @RequestParam(name = "newemail[]" , required = false) List<String> newemail
    )
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String error = "";
        for (String c : newcontact)
        {
            if (c.length() != 10 || c.indexOf("0") == 0)
            {
                error = "Contact number is incorrect";
            }
        }

        if (error.length()>0)
        {   var mav =new ModelAndView("redirect:/employee/editprofile");
            mav.addObject("errormsg", error);
            return mav;
        }

        String sql = "update Employee set first_name = ? , last_name = ? , designation = ? , date_of_birth = ? where employee_id = ?";
        template.update(sql, fname , lname , desg ,sbdate , user_id);
        empDAO.saveContacts(user_id, newcontact);
        empDAO.saveEmail(user_id, newemail);
        return new ModelAndView("redirect:/employee/profile");
    }

    @GetMapping("/addexpense")
    public String addExpense()
    {
        return "addexpense";
    }

    @PostMapping("/addexpense")
    public String saveAddExpense(
        @RequestParam("desc") String desc,
        @RequestParam("amount") int amount
    )
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String sql = "insert into Expense(description , amount , added_by) values ('" + desc + "' , " + amount + " , " + user_id + ")";
        template.execute(sql);
        return "redirect:/employee/showexpense";
    }

    @GetMapping("/showexpense")
    public String showExpense(Model model)
    {
        String sql = "select * from Expense x , Employee e where e.employee_id = x.added_by order by edate DESC";
        List<Map<String , Object>> elist = template.queryForList(sql);
        model.addAttribute("elist", elist);
        return "showexpense";
    }


    @GetMapping("/showcust")
    public String showCust(Model model,
        @RequestParam(name = "city" ,required = false) String city,
        @RequestParam(name = "industry" ,required = false) String industry,
        @RequestParam(name = "gender" ,required = false) String gender,
        @RequestParam(name = "minrev" ,defaultValue = "0" , required = false) int minrev,
        @RequestParam(name = "maxrev" ,defaultValue = "2140000000" ,required = false) int maxrev,
        @RequestParam(name = "sortby" ,required = false) String sortby,
        @RequestParam(name = "asc" , required = false) String asc,
        @RequestParam(name = "search" , required = false) String search
    )
    {
        model.addAttribute("city", city);
        model.addAttribute("industry", industry);
        model.addAttribute("search", search);
        model.addAttribute("gender", gender);
        model.addAttribute("minrev", minrev);
        model.addAttribute("maxrev", maxrev);
        model.addAttribute("asc", asc);
        model.addAttribute("sortby", sortby);
        model.addAttribute("allCust", cusDAO.getAllCustomer(city , industry , gender , minrev , maxrev , sortby , asc , search));
        model.addAttribute("allCityList", cusDAO.allCityList());
        model.addAttribute("allIndustryList", cusDAO.allIndustryList());
        return "showcust";
    }

    @GetMapping("/viewcustomer")
    public String viewCustomer(Model model , @RequestParam("customer_id") int customer_id) throws ParseException
    {
        Map<String , Object > item1 = cusDAO.getViewProfile(customer_id);
        if (item1 == null)
            model.addAttribute("message" , "No Customer with the ID");
        else
            model.addAttribute("item1", item1);
        return "viewcustomer";
    }
} 