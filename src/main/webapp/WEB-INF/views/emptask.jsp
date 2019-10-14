<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>

<t:wrapper>
    <jsp:attribute name="head">
        <title>Task</title>
    </jsp:attribute>
    <jsp:body>
        <div class="main">
                <h2>Pending</h2><br>
                <c:forEach items="${incompletedList}" var="item">
                    <div class="card past">
                            <div class="content">
                                <h4>Description : ${item.get("task_desc")}</h4>
                                <p>Date : ${item.get("given_date")}<p>
                                <p>Deadline : ${item.get("deadline")}<p>
                                <p>Given By : ${item.get("first_name")} ${item.get("last_name")}</p>
                                <form method="POST" action="${pageContext.request.contextPath}/employee/tasks/setComplete">
                                    <input type="hidden" name="complete_task_id" value = '${item.get("task_id")}' />
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button class="edit" type="submit">Mark Done</button>
                                </form>
                            </div>
                        </div>
                    <br>              
                </c:forEach>
                <h2>Completed</h2><br>
                <c:forEach items="${completedList}" var="item">
                    <div class="card past">
                            <div class="content">
                                <h4>Description : ${item.get("task_desc")}</h4>
                                <p>Date : ${item.get("given_date")}<p>
                                <p>Deadline : ${item.get("deadline")}<p>
                                <p>Done On : ${item.get("done_on")}<p>
                                <p>Given By : ${item.get("first_name")} ${item.get("last_name")}</p>
                            </div>
                        </div>
                    <br>              
                </c:forEach>

        </div>
    </jsp:body>
</t:wrapper>