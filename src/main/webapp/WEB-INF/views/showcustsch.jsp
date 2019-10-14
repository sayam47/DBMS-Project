<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Show Schedule</title>
    </jsp:attribute>
    <jsp:body>
        <c:forEach items="${csch}" var="item">
            ${item.get("start_time")}  ${item.get("end_time")} ${item.get("employee_id")} ${item.get("description")}  <br>
        </c:forEach>        
    </jsp:body>
</t:wrapper>