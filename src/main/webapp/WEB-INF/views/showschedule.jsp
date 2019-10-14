<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>My Schedule</title>
    </jsp:attribute>
    <jsp:body>
            <div class="main">
                    <h2>Upcoming Meetings</h2><br>
                    <c:forEach items="${upcomingMeetings}" var="item">
                            <div class="card upcoming">
                                    <div class="content">
                                      <h3>${item.get("start_time")}</h3>
                                      <p>Meeting Customer : ${item.get("first_name")} ${item.get("last_name")}
                                        <br>
                                        Contact Number : <c:forEach items='${item.get("contact_no")}' var="co">
                                            ${co.get("contact_number")} 
                                        </c:forEach><br>
                                        Email ID : <c:forEach items='${item.get("email_id")}' var="co">
                                            ${co.get("email_id")} 
                                        </c:forEach><br>
                                      </p>
                                      <p>Expected End Time : ${item.get("end_time")}</p>
                                      <p>Minutes : <br> ${item.get("minutes")}</p>
                                      <p>Rating : ${item.get("rating")}</p>
        
                                    </div>
                                  </div><br>              
                    </c:forEach>
                    <h2>Past Meetings</h2><br>
                    <c:forEach items="${pastMeetings}" var="item">
                        <div class="card past">
                                <div class="content">
                                    <h3>${item.get("start_time")}</h3>
                                    <p>Meeting Customer : ${item.get("first_name")} ${item.get("last_name")}
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
        
                    <h2>Others</h2><br>
                    <c:forEach items="${schlist}" var="item">
                            <div class="card upcoming">
                                    <div class="content">
                                      <h3>${item.get("dis_start_time")}</h3>
                                      <p>Description : ${item.get("description")}</p>
                                      <p>End Time : ${item.get("dis_end_time")}</p>
                                      <form action = "/employee/deletesch" method = "POST">
                                        <input type="hidden" name = "start_time" value = '${item.get("start_time")}'/>
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <button class ="edit delete" type="submit">Delete</button>
                                    </form>
                                    </div>
                                  </div><br>              
                    </c:forEach>
        
                </div>
        
    </jsp:body>
</t:wrapper>