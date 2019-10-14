<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Profile</title>
    </jsp:attribute>
    <jsp:body>
        <div class="main">
            <h2>Customer Details</h2><br>
                <div class="card past">
                    <div class="content">
                        <h3>${item.get("first_name")} ${item.get("last_name")}</h3>
                        <p>City : ${item.get("city")}</p>
                        <p>State : ${item.get("state")}</p>
                        <p>Revenue : ${item.get("revenue")}</p>
                        <p>Industry : ${item.get("industry")}</p>
                        <p>Gender : ${item.get("gender")}</p>
                        <p>Contact Number : <c:forEach items='${item.get("contact_no")}' var="co">
                            ${co.get("contact_number")} 
                        </c:forEach></p>
                        <p>Email ID : <c:forEach items='${item.get("email_id")}' var="co">
                            ${co.get("email_id")} 
                        </c:forEach></p>

                        <form action = "/customer/editprofile" method = "get">
                            <input class="username" type="hidden" name = "customer_id" value = '${item.get("customer_id")}'/>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <button class="edit" type="submit">Edit</button>
                        </form>
                </div>
                </div>
            <br>              
        </div>

    </jsp:body>
</t:wrapper>