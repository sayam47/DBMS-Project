<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Update Equity</title>
    </jsp:attribute>
    <jsp:body>
        <div class="form-container">
            <div class="inactive-form" id="signup-container">
                <h2 class="title">Edit Equity</h2>
                <form class="signin-form" action = "${pageContext.request.contextPath}/customer/editeq" method="POST">
                    <input class="username" type="text" placeholder="Ticker Symbol" name = "tsymbol" value = '${item.get("ticker_symbol")}' readonly required/>
                    <input class="username" type="text" placeholder="Average Buy Price" name = "price" value = '${item.get("average_buy_price")}' required />
                    <input class="username" type="text" placeholder="Quantity" name = "quan" value = '${item.get("quantity")}' required />
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit">Edit Equity</button>
                </form>
            </div>
        </div>

    </jsp:body>
</t:wrapper>