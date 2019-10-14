<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Add Expense</title>
    </jsp:attribute>
    <jsp:body>
        <div class="form-container">
            <div class="inactive-form" id="signup-container">
                <h2 class="title">Add Expense</h2>
                <form class="signin-form" action = "${pageContext.request.contextPath}/employee/addexpense" method="POST">
                    <span>${message}<br></span>
                    <input class="username" type="text" placeholder="Description" name = "desc" required />
                    <input class="username" type="number" placeholder="Amount" name = "amount" required />
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit">Add Expense</button>
                </form>
            </div>
        </div>
        <script>
                var newURL = location.href.split("?")[0];
                window.history.pushState('object', document.title, newURL);
            </script>    

    </jsp:body>
</t:wrapper>