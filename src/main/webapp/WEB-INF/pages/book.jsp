<%--
  Created by IntelliJ IDEA.
  User: sebastian
  Date: 13.02.18
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>


<html>
<head>
    <title>Book</title>

    <style>
        <%@include file='../resources/style.css' %>
    </style>
</head>
<body>
    <br>
    <br>

    <br>
    <table class="tg" align="center" width="70%">
        <tr>
            <th width=5%>ID</th>
            <th width=20%>Название книги</th>
            <th width=35%>Описание</th>
            <th width=15%>Автор</th>
            <th width=15%>ISBN</th>
            <th width=10%>Год издания</th>
        </tr>
        <tr>
            <td align="center">${book.id}</td>
            <td>${book.title}</td>
            <td>${book.description}</td>
            <td align="center">${book.author}</td>
            <td align="center">${book.isbn}</td>
            <td align="center">${book.printYear}</td>
        </tr>

    </table>
    <br>

    <table align="center" width="70%">
        <tr>
            <td>
                <form action="/" >
                    <button type="submit">На полку</button>
                </form>
            </td>
        </tr>

    </table>



</body>
</html>
