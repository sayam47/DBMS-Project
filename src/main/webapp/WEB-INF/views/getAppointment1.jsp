<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Get Appointment</title>
    </jsp:attribute>
    <jsp:body>
        <div class="form-container">
            <div class="inactive-form" id="signup-container">
                <h3 class="title">Select Employee</h3>
                <h5 class="title">${message}</h5>
                <form class="signin-form" action = "${pageContext.request.contextPath}/customer/getappointment1" method="POST">
                    <input class="username" type="text" onfocus="(this.type='date')" onblur="(this.type='text')" placeholder="Date" name = "sdate" value = "${sdate}" readonly />
                    <input class="username" type="text" onfocus="(this.type='time')" onblur="(this.type='text')" placeholder="Start Time" name = "stime" value = "${stime}" readonly />
                    <input class="username" type="text" onfocus="(this.type='time')" onblur="(this.type='text')" placeholder="Expected End Time" name = "etime" value = ${etime} readonly />
                    <select class="username" name="foremp">
                        <c:forEach items = "${freeEmplist}" var = "item">
                            <option class="username" value = "${item.employee_id}">${item.first_name} ${item.last_name}</option>
                        </c:forEach>
                    </select>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit">Add Appointment</button>
                    <a href="${pageContext.request.contextPath}/customer/getappointment"><button type="button">Change Time</button></a>
                </form>
            </div>
        </div>
    
        <script>
            var newURL = location.href.split("?")[0];
            window.history.pushState('object', document.title, newURL);
        </script>    
      
    </jsp:body>
</t:wrapper>