<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Add FD</title>
    </jsp:attribute>
    <jsp:body>
        <div class="form-container">
            <div class="inactive-form" id="signup-container">
                <h2 class="title">Add FD</h2>
                <form class="signin-form" action = "${pageContext.request.contextPath}/customer/addfd" method="POST">
                    <input class="username" type="text" placeholder="Bank Name" name = "bname" required />
                    <input class="username" type="number" placeholder="Amount" name = "amount" required />
                    <input class="username" type="number" placeholder="Interest Rate" name = "rate" required />
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit">Add FD</button>
                </form>
            </div>
        </div>
    </jsp:body>
</t:wrapper>