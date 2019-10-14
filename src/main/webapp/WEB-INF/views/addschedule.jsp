<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Add Schedule</title>
    </jsp:attribute>
    <jsp:body>
        <div class="form-container">
            <div class="inactive-form" id="signup-container">
                <h2 class="title">Add Schedule</h2>
                <form class="signin-form" action = "${pageContext.request.contextPath}/employee/addschedule" method="POST">
                    <span>${message}<br></span>
                    <input class="username" type="text" placeholder="Reason" name = "desc" required />
                    <input class="username" type="text" onfocus="(this.type='date')" onblur="(this.type='text')" placeholder="Start Date" name = "sdate" required />
                    <input class="username" type="text" onfocus="(this.type='time')" onblur="(this.type='text')" placeholder="Start Time" name = "stime" required />
                    <input class="username" type="text" onfocus="(this.type='date')" onblur="(this.type='text')" placeholder="End Date" name = "edate" required />
                    <input class="username" type="text" onfocus="(this.type='time')" onblur="(this.type='text')" placeholder="End Time" name = "etime" required />
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit">Add Schedule</button>
                </form>
            </div>
        </div>
        <script>
            var newURL = location.href.split("?")[0];
            window.history.pushState('object', document.title, newURL);
        </script>    

    </jsp:body>
</t:wrapper>