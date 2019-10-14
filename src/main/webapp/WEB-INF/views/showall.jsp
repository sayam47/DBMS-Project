<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" >
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:th="http://www.thymeleaf.org">
    <head>
        <title>All Employee</title>
        <link href="/css/try.css" rel="stylesheet" >
    </head>    
    <body>
        <table>
            <tr>
              <th>Username</th>
              <th>Firstname</th>
              <th>Lastname</th>
              <th>Designation</th>
            </tr>
            <c:forEach items = "${list}" var="employee">
                <tr>
                    <td>${employee.getEmployee_id()}</td>
                    <td>${employee.getFirst_name()}</td>
                    <td>${employee.getLast_name()}</td>
                    <td>${employee.getDesignation()}</td>
                </tr>
            </c:forEach>
          </table>
          
    </body>
</html>