<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Assign Role</title>
    </jsp:attribute>
    <jsp:body>
        <div class="main">
                <h2>Validate Employee</h2><br>
            <c:forEach items = "${item1}" var = "item">
                <div class="card past">
                        <div class="content">
                            <h4>${item.get("first_name")} ${item.get("last_name")}</h4>
                            <p>Designation : ${item.get("designation")}</p>
                            <p>Date of Birth : ${item.get("date_of_birth")}</p>
                            <p>Contact Number : <c:forEach items='${item.get("contact_no")}' var="co">
                                ${co.get("contact_number")} 
                            </c:forEach></p>
                            <p>Email ID : <c:forEach items='${item.get("email_id")}' var="co">
                                ${co.get("email_id")} 
                            </c:forEach></p>    
                            <form action = "/admin/setroleemployee" method = "POST">
                                <input class="username" type="hidden" name = "user_id" value = '${item.get("user_id")}'/>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button class="edit" type="submit">Add Employee</button>
                            </form>
                        </div>
                    </div>
                <br>              
            </c:forEach>
        </div>

    </jsp:body>
</t:wrapper>