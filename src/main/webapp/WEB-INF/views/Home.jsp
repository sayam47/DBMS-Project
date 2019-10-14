<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<t:wrapper>
    <jsp:attribute name="head">
        <title>Dashboard</title>
    </jsp:attribute>
    <jsp:body>
        <h3><a href="${pageContext.request.contextPath}/employee/addtask">Add Task</a></h3><br>
        <h3><a href="${pageContext.request.contextPath}/employee/tasks">My Task</a></h3><br>
        <h3><a href="${pageContext.request.contextPath}/employee/giventask">Given Task</a></h3><br>
        <h3><a href="${pageContext.request.contextPath}/employee/addschedule">Add Schedule</a></h3><br>
        <h3><a href="${pageContext.request.contextPath}/employee/showschedule">Show Schedule</a></h3><br>
        <h3><a href="${pageContext.request.contextPath}/employee/addexpense">Add Expense</a></h3><br>
        <h3><a href="${pageContext.request.contextPath}/employee/showexpense">Show Expense</a></h3><br>
        <h3><a href="${pageContext.request.contextPath}/employee/showcust">Show Customers</a></h3><br>
        <security:authorize access='hasAuthority("admin")'>
        <h3><a href="${pageContext.request.contextPath}/admin/showemp">Show Employees</a></h3><br>
        <h3><a href="${pageContext.request.contextPath}/admin/empanalytics">Employee Meeting Analytics</a></h3><br>
        <h3><a href="${pageContext.request.contextPath}/admin/change_office_hours">Change Office Hours</a></h3><br>
        </security:authorize>    
</jsp:body>
</t:wrapper>