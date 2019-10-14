package com.example.demo.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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

import com.example.demo.entity.Customer;
import com.example.demo.entity.User;
import com.example.demo.service.SecurityService;
import com.example.demo.service.UserService;
import com.example.demo.validator.CustomUserValidator;
import com.example.demo.dao.CustomerDAO;

@Controller
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private CustomUserValidator customuserValidator;

    @Autowired
    JdbcTemplate template;

    @Autowired
    CustomerDAO cusDAO;

    @PostMapping("/signup")
    public ModelAndView cSignup(@RequestParam("username") String username, @RequestParam("password") String password,
            @RequestParam("cpassword") String cpassword, @RequestParam("first_name") String first_name,
            @RequestParam("last_name") String last_name, @RequestParam("city") String city,
            @RequestParam("state") String state, @RequestParam("revenue") int revenue, @RequestParam("industry") String industry,
            @RequestParam("gender") String gender , @RequestParam("contact[]") List<String> contact ,
            @RequestParam("email[]") List<String> email
        ) {
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setPasswordConfirm(cpassword);
        
        var mav = new ModelAndView();

        String error;
        error = customuserValidator.validate(user);

        for (String c : contact)
        {
            if (c.length() != 10 || c.indexOf("0") == 0)
            {
                error = "Contact number is incorrect";
            }
        }

        if (gender != "Male" && gender != "Female")
            error = "Incorrect Gender";


        if (error.length() > 0)
        {
            mav.setViewName("redirect:/signup");
            mav.addObject("cmessage", error);
            return mav;
        }

        userService.csave(user);
        securityService.autoLogin(user.getUsername(), user.getPasswordConfirm());
        user = userService.findByUsername(username);
        Customer customer = new Customer(user.getId(), first_name, last_name, city, state, industry, revenue,
                gender);
        // System.out.println("\n\ncaoj  " + customer.getFirst_name() + " " + customer.getCustomer_id() + "\n\n");
        cusDAO.save(customer);
        cusDAO.saveContacts(user.getId(), contact);
        cusDAO.saveEmail(user.getId(), email);

        return new ModelAndView("redirect:/customer");

    }

    @GetMapping("")
    public String customerHome() {
        return "customerHome";
    }

    @GetMapping("/addfd")
    public String addfdform()
    {
        return "addfdform";
    }

    @PostMapping("/addfd")
    public String addfd(
        @RequestParam("bname") String bname , 
        @RequestParam("amount") float amount,
        @RequestParam("rate") float rate
    )
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String sql = "insert into Fd(bank_name , amount , interest_rate ,  customer_id) values (?,?,?,?)";
        template.update(sql,bname , amount , rate , user_id);
        return "redirect:/customer/myfd";
    }

    @GetMapping("/myfd")
    public String myfd(Model model)
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String sql = "select * from Fd where customer_id = ? order by amount DESC";
        List<Map<String, Object>> allFD = template.queryForList(sql, user_id);
        model.addAttribute("addFD", allFD);
        return "showfd";
    }

    @GetMapping("/editfd")
    public String editfd(Model model,
        @RequestParam("fd_id") int fd_id
    )
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String sql = "select * from Fd where fd_id = ? and customer_id = ?";
        List<Map<String, Object>> p = template.queryForList(sql, fd_id, user_id);
        if (p.size() == 0)
        {
            return "redirect:/error";
        }
        Map<String , Object > p1 = p.get(0);
        model.addAttribute("item", p1);
        return "editfd";
    }

    @PostMapping("/editfd")
    public String editfdsave(
        @RequestParam("bname") String bname , 
        @RequestParam("amount") float amount,
        @RequestParam("rate") float rate,
        @RequestParam("fd_id") int fd_id
    )
    {
        String sql = "update Fd set bank_name = ? , amount = ? , interest_rate = ? where fd_id = ? ";
        template.update(sql,bname , amount , rate , fd_id);
        return "redirect:/customer/myfd";
    }

    @PostMapping("/deletefd")
    public String deletefd(
        @RequestParam("fd_id") int fd_id
    )
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String sql = "delete from Fd where fd_id = ? and customer_id = ? ";
        template.update(sql,fd_id , user_id);
        return "redirect:/customer/myfd";
    }


    @GetMapping("/addeq") 
    public String addeqform(Model model, @RequestParam(name = "message" , required = false) String message)
    {
        model.addAttribute("message",message);
        return "addeqform";
    }

    @PostMapping("/addeq")
    public ModelAndView addeq(
        @RequestParam("tsymbol") String tsymbol , 
        @RequestParam("price") float price,
        @RequestParam("quan") float quan
    )
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        List<Map<String , Object>> p = template.queryForList("select * from Equity where ticker_symbol like ? and customer_id = ?" , tsymbol, user_id);
        if (p.size() == 0)
        {
            String sql = "insert into Equity(ticker_symbol , average_buy_price , quantity , customer_id) values (?,?,?,?)";
            template.update(sql,tsymbol , price , quan , user_id);
        }
        else
        {
            var mav = new ModelAndView("redirect:/customer/addeq");
            mav.addObject("message","You already own it, edit it if you want to change");
            return mav;
        }
        return new ModelAndView("redirect:/customer/showeq");
    }

    @PostMapping("/deleteeq")
    public String deleteeq(
        @RequestParam("ticker_symbol") String ticker_symbol
    )
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String sql = "delete from Equity where ticker_symbol = ? and customer_id = ? ";
        template.update(sql,ticker_symbol , user_id);
        return "redirect:/customer/showeq";
    }

    @GetMapping("/editeq")
    public String editeq(Model model,
        @RequestParam("ticker_symbol") String ticker_symbol
    )
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String sql = "select * from Equity where ticker_symbol = ? and customer_id = ?";
        List<Map<String, Object>> p = template.queryForList(sql, ticker_symbol, user_id);
        if (p.size() == 0)
        {
            return "redirect:/error";
        }
        Map<String , Object > p1 = p.get(0);
        model.addAttribute("item", p1);
        return "editeq";
    }

    @PostMapping("/editeq")
    public String editeqsave(
        @RequestParam("tsymbol") String tsymbol , 
        @RequestParam("price") float price,
        @RequestParam("quan") float quan
    )
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String sql = "update Equity set average_buy_price = ? , quantity = ? where ticker_symbol = ? and customer_id = ?";
        template.update(sql, price , quan , tsymbol , user_id);
        return "redirect:/customer/showeq";
    }


    @GetMapping("/showeq")
    public String showeq(Model model)
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String sql = "select * from Equity where customer_id = ?";
        List<Map<String, Object>> allEQ = template.queryForList(sql, user_id);
        model.addAttribute("allEQ", allEQ);
        return "showeq";
    }

    @GetMapping("/addmetals")
    public String addmetalsform(Model model, @RequestParam(name = "message" , required = false) String message)
    {
        model.addAttribute("message",message);
        return "addmetals";
    }

    @GetMapping("/addfund")
    public String addfundform(Model model, @RequestParam(name = "message" , required = false) String message)
    {
        model.addAttribute("message",message);
        return "addfund";
    }

    @PostMapping("/addmetals")
    public ModelAndView addmetals(
        @RequestParam("name") String name , 
        @RequestParam("price") float price,
        @RequestParam("quan") float quan
    )
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        List<Map<String , Object>> p = template.queryForList("select * from Metals where type like ? and customer_id = ?" , name, user_id);
        if (p.size() == 0)
        {
            String sql = "insert into Metals(type , average_buy_price , quantity , customer_id) values (?,?,?,?)";
            template.update(sql,name , price , quan , user_id);
        }
        else
        {
            var mav = new ModelAndView("redirect:/customer/addmetals");
            mav.addObject("message","You already own it, edit it if you want to change");
            return mav;
        }
        return new ModelAndView("redirect:/customer/showmetals");
    }

    @PostMapping("/addfund")
    public ModelAndView addfund(
        @RequestParam("name") String name , 
        @RequestParam("price") float price,
        @RequestParam("quan") float quan
    )
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        List<Map<String , Object>> p = template.queryForList("select * from Funds where amc_fund_house like ? and customer_id = ?" , name, user_id);
        if (p.size() == 0)
        {
            String sql = "insert into Funds(amc_fund_house , average_buy_price , quantity , customer_id) values (?,?,?,?)";
            template.update(sql,name , price , quan , user_id);
        }
        else
        {
            var mav = new ModelAndView("redirect:/customer/addfund");
            mav.addObject("message","You already own it, edit it if you want to change");
            return mav;
        }
        return new ModelAndView("redirect:/customer/showfund");
    }

    @GetMapping("/editmetal")
    public String editmetals(Model model,
        @RequestParam("type") String type
    )
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String sql = "select * from Metals where type = ? and customer_id = ?";
        List<Map<String, Object>> p = template.queryForList(sql, type , user_id);
        if (p.size() == 0)
        {
            return "redirect:/error";
        }
        Map<String , Object > p1 = p.get(0);
        model.addAttribute("item", p1);
        return "editmetal";
    }

    @GetMapping("/editfund")
    public String editfund(Model model,
        @RequestParam("type") String type
    )
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String sql = "select * from Funds where amc_fund_house = ? and customer_id = ?";
        List<Map<String, Object>> p = template.queryForList(sql, type , user_id);
        if (p.size() == 0)
        {
            return "redirect:/error";
        }
        Map<String , Object > p1 = p.get(0);
        model.addAttribute("item", p1);
        return "editfund";
    }

    @PostMapping("/editmetal")
    public String editmetalsave(
        @RequestParam("name") String name , 
        @RequestParam("price") float price,
        @RequestParam("quan") float quan
    )
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String sql = "update Metals set average_buy_price = ? , quantity = ? where type = ? and customer_id = ?";
        template.update(sql, price , quan , name , user_id);
        return "redirect:/customer/showmetals";
    }

    @PostMapping("/editfund")
    public String editfund(
        @RequestParam("name") String name , 
        @RequestParam("price") float price,
        @RequestParam("quan") float quan
    )
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String sql = "update Funds set average_buy_price = ? , quantity = ? where amc_fund_house = ? and customer_id = ?";
        template.update(sql, price , quan , name , user_id);
        return "redirect:/customer/showfund";
    }

    @PostMapping("/deletemetal")
    public String deletemetal(
        @RequestParam("type") String type
    )
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String sql = "delete from Metals where type = ? and customer_id = ? ";
        template.update(sql,type , user_id);
        return "redirect:/customer/showmetals";
    }

    @PostMapping("/deletefund")
    public String deletefund(
        @RequestParam("type") String type
    )
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String sql = "delete from Funds where amc_fund_house = ? and customer_id = ? ";
        template.update(sql,type , user_id);
        return "redirect:/customer/showfund";
    }

    @GetMapping("/showmetals")
    public String showmetals(Model model)
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String sql = "select * from Metals where customer_id = ?";
        List<Map<String, Object>> allME = template.queryForList(sql, user_id);
        model.addAttribute("allME", allME);
        return "showmetals";
    }


    @GetMapping("/showfund")
    public String showfund(Model model)
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String sql = "select * from Funds where customer_id = ?";
        List<Map<String, Object>> allFU = template.queryForList(sql, user_id);
        model.addAttribute("allFU", allFU);
        return "showfund";
    }

    @GetMapping("/showcustsch")
    public String showcustsch(Model model) throws ParseException
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        model.addAttribute("upcomingMeetings", cusDAO.getUpcomingMeeting(user_id));
        model.addAttribute("pastMeetings", cusDAO.getPastMeeting(user_id));
        return "showusermeeting";
    }

    @GetMapping("/profile")
    public String profile(Model model)
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        model.addAttribute("item", cusDAO.getCustomerProfile(user_id));
        return "cusprofile";
    }

    @GetMapping("/editprofile" )
    public String editprofile(Model model , @RequestParam("customer_id") int customer_id , @RequestParam(name = "errormsg", required = false) String errormsg)
    {
        model.addAttribute("errormsg", errormsg);   
        model.addAttribute("item", cusDAO.getCustomerProfile(customer_id));
        return "editprofile";
    }

    @PostMapping("/editprofile")
    public ModelAndView saveeditprofile(
        @RequestParam("first_name") String first_name,
        @RequestParam("last_name") String last_name, @RequestParam("city") String city,
        @RequestParam("state") String state, @RequestParam("revenue") int revenue, @RequestParam("industry") String industry,
        @RequestParam("gender") String gender , @RequestParam(name = "contact[]" , required = false) List<String> contact ,
        @RequestParam(name = "email[]" , required = false) List<String> email , @RequestParam(name = "newcontact[]" , required = false) List<String> newcontact ,
        @RequestParam(name ="newemail[]" , required = false) List<String> newemail
    )
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        String error="";
        for (String c : newcontact)
        {
            if (c.length() != 10 || c.indexOf("0") == 0)
            {
                error = "Contact number is incorrect";
            }
        }

        if (error.length()>0)
        {   var mav =new ModelAndView("redirect:/customer/editprofile");
            mav.addObject("customer_id", user_id);
            mav.addObject("errormsg", error);
            return mav;
        }
        String sql = "update Customer set first_name = ? , last_name = ? , city = ? , state = ? , revenue = ? , industry = ? , gender = ? where customer_id = ?";
        template.update(sql, first_name , last_name , city ,state , revenue , industry , gender , user_id);
        cusDAO.saveContacts(user_id, newcontact);
        cusDAO.saveEmail(user_id, newemail);
        return new ModelAndView("redirect:/customer/profile");
    }

    @GetMapping("/getappointment")    
    public String getAppointmentForm(
        Model model,
        @RequestParam(name = "errormsg" , required = false) String error    
    )
    {
        if (error != null)
        {
            model.addAttribute("message", error);
        }
        return "getAppointment";
    }

    @PostMapping("/getappointment")
    public ModelAndView getAppointment(
        @RequestParam("sdate") String sdate,
        @RequestParam("stime") String stime,
        @RequestParam("etime") String etime
    ) throws ParseException
    {
        Date sdtime = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(sdate + " " + stime);
        Date edtime = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(sdate + " " + etime);
        var mav = new ModelAndView("redirect:/customer/getappointment");

        SimpleDateFormat parser = new SimpleDateFormat("HH:mm");
        Date nine = parser.parse("09:00");
        Date seventeen = parser.parse("19:00");

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
        Date date = new Date();  
        if (sdtime.before(date))
        {
            mav.addObject("errormsg", "Date's Gone ..!!");
            return mav;
        }
        String sql = String.format("select employee_id , first_name , last_name from Employee LEFT JOIN ( select distinct(employee_id) from Employee_schedule where ( '%1$s' >= start_time and '%2$s' <= end_time) or ( '%1$s' <= start_time and '%2$s' >= start_time) or ( '%1$s' <= end_time and '%2$s' >= end_time)) as p USING (employee_id) where p.employee_id IS NULL",
        (sdate + " " + stime) , (sdate + " " + etime));
        List<Map<String, Object>> freeEmplist = template.queryForList(sql);
        if (freeEmplist.isEmpty())
        {
            mav.addObject("errormsg", "Sorry! No employee free at the time");
            return mav;
        }
        mav.clear();
        mav.setViewName("getAppointment1");
        mav.addObject("freeEmplist", freeEmplist);
        mav.addObject("sdate", sdate);
        mav.addObject("stime", stime);
        mav.addObject("etime", etime);
        return mav;
    }

    @PostMapping("/getappointment1")
    public ModelAndView getAppointment1(
        @RequestParam("sdate") String sdate,
        @RequestParam("stime") String stime,
        @RequestParam("etime") String etime,
        @RequestParam("foremp") int employee_id
    ) throws ParseException 
    {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int user_id = userService.findByUsername(auth.getName()).getId();
        Date sdtime = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(sdate + " " + stime);
        Date edtime = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(sdate + " " + etime);
        var mav = new ModelAndView("redirect:/customer/getappointment");
        
        SimpleDateFormat parser = new SimpleDateFormat("HH:mm");
        Date nine = parser.parse("09:00");
        Date seventeen = parser.parse("19:00");

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
        Date date = new Date();  
        if (sdtime.before(date))
        {
            mav.addObject("errormsg", "Date's Gone ..!!");
            return mav;
        }
        
        String sql = String.format("select employee_id from Employee_schedule where (( '%1$s' >= start_time and '%2$s' <= end_time) or ( '%1$s' <= start_time and '%2$s' >= start_time) or ( '%1$s' <= end_time and '%2$s' >= end_time)) and employee_id = %3$s",
        (sdate + " " + stime) , (sdate + " " + etime) , employee_id);

        List<Integer> sid = template.queryForList(sql, Integer.class);

        if (!(sid.isEmpty()))
        {
            mav.setViewName("redirect:/customer/getappointment");
            mav.addObject("errormsg", "Sorry the employee just got booked");
            return mav;
        }

        sql = "insert into Meeting(start_time , end_time , employee_id , customer_id) values (?,?,?,?)";
        template.update(sql , sdate + " " + stime , sdate + " " + etime , employee_id , user_id);
        mav.clear();
        mav.setViewName("redirect:/customer/showcustsch");
        return mav;
    }   
    
}