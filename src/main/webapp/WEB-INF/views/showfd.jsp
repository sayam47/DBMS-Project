<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>My Fd's</title>
    </jsp:attribute>
    <jsp:body>
        <div class="main">
            <h2>FD's</h2><br>
            <c:forEach items="${addFD}" var="item">
                <div class="card past">
                        <div class="content">
                            <h4>Bank Name : ${item.get("bank_name")}</h4>
                            <p>Amount : ${item.get("amount")}</p>
                            <p>Interest Rate : ${item.get("interest_rate")}</p>
                            <form action = "/customer/editfd" method = "GET">
                                <input class="username" type="hidden" name = "fd_id" value = '${item.get("fd_id")}'/>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button class="edit" type="submit">Edit</button>
                            </form>
                            <form action = "/customer/deletefd" method = "POST">
                                <input class="username" type="hidden" name = "fd_id" value = '${item.get("fd_id")}'/>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button class="edit delete" type="submit">Delete</button>
                            </form>
                        </div>
                    </div>
                <br>              
            </c:forEach>
        </div>

    </jsp:body>
</t:wrapper>