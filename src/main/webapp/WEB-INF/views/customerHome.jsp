<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>

<t:wrapper>
    <jsp:attribute name="head">
        <title>Customer Home</title>
    </jsp:attribute>
    <jsp:body>
        <h3><a href="${pageContext.request.contextPath}/customer/getappointment">Add Appointment</a></h3><br>
        <h3><a href="${pageContext.request.contextPath}/customer/showcustsch">View Meetings</a></h3><br>
        <h3><a href="${pageContext.request.contextPath}/customer/addfd">Add FD</a></h3><br>
        <h3><a href="${pageContext.request.contextPath}/customer/myfd">View FD</a></h3><br>
        <h3><a href="${pageContext.request.contextPath}/customer/addeq">Add Equity</a></h3><br>
        <h3><a href="${pageContext.request.contextPath}/customer/showeq">View Equity</a></h3><br>
        <h3><a href="${pageContext.request.contextPath}/customer/addmetals">Add Metals</a></h3><br>
        <h3><a href="${pageContext.request.contextPath}/customer/showmetals">View Metals</a></h3><br>
        <h3><a href="${pageContext.request.contextPath}/customer/addfund">Add Funds</a></h3><br>
        <h3><a href="${pageContext.request.contextPath}/customer/showfund">View Funds</a></h3><br>
    </jsp:body>
</t:wrapper>