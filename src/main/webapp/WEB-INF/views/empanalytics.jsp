<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>

<t:wrapper>
    <jsp:attribute name="head">
        <title>Analytics</title>
        <link rel="stylesheet" href="/css/hist.css">
      </jsp:attribute>
    <jsp:body>

            <h3>All Meetings</h3>
        <div class="card upcoming histo">
          <div class="row">  
            <c:forEach items ="${all}" var = "it">
                
                <div class="col-sm-4">${it.get("first_name")} ${it.get("last_name")}:</div> 
                <div class="col-sm-8">
                <div class="hori">   
                    <c:forEach begin="1" end="${it.get('count')}" varStatus="loop"> 
                    <div class = "hblock">
                        &nbsp;
                    </div>
                </c:forEach>
                </div>
                    <c:if test="${it.get('count') != null}">
                    ${it.get('count')}
                    </c:if>
                    <c:if test="${it.get('count') == null}">
                    0
                    </c:if>
                </div>
                <br><br>
            </c:forEach>
          </div>
        </div>
        <br>

        <h3>Past Meetings</h3>
        <div class="card upcoming histo">
          <div class="row">  
            <c:forEach items ="${past}" var = "it">
                
                <div class="col-sm-4">${it.get("first_name")} ${it.get("last_name")}:</div> 
                <div class="col-sm-8">
                <div class="hori">   
                    <c:forEach begin="1" end="${it.get('count')}" varStatus="loop"> 
                    <div class = "hblock">
                        &nbsp;
                    </div>
                </c:forEach>
                </div>
                    <c:if test="${it.get('count') != null}">
                    ${it.get('count')}
                    </c:if>
                    <c:if test="${it.get('count') == null}">
                    0
                    </c:if>
                </div>
                <br><br>
            </c:forEach>
          </div>
        </div>
        <br>

        <h3>Upcoming Meetings</h3>

        <div class="card upcoming histo">
            <div class="row">  
            <c:forEach items ="${upcoming}" var = "it">
                <div class="outer">
                <div class="col-sm-4">${it.get("first_name")} ${it.get("last_name")}:</div> 
                <div class="col-sm-8">
                <div class="hori">   
                    <c:forEach begin="1" end="${it.get('count')}" varStatus="loop"> 
                    <div class = "hblock">
                        &nbsp;
                    </div>
                </c:forEach>
                </div>
                    <c:if test="${it.get('count') != null}">
                    ${it.get('count')}
                    </c:if>
                    <c:if test="${it.get('count') == null}">
                    0
                    </c:if>
                </div>
                <br><br>
            </c:forEach>
            </div>
        </div>
        
        
    </jsp:body>
</t:wrapper>
