<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Update FD</title>
    </jsp:attribute>
    <jsp:body>
        <div class="form-container">
            <div class="active-form" id="signup-container">
                <h2 class="title">Update FD</h2>
                <form class="signin-form" action = "${pageContext.request.contextPath}/customer/editfd" method="POST">
                    <input class="username" type="text" placeholder="Bank Name" name = "bname" value = '${item.get("bank_name")}' required />
                    <input class="username" type="number" placeholder="Amount" name = "amount" value = '${item.get("amount")}' required />
                    <input class="username" type="number" placeholder="Interest Rate" name = "rate" value = '${item.get("interest_rate")}' required />
                    <input type="hidden" name = "fd_id" value = '${item.get("fd_id")}' required />
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit">Edit FD</button>
                </form>
            </div>
        </div>

    </jsp:body>
</t:wrapper>