<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Show Metals</title>
    </jsp:attribute>
    <jsp:body>
        <div class="main">
                <h2>Metals's</h2><br>
                <c:forEach items="${allME}" var="item">
                    <div class="card past">
                            <div class="content">
                                <h4>${item.get("type")}</h4>
                                <p>Average Buy Price : ${item.get("average_buy_price")}</p>
                                <p>Quantity : ${item.get("quantity")}</p>
                                <form action = "/customer/editmetal" method = "GET">
                                    <input type="hidden" name = "type" value = '${item.get("type")}'/>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button class = "edit" type="submit">Edit</button>
                                </form>
                                <form action = "/customer/deletemetal" method = "POST">
                                    <input type="hidden" name = "type" value = '${item.get("type")}'/>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button class = "edit delete" type="submit">Delete</button>
                                </form>
                            </div>
                        </div>
                    <br>              
                </c:forEach>
            </div>
        
    </jsp:body>
</t:wrapper>