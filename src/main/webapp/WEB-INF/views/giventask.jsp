<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>

<t:wrapper>
    <jsp:attribute name="head">
        <title>Given Task</title>
    </jsp:attribute>
    <jsp:body>


        <div class="main">
                <h2>Given Task's</h2><br>
                <c:forEach items="${all_task}" var="item">
                    <div class="card past">
                            <div class="content">
                                <h4>Description : ${item.getTask_desc()}</h4>
                                <p>Given Date : ${item.getGiven_date()}</p>
                                <p>Deadline : ${item.getDeadline()}</p>
                                <p>Status : ${item.getStatus()}</p>
                                <c:if test = "${item.getStatus() == 1}">
                                    <p>Done On : ${item.getDone_on()}</p>
                                </c:if>
                                <p>Given To:<br>
                                    <c:forEach items="${item.getEmployeeList()}" var="emp">
                                        ${emp.get("first_name")} ${emp.get("last_name")}
                                        <br>
                                    </c:forEach>                            
                                </p>
                            </div>
                        </div>
                    <br>              
                </c:forEach>
            </div>
    </jsp:body>
</t:wrapper>