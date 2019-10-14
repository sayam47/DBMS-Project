<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Get Appointment</title>
    </jsp:attribute>
    <jsp:body>
        <div class="form-container">
            <div class="active-form" id="signup-container">
            <form class="signin-form" action = "${pageContext.request.contextPath}/customer/getappointment" method="POST">
                <h2 class="title">Add Appointment</h2>
                <div class="form-group ${message != null ? 'has-error' : ''}">
                <span>${message}</span>
                    <input class="username" type="text" onfocus="(this.type='date')" onblur="(this.type='text')" placeholder="Date" name = "sdate" required />
                    <input class="username" type="text" onfocus="(this.type='time')" onblur="(this.type='text')" placeholder="Start Time" name = "stime" required />
                    <input class="username" type="text" onfocus="(this.type='time')" onblur="(this.type='text')" placeholder="Expected End Time" name = "etime" required />
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit">Select Employee</button>
                </div>
            </form>
            </div>
        </div>
               
        <script>
            var newURL = location.href.split("?")[0];
            window.history.pushState('object', document.title, newURL);
            // window.history.replaceState({}, document.title, "/" + "my-new-url.html");
        </script>    
      
    </jsp:body>
</t:wrapper>