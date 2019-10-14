<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Show Equity</title>
    </jsp:attribute>
    <jsp:body>
        <div class="main">
                <h2>Equity</h2><br>
                <c:forEach items="${allEQ}" var="item">
                    <div class="card past">
                            <div class="content">
                                <h4>Ticker Symbol : ${item.get("ticker_symbol")}</h4>
                                <p>Average Buy Price : ${item.get("average_buy_price")}</p>
                                <p>Quantity : ${item.get("quantity")}</p>
                                <form action = "/customer/editeq" method = "GET">
                                    <input type="hidden" name = "ticker_symbol" value = '${item.get("ticker_symbol")}'/>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button class = "edit" type="submit">Edit</button>
                                </form>
                                <form action = "/customer/deleteeq" method = "POST">
                                    <input type="hidden" name = "ticker_symbol" value = '${item.get("ticker_symbol")}'/>
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