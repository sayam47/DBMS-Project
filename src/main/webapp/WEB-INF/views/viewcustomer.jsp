<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Profile</title>
    </jsp:attribute>
    <jsp:body>
        <c:if test="${message == null}">
            <div class="main">
                <h2>Customer Details</h2><br>
                    <div class="card past">
                        <div class="content">
                            <h3>${item1.get("first_name")} ${item1.get("last_name")}</h3>
                            <p>City : ${item1.get("city")}</p>
                            <p>State : ${item1.get("state")}</p>
                            <p>Revenue : ${item1.get("revenue")}</p>
                            <p>Industry : ${item1.get("industry")}</p>
                            <p>Gender : ${item1.get("gender")}</p>
                            <p>Contact Number : <c:forEach items='${item1.get("contact_no")}' var="co">
                                ${co.get("contact_number")} 
                            </c:forEach></p>
                            <p>Email ID : <c:forEach items='${item1.get("email_id")}' var="co">
                                ${co.get("email_id")} 
                            </c:forEach></p>
                    </div>
                    </div>
                    <br>
                    <h2>Customer Holdings</h2><br>
                    <h3>FD's</h3><br>
                    <c:forEach items="${item1.get('addFD')}" var="item">
                        <div class="card past">
                                <div class="content">
                                    <h4>Bank Name : ${item.get("bank_name")}</h4>
                                    <p>Amount : ${item.get("amount")}</p>
                                    <p>Interest Rate : ${item.get("interest_rate")}</p>
                                </div>
                            </div>
                        <br>              
                    </c:forEach>
                    <h3>Metals's</h3><br>
                    <c:forEach items="${item1.get('allME')}" var="item">
                        <div class="card past">
                                <div class="content">
                                    <h4>Type : ${item.get("type")}</h4>
                                    <p>Average Buy Price : ${item.get("average_buy_price")}</p>
                                    <p>Quantity : ${item.get("quantity")}</p>
                                </div>
                            </div>
                        <br>              
                    </c:forEach>
                    <h3>Equity</h3><br>
                    <c:forEach items="${item1.get('allEQ')}" var="item">
                        <div class="card past">
                                <div class="content">
                                    <h4>Ticker Symbol : ${item.get("ticker_symbol")}</h4>
                                    <p>Average Buy Price : ${item.get("average_buy_price")}</p>
                                    <p>Quantity : ${item.get("quantity")}</p>
                                </div>
                            </div>
                        <br>              
                    </c:forEach>
                    <h2>Funds</h2><br>
                    <c:forEach items="${item1.get('allFU')}" var="item">
                        <div class="card past">
                                <div class="content">
                                    <h4>${item.get("amc_fund_house")}</h4>
                                    <p>Average Buy Price : ${item.get("average_buy_price")}</p>
                                    <p>Quantity : ${item.get("quantity")}</p>
                                </div>
                            </div>
                        <br>              
                    </c:forEach>
        
                    <h2>Customer Meetings</h2><br>
                    <h3>Upcoming Meetings</h3><br>
                    <c:forEach items="${item1.get('upcomingMeetings')}" var="item">
                            <div class="card upcoming">
                                    <div class="content">
                                    <h3>${item.get("start_time")}</h3>
                                    <p>Meeting Employee : ${item.get("first_name")} ${item.get("last_name")}
                                        <br>
                                        Contact Number : <c:forEach items='${item.get("contact_no")}' var="co">
                                            ${co.get("contact_number")} 
                                        </c:forEach><br>
                                        Email ID : <c:forEach items='${item.get("email_id")}' var="co">
                                            ${co.get("email_id")} 
                                        </c:forEach><br>
                                        </p>
                                        <p>Expected End Time : ${item.get("end_time")}</p>
                                    <!-- <p>Minutes : <br> ${item.get("minutes")}</p> -->
                                    </div>
                                </div><br>              
                    </c:forEach>
                    <h3>Past Meetings</h3><br>
                    <c:forEach items="${item1.get('pastMeetings')}" var="item">
                        <div class="card past">
                                <div class="content">
                                    <h3>${item.get("start_time")}</h3>
                                    <p>Meeting Employee : ${item.get("first_name")} ${item.get("last_name")}
                                    <br>
                                    Contact Number : <c:forEach items='${item.get("contact_no")}' var="co">
                                        ${co.get("contact_number")} 
                                    </c:forEach><br>
                                    Email ID : <c:forEach items='${item.get("email_id")}' var="co">
                                        ${co.get("email_id")} 
                                    </c:forEach><br>
                                    </p>
                                    <p>End Time : ${item.get("end_time")}</p>
                                    <p>Minutes : <br> ${item.get("minutes")}</p>
                                    <p>Rating : ${item.get("rating")}</p>
                                    <form action = "/meeting/editmeeting" method = "GET">
                                        <input class="username" type="hidden" name = "meeting_id" value = '${item.get("meeting_id")}'/>
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <button class ="edit" type="submit">Edit</button>
                                    </form>
                            </div>
                            </div>
                        <br>              
                    </c:forEach>
                </div>
        </c:if>
        <c:if test="${message != null}">
            ${message}
        </c:if>
    </jsp:body>
</t:wrapper>