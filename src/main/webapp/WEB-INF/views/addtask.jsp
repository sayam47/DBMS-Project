<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>


<t:wrapper>
    <jsp:attribute name="head">
        <title>Add Task</title>
    </jsp:attribute>
    <jsp:body>
        <div class="form-container">
            <div class="inactive-form" id="signup-container">
                <h2 class="title">Add Task</h2>
                <form class="signin-form" action = "${pageContext.request.contextPath}/employee/addtask" method="POST">
                    <span>${message}<br></span>
                    Task Description
                    <input class="username" type="text" placeholder="Task Description" name = "task_desc" required />
                    Deadline
                    <input class="username" type="text" onfocus="(this.type='date')" onblur="(this.type='text')" placeholder="Deadline" name = "deadline" required />
                    Employee
                    <div class="container1">
                        <div>
                            <select class="username" name="employee[]">
                                <c:forEach items = "${allEmp}" var = "item">
                                    <option class="username" value = '${item.get("employee_id")}'>${item.get("first_name")} ${item.get("last_name")}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <button type = "button" class = "add_employee">Add Employee 
                    </button>
    
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit">Add Task</button>

                </form>
            </div>
        </div>

        <script>
            var newURL = location.href.split("?")[0];
            window.history.pushState('object', document.title, newURL);
        </script>    


        <script lang="Javascript" type="text/javascript">
                $(document).ready(function() {
                    var max_fields = 10;
                    var wrapper = $(".container1");
                    var add_button = $(".add_employee");
    
                    var x = 1;
                    $(add_button).click(function(e) {
                        e.preventDefault();
                        if (x < max_fields) {
                            x++;
                            $(wrapper).append('<div> <select class="username" name="employee[]"> <c:forEach items = "${allEmp}" var = "item"> <option class="username" value = "${item.get('employee_id')}">${item.get("first_name")} ${item.get("last_name")}</option> </c:forEach> </select> <a href="#" class="delete">Delete</a></div>'); //add input box
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