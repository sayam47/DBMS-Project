<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:wrapper>
    <jsp:attribute name="head">
    </jsp:attribute>
    <jsp:body>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-container">
                    <div class="inactive-form" id="signup-container">
                      <form class="signup-form" method="POST" action="${pageContext.request.contextPath}/customer/signup">
                        <h2 class="title">Customer Sign up</h2>
                        <span>${cmessage}</span>
                        <input class="username" type="text" placeholder="Username" name = "username" required />
                        <input class="password" type="password" placeholder="Password" name = "password" required />
                        <input class="password" type="password" placeholder="Confirm Password" name = "cpassword" required />
                        <input class="username" type="text" placeholder="First Name" name = "first_name" required />
                        <input class="username" type="text" placeholder="Last Name" name = "last_name" />
                        <select class="username" name="gender">
                            <option class="username" value = "Male">Male</option>
                            <option class="username" value = "Female">Female</option>
                        </select>
                        <input class="username" type="text" placeholder="City" name = "city" />
                        <input class="username" type="text" placeholder="State" name = "state" />
                        <input class="username" type="text" placeholder="Industry" name = "industry" required />
                        <input class="username" type="number" placeholder="Revenue" name = "revenue" required />


                        <div class="container1">
                            <div><input class="username" type="number" min=1000000000 max=9999999999 name="contact[]" placeholder = "Contact Number" required/></div>
                        </div>
                        <button class="add_contact">Add Contact Number
                            </button>
                        
                        <div class="container2">
                            <div><input class="username" type="email" name="email[]" placeholder = "Email-id" required/></div>
                        </div>
                        <button class="add_email">Add Email
                            </button>

                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <button type="submit">Sign up</button>
                        <span id="signin-transition"><a href="${pageContext.request.contextPath}/login">Have an account ?Sign in</a></span>
                      </form>
                    </div>
                </div>
            </div>    
            <div class="col-sm-6">
                <div class="form-container">
                    <div class="active-form" id="signup-container">
                        <form class="signup-form" method="POST" action="${pageContext.request.contextPath}/employee/signup">
                            <h2 class="title">Employee Sign up</h2>
                            <span>${emessage}</span>
                            <input class="username" type="text" placeholder="Username" name = "username" required />
                            <input class="password" type="password" placeholder="Password" name = "password" required />
                            <input class="password" type="password" placeholder="Confirm Password" name = "cpassword" required />
                            <input class="username" type="text" placeholder="First Name" name = "fname" required />
                            <input class="username" type="text" placeholder="Last Name" name = "lname" required/>
                            <!-- <input class="username" type="text" placeholder="Designation" name = "desg" required /> -->
                            <select class="username" name="desg" required>
                                <option class="username" value = "Manager">Manager</option>
                                <option class="username" value = "Deputy Manager">Deputy Manager</option>
                                <option class="username" value = "Office Boy">Office Boy</option>
                            </select>
        
                            <input class="username" type="text" onfocus="(this.type='date')" onblur="(this.type='text')" placeholder="Date of Birth" name = "bdate" />

                            <div class="container1">
                                <div><input class="username" type="number" min=1000000000 max=9999999999 name="contact[]" placeholder = "Contact Number" required/></div>
                            </div>
                            <button class="add_contact">Add Contact Number
                                </button>
                            
                            <div class="container2">
                                <div><input class="username" type="email" name="email[]" placeholder = "Email-id" required/></div>
                            </div>
                            <button class="add_email">Add Email</button>
        
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <button type="submit">Sign up</button>
                            <span id="signin-transition"><a href="${pageContext.request.contextPath}/login">Have an account ?Sign in</a></span>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
            var newURL = location.href.split("?")[0];
            window.history.pushState('object', document.title, newURL);
        </script>    


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
                        $(wrapper).append('<div><input class="username" type="number" min=1000000000 max=9999999999 name="contact[]" placeholder = "Contact Number" required/><a href="#" class="delete">Delete</a></div>'); //add input box
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
                        $(wrapper).append('<div><input class="username" type="email" name="email[]" placeholder = "Email-id" required/><a href="#" class="delete">Delete</a></div>'); //add input box
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