<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Edit Profile</title>
    </jsp:attribute>
    <jsp:body>
        <div class="form-container">
            <div class="active-form" id="signup-container">
                <h2 class="title">Edit Profile</h2>
                <form class="signin-form" action = "${pageContext.request.contextPath}/customer/editprofile" method="POST">
                    <span>${errormsg}</span><br>
                    <input class="username" type="text" placeholder="First Name" name = "first_name" value = "${item.get('first_name')}" required />
                    <input class="username" type="text" placeholder="Last Name" name = "last_name" value = "${item.get('last_name')}" />
                    <select class="username" name="gender" >
                        <c:choose>
                            <c:when test = '${"Male" == item.get("gender")}'>
                                <option class="username" value = "Male"selected >Male</option>
                            </c:when>
                            <c:when test = '${"Female" == item.get("gender")}'>
                                <option class="username" value = "Female"selected >Female</option>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test = '${"Male" != item.get("gender")}'>
                                <option class="username" value = "Male" >Male</option>
                            </c:when>
                            <c:when test = '${"Female" != item.get("gender")}'>
                                <option class="username" value = "Female" >Female</option>
                            </c:when>
                            <c:otherwise>
                            </c:otherwise>
                        </c:choose> 
                    </select>
                <input class="username" type="text" placeholder="City" name = "city" value = "${item.get('city')}" />
                    <input class="username" type="text" placeholder="State" name = "state" value = "${item.get('state')}" />
                    <input class="username" type="text" placeholder="Industry" name = "industry" value = "${item.get('industry')}" required />
                    <input class="username" type="text" placeholder="Revenue" name = "revenue" value = "${item.get('revenue')}" required />

                    <c:forEach items= '${item.get("contact_no")}' var="co">
                        <input class="username" type="number" name="contact[]" value="${co.get('contact_number')}" min=1000000000 max=9999999999 readonly required/>
                    </c:forEach>

                    <div class="container1">
                    </div>
                    <button class="add_contact">Add Contact Number
                        </button>
                    
                    <c:forEach items= '${item.get("email_id")}' var="co">
                        <input class="username" type="email" name="email[]" value="${co.get('email_id')}" readonly required/>
                    </c:forEach>
                    <div class="container2">
                    </div>
                    <button class="add_email">Add Email
                        </button>

                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>


                    <button type="submit">Edit Profile</button>
                </form>
            </div>
        </div>


        <script>
            $(document).ready(function() {
                var max_fields = 10;
                var wrapper = $(".container1");
                var add_button = $(".add_contact");

                var x = 1;
                $(add_button).click(function(e) {
                    e.preventDefault();
                    if (x < max_fields) {
                        x++;
                        $(wrapper).append('<div><input class="username" type="number" min = 1000000000 max = 9999999999 name="newcontact[]" placeholder = "Contact Number" required/><a href="#" class="delete">Delete</a></div>'); //add input box
                    } else {
                        alert('You Reached the limits')
                    }
                });

                $(wrapper).on("click", ".delete", function(e) {
                    e.preventDefault();
                    $(this).parent('div').remove();
                    x--;
                })
            });

            $(document).ready(function() {
                var max_fields = 10;
                var wrapper = $(".container2");
                var add_button = $(".add_email");

                var x = 1;
                $(add_button).click(function(e) {
                    e.preventDefault();
                    if (x < max_fields) {
                        x++;
                        $(wrapper).append('<div><input class="username" type="email" name="newemail[]" placeholder = "Email-id" required/><a href="#" class="delete">Delete</a></div>'); //add input box
                    } else {
                        alert('You Reached the limits')
                    }
                });

                $(wrapper).on("click", ".delete", function(e) {
                    e.preventDefault();
                    $(this).parent('div').remove();
                    x--;
                })
            });


        </script>


    </jsp:body>
</t:wrapper>