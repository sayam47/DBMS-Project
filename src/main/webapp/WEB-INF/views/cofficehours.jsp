<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Update Office Hours</title>
    </jsp:attribute>
    <jsp:body>
        <div class="form-container">
            <div class="active-form" id="signup-container">
                <h2 class="title">Update Office Hours</h2>
                <span>${message}</span><br>
                <form class="signin-form" action = "${pageContext.request.contextPath}/admin/change_office_hours" method="POST">
                    Start-Time:<input class="username" type="time" placeholder="Start Time" name = "office_hours_start" value = '${office_hours_start}' required />
                    End-Time:<input class="username" type="time" placeholder="End Time" name = "office_hours_end" value = '${office_hours_end}' required />
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit">Edit Office Hours</button>
                </form>
            </div>
        </div>

        <script>
            var newURL = location.href.split("?")[0];
            window.history.pushState('object', document.title, newURL);
        </script>    
    

    </jsp:body>
</t:wrapper>