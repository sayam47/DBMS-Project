<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Sign in</title>
    </jsp:attribute>
    <jsp:body>
            <div class="form-container">
                    <div class="active-form" id="signin-container">
                      <form class="signin-form" method="POST" action="/login">
                        <h2 class="title">Sign in</h2>
                        <p class="text">Welcome back!</p>
                        <div class="form-group ${error != null ? 'has-error' : ''}">
                        <span>${error}</span>
                        <span>${message}</span>
                        <input class="username" type="text" placeholder="Username" name = "username" required/>
                        <input class="password" type="password" placeholder="Password" name = "password" required/>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <button type="submit">Log In</button>
                        <span id="signup-transition"><a href="${pageContext.request.contextPath}/signup">Do not have an account ? Sign up</a></span>
                      </div>
                      </form>
                    </div>
                  </div>  

            <script>
                var newURL = location.href.split("?")[0];
                window.history.pushState('object', document.title, newURL);
            </script>    
          
          

    </jsp:body>
</t:wrapper>