<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<t:wrapper>
    <jsp:attribute name="head">
        <title>Update Meeting</title>
    </jsp:attribute>
    <jsp:body>
        <div class="form-container-edit-meeting">
            <div class="active-form" id="signup-container">
                <h2 class="title">Update Meeting</h2>
                <form class="signin-form" action = "${pageContext.request.contextPath}/meeting/editmeeting" method="POST">
                    <!-- <input class="username" type="text" onfocus="(this.type='time')" onblur="(this.type='text')" placeholder="End Time" name = "etime" value = '${item.get("end_time")}' /> -->
                    <!-- End-Time:
                    <input class="username" type="time" value = "${item.get('end_time')}" required />                     -->
                    Rating:
                    <security:authorize access='hasAuthority("customer")'>
                        <select class="username" name="rating" >
                            <c:forEach begin="1" end="10" varStatus="loop">
                                <c:choose>
                                    <c:when test = '${loop.index== item.get("rating")}'>
                                        <option class="username" value = "${loop.index}"selected >${loop.index}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option class="username" value = "${loop.index}">${loop.index}</option>
                                    </c:otherwise>
                                </c:choose> 
                            </c:forEach>
                        </select>
                    </security:authorize>    
                    <security:authorize access="hasAuthority('employee')">
                        <input class="username" name = "rating" value='${item.get("rating")}' readonly />
                    </security:authorize>    
                    Minutes:
                    <textarea rows="10" class = "username" type="text" name = "minutes">${item.get("minutes")}</textarea>
                    <input type="hidden" name = "meeting_id" value='${item.get("meeting_id")}' />
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit">Edit Meeting</button>
                </form>
            </div>
        </div>

    </jsp:body>
</t:wrapper>