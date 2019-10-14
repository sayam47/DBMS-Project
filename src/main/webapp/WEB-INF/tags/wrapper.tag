<%@tag description="Simple Wrapper Tag" pageEncoding="UTF-8"%>
<%@attribute name="include" fragment="true" %>
<%@attribute name="head" fragment="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>


<jsp:invoke fragment="include"/>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="" name="keywords">
  <meta content="" name="description">
  
  <link href="/lib/fonts/gfonts" rel="stylesheet" >

  <link href="/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <link href="/css/style.css" rel="stylesheet">
  <link rel="stylesheet" href="/css/login_sign.css">
  <link rel="stylesheet" href="/css/tiles.css">

  <jsp:invoke fragment="head"/>

</head>
<body data-spy="scroll" data-target="#navbar-example">
        <header>
          <div id="sticker" class="header-area stick">
            <div class="container">
              <div class="row">
                <div class="col-md-12 col-sm-12">
      
                  <nav class="navbar navbar-default">
                    <div class="navbar-header">
                      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".bs-example-navbar-collapse-1" aria-expanded="false">
                                              <span class="sr-only">Toggle navigation</span>
                                              <span class="icon-bar"></span>
                                              <span class="icon-bar"></span>
                                              <span class="icon-bar"></span>
                                          </button>
                      <a class="navbar-brand sticky-logo" href="/">
                        <h1><span>F</span>inserve</h1>
                      </a>
                    </div>

                    <div class="collapse navbar-collapse main-menu bs-example-navbar-collapse-1" id="navbar-example">
                      <ul class="nav navbar-nav navbar-right">
                        <li>
                            <c:choose>
                                <c:when test="${pageContext.request.userPrincipal.name != null}" >
                                  <security:authorize access='hasAuthority("customer")'>
                                    <a  href="${pageContext.request.contextPath}/customer">Dashboard</a>
                                  </security:authorize>    
                                  <security:authorize access="hasAuthority('employee')">
                                    <a  href="${pageContext.request.contextPath}/employee">Dashboard</a>
                                  </security:authorize>    
                                </c:when>
                                <c:otherwise>
                                    <a  href="${pageContext.request.contextPath}/">Home</a>
                                </c:otherwise>
                            </c:choose>
                        </li>
                        <li>
                            <c:choose>
                                <c:when test="${pageContext.request.userPrincipal.name != null}" >
                                  <security:authorize access='hasAuthority("customer")'>
                                    <a  href="${pageContext.request.contextPath}/customer/profile">Go ${pageContext.request.userPrincipal.name}</a>
                                  </security:authorize>    
                                  <security:authorize access="hasAuthority('employee')">
                                    <a  href="${pageContext.request.contextPath}/employee/profile">Go ${pageContext.request.userPrincipal.name}</a>
                                  </security:authorize>    
                                  <security:authorize access="hasAuthority('new')">
                                      <a  href="#">Go ${pageContext.request.userPrincipal.name}</a>
                                  </security:authorize>    
                                </c:when>
                                <c:otherwise>
                                    <a  href="${pageContext.request.contextPath}/login">Login</a>
                                </c:otherwise>
                            </c:choose>
                        </li>
                          <security:authorize access="hasAuthority('admin')">
                            <li>
                              <a  href="${pageContext.request.contextPath}/admin/assignrole">Validate New Employee</a>
                            </li> 
                          </security:authorize>    
                        <li>
                            <c:choose>
                                <c:when test="${pageContext.request.userPrincipal.name != null}" >
                                    <form id="logoutForm" method="POST" action="${pageContext.request.contextPath}/logout">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    </form>
                                      <a class="page-scroll" onclick="document.forms['logoutForm'].submit()">Logout</a>
                                </c:when>
                                <c:otherwise>
                                    <a class="page-scroll" href="${pageContext.request.contextPath}/signup">Signup</a>
                                </c:otherwise>
                            </c:choose>
                        </li>
                      </ul>
                    </div>
                  </nav>
                </div>
              </div>
            </div>
          </div>
        </header>

        <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

        <script src="/lib/jquery/jquery.min.js"></script>
        <script src="/lib/jquery/jquery1.min.js"></script>
        <script src="/lib/jquery/jquery2.min.js"></script>

        <div id="about" class="about-area area-padding">
            <div class="container">
                <h1></h1>
                <jsp:doBody/>
            </div>
        </div>


    </body>            
</html>
            