<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Show Expense</title>
    </jsp:attribute>
    <jsp:body>
        <div class="main">
                <h2>Expenses</h2><br>
                <c:forEach items="${elist}" var="item">
                    <div class="card past">
                            <div class="content">
                                <h4>Description : ${item.get("description")}</h4>
                                <p>Date : ${item.get("edate")}<p>
                                <p>Amount : ${item.get("amount")}<p>
                                <p>Added By : ${item.get("first_name")} ${item.get("last_name")}</p>
                            </div>
                        </div>
                    <br>              
                </c:forEach>
            </div>
    </jsp:body>
</t:wrapper>