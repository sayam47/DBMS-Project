<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:wrapper>
    <jsp:attribute name="head">
        <title>Error</title>
    </jsp:attribute>
    <jsp:body>
        <h2>An unknown error occured</h2>
        <h3>${message}</h3>
    </jsp:body>
</t:wrapper>
