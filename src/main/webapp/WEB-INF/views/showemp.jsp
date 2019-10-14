<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Show Employees</title>
    </jsp:attribute>
    <jsp:body>
        <div class="row">
            <div class="col-sm-4">    
            <div class="form-container">
                    <div class="active-form" id="signup-container">
                        <h3 class="title">Filter Sort Search</h3>
                        <form class="signin-form" action = "${pageContext.request.contextPath}/admin/showemp" method="GET">    
                            Designation<select class="username" name="desg" >
                                    <option class="username" value = "">All</option>
                                    <c:forEach items = "${allDesgList}" var = "item">
                                        <c:choose>
                                            <c:when test = '${item == desg}'>
                                                <option class="username" value = "${item}" selected >${item}</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option class="username" value = "${item}">${item}</option>
                                            </c:otherwise>
                                        </c:choose> 
                                    </c:forEach>
                                </select>
            
                            Sort-By<select class="username" name="sortby" placeholder="SortBY">
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
                                                <c:when test = '${sortby == "date_of_birth"}'>
                                                        <option class="username" value = "date_of_birth" selected>Birth Date</option>
                                                    </c:when>
                                                <c:otherwise>
                                                        <option class="username" value = "date_of_birth">Birth Date</option>
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
                <h2>Employees</h2><br>
                <c:forEach items="${allEmp}" var="item">
                    <div class="card past">
                            <div class="content">
                                <h3>${item.get("first_name")} ${item.get("last_name")}</h3>
                                <p>Designation : ${item.get("designation")}</p>
                                <p>Date Of Birth : ${item.get("date_of_birth")}</p>
                                <form action = "/admin/viewemp" method = "GET">
                                    <input type="hidden" name = "employee_id" value = '${item.get("employee_id")}'/>
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