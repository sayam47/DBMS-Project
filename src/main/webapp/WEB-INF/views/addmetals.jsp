<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Add Metals</title>
    </jsp:attribute>
    <jsp:body>
        <div class="form-container">
            <div class="active-form" id="signup-container">
                <h2 class="title">Add Metal</h2>
                <span>${message}</span><br>
                <form class="signin-form" action = "${pageContext.request.contextPath}/customer/addmetals" method="POST">
                    <input class="username" type="text" placeholder="Type" name = "name" required />
                    <input class="username" type="number" placeholder="Average Buy Price" name = "price" required />
                    <input class="username" type="number" placeholder="Quantity" name = "quan" required />
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit">Add Metal</button>
                </form>
            </div>
        </div>

    </jsp:body>
</t:wrapper>