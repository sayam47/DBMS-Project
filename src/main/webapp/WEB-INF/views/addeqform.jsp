<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Add Equity</title>
    </jsp:attribute>
    <jsp:body>
        <div class="form-container">
            <div class="inactive-form" id="signup-container">
                <h2 class="title">Add Equity</h2>
                <span>${message}</span><br>
                <form class="signin-form" action = "${pageContext.request.contextPath}/customer/addeq" method="POST">
                    <input class="username" type="text" placeholder="Ticker Symbol" name = "tsymbol" required/>
                    <input class="username" type="number" placeholder="Average Buy Price" name = "price" required/>
                    <input class="username" type="number" placeholder="Quantity" name = "quan" required/>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit">Add Equity</button>
                </form>
            </div>
        </div>

    </jsp:body>
</t:wrapper>