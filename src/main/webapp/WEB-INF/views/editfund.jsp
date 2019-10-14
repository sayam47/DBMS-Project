<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Update Funds</title>
    </jsp:attribute>
    <jsp:body>
        <div class="form-container">
            <div class="active-form" id="signup-container">
                <h2 class="title">Edit Fund</h2>
                <form class="signin-form" action = "${pageContext.request.contextPath}/customer/editfund" method="POST">
                    <input class="username" type="text" placeholder="AMC/Fund House" name = "name" value = '${item.get("amc_fund_house")}' required />
                    <input class="username" type="number" placeholder="Average Buy Price" name = "price" value = '${item.get("average_buy_price")}' required />
                    <input class="username" type="number" placeholder="Quantity" name = "quan" value = '${item.get("quantity")}' required />
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit">Edit</button>
                </form>
            </div>
        </div>

    </jsp:body>
</t:wrapper>