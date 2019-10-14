<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Show Customers</title>
    </jsp:attribute>
    <jsp:body>
        <div class="row">
            <div class="col-sm-4">    
            <div class="form-container">
                    <div class="active-form" id="signup-container">
                        <h3 class="title">Filter Sort Search</h3>
                        <form class="signin-form" action = "${pageContext.request.contextPath}/employee/showcust" method="GET">
                            City<select class="username" name="city" >
                                <option class="username" value = "">All</option>
                                <c:forEach items = "${allCityList}" var = "item">
                                    <c:choose>
                                        <c:when test = '${item == city}'>
                                            <option class="username" value = "${item}" selected >${item}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option class="username" value = "${item}">${item}</option>
                                        </c:otherwise>
                                    </c:choose> 
                                </c:forEach>
                            </select>
    
                            Industry<select class="username" name="industry" placeholder="Industry">
                                <option class="username" value = "">All</option>
                                <c:forEach items = "${allIndustryList}" var = "item">
                                    <c:choose>
                                        <c:when test = '${item == industry}'>
                                            <option class="username" value = "${item}" selected >${item}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option class="username" value = "${item}">${item}</option>
                                        </c:otherwise>
                                    </c:choose> 
                                </c:forEach>
                            </select>
    
                            Gender<select class="username" name="gender" >
                                <option class="username" value = "">All</option>
                                <c:choose>
                                    <c:when test = '${"Male" == gender}'>
                                        <option class="username" value = "Male"selected >Male</option>
                                    </c:when>
                                    <c:when test = '${"Male" != gender}'>
                                        <option class="username" value = "Male" >Male</option>
                                    </c:when>
                                </c:choose> 
                                <c:choose>
                                    <c:when test = '${"Female" == gender}'>
                                        <option class="username" value = "Female"selected >Female</option>
                                    </c:when>
                                    <c:when test = '${"Female" != gender}'>
                                        <option class="username" value = "Female" >Female</option>
                                    </c:when>        
                                </c:choose>
                            </select>
        
                            Minimum Revenue:
                            <input class="username" type="text" placeholder="minrev" name = "minrev" value = "${minrev}" />
                            Maximum Revenue (Max value 2140000000):
                            <input class="username" type="text" placeholder="maxrev" name = "maxrev" value = "${maxrev}" /> 
                            SORT-BY<select class="username" name="sortby" placeholder="SortBY">
                                    <option class="username" value = "">All</option>
                                    <c:choose>
                                            <c:when test = '${sortby == "first_name"}'>
                                                <option class="username" value = "first_name" selected>First Name</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option class="username" value = "first_name">First Name</option>
                                            </c:otherwise>        
                                        </c:choose>
                                        <c:choose>
                                                <c:when test = '${sortby == "city"}'>
                                                        <option class="username" value = "city" selected>City</option>
                                                    </c:when>
                                                <c:otherwise>
                                                        <option class="username" value = "city">City</option>
                                                </c:otherwise>        
                                            </c:choose>
                                            <c:choose>
                                                <c:when test = '${sortby == "revenue"}'>
                                                        <option class="username" value = "revenue" selected>Revenue</option>
                                                    </c:when>
                                                <c:otherwise>
                                                        <option class="username" value = "revenue">Revenue</option>
                                                    </c:otherwise>        
                                            </c:choose>
                                            <c:choose>
                                                <c:when test = '${sortby == "industry"}'>
                                                        <option class="username" value = "industry" selected>Industry</option>
                                                    </c:when>
                                                <c:otherwise>
                                                        <option class="username" value = "industry">Industry</option>
                                                    </c:otherwise>        
                                            </c:choose>
                                </select>
                                Ascending/Descending
                                <select name="asc" class="username">
                                    <option class="username" value = "ASC">Ascending</option>
                                    <c:choose>
                                        <c:when test = '${asc == "DESC"}'>
                                            <option class="username" value = "DESC" selected>Descending</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option class="username" value = "DESC">Descending</option>
                                        </c:otherwise>        
                                        </c:choose> 
                                </select>
                                Search By Name
                            <input class="username" placeholder="Name" type="text" name="search" value = "${search}" />
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <button type="submit">Submit</button>
                        </form>
                    </div>
                </div>    

            </div>

        <div class="col-sm-8">    
            <div class="main">
                <h2>Customers</h2><br>
                <c:forEach items="${allCust}" var="item">
                    <div class="card past">
                            <div class="content">
                                <h3>${item.get("first_name")} ${item.get("last_name")}</h3>
                                <p>City : ${item.get("city")}</p>
                                <p>Revenue : ${item.get("revenue")}</p>
                                <p>Industry : ${item.get("industry")}</p>
                                <p>Gender : ${item.get("gender")}</p>
                                <form action = "/employee/viewcustomer" method = "GET">
                                    <input type="hidden" name = "customer_id" value = '${item.get("customer_id")}'/>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button class = "edit" type="submit">View</button>
                                </form>
                            </div>
                        </div>
                    <br>              
                </c:forEach>
            </div>
        </div>
        </div>
    </jsp:body>
</t:wrapper>