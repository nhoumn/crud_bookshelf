<%--
  Created by IntelliJ IDEA.
  User: sebastian
  Date: 13.02.18
  Time: 14:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>

<html>
<head>
    <title>Bookshelf</title>
    <style>
        <%@include file='../resources/style.css' %>
    </style>
</head>

<body>
    <table class="form" align="center" width="70%">
        <tr>
            <td class="form" align="left">
                <form action="/">Поиск по названию:
                    <input class="searchfield" type="text" placeholder="минимум 3 символа" name="bookTitle" />
                    <input class="btn" type="submit" value="Найти" />
                </form>
            </td>
            <td class="form" align="right">
                <form action="/">Поиск по году издания: с
                    <input class="yearfield" type="text" name="yearFrom" /> по
                    <input class="yearfield" type="text"  name="yearTo">
                    <input class="btn" type="submit" value="Найти" />
                </form>
            </td>
        </tr>
    </table>

    <c:if test="${!empty listBooks}">
        <table class="tg" align="center" width="70%">
            <tr>
                <th width=5%>ID</th>
                <th width=20%>Название книги</th>
                <%--<th width=30%>Description</th>--%>
                <th width=20%>Автор</th>
                <%--<th width=10%>ISBN</th>--%>
                <th width=15%>Год издания</th>
                <th width=15%>Статус</th>
                <th width=25%></th>
                <%--<th width=5%></th>--%>
                <%--<th width=5%></th>--%>
            </tr>
            <%--<tr height="10px" bgcolor="#eeeeee">--%>

            <%--</tr>--%>
            <c:forEach items="${listBooks}" var="book">
                <tr>
                    <td align="center">${book.id}</td>
                    <td><a href="<c:url value='/read/${book.id}'/>">${book.title}</a></td>
                    <%--<td align="left"><p>${book.description}</p></td>--%>
                    <td align="center">${book.author}</td>
                    <%--<td align="center">${book.isbn}</td>--%>
                    <td align="center">${book.printYear}</td>
                    <c:if test="${!book.readAlready}">
                        <td align="center">Не прочитана</td>
                    </c:if>
                    <c:if test="${book.readAlready}">
                        <td align="center">Прочитана</td>
                    </c:if>
                   <td>
                       <div class="actions">
                           <div class="bt" align="right">
                               <form action="/delete/${book.id}">
                                   <button class="btn" type="submit" style="color: tomato" >Убрать</button>
                               </form>
                           </div>
                           <div class="bt" align="center">
                               <form action="/edit/${book.id}">
                                   <button class="btn" type="submit">Заменить</button>
                               </form>
                           </div>

                       </div>
                   </td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
    <c:if test="${empty listBooks}">
        <table align="center">
            <tr>
                <td align="center">
                    Список книг пуст.
                </td>
            </tr>
        </table>
    </c:if>

    <table class="material" width="70%" align="center">
        <tr align="center">
            <td align="center">
                <c:url value="/" var="prev">
                    <c:param name="page" value="${page-1}"/>
                </c:url>
                <c:if test="${page > 1}">
                    <a href="<c:out value="${prev}" />" class="link">Предыдущая</a>
                </c:if>

                <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
                    <c:choose>
                        <c:when test="${page == i.index}">
                            <span>${i.index}</span>
                        </c:when>
                        <c:otherwise>
                            <c:url value="/" var="url">
                                <c:param name="page" value="${i.index}"/>
                            </c:url>
                            <a href='<c:out value="${url}" />' class="link">${i.index}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:url value="/" var="next">
                    <c:param name="page" value="${page + 1}"/>
                </c:url>
                <c:if test="${page + 1 <= maxPages}">
                    <a href='<c:out value="${next}" />' class="link">Следующая</a>
                </c:if>
            </td>
        </tr>
    </table>

    <c:url var="addAction" value="/books/create" />

    <form:form action="${addAction}" commandName="book">


        <table class="form" align="center" width="70%">
            <%--<tr>--%>
                <%--<td align="left">--%>
                    <%--<c:if test="${!empty book.title}">--%>
                        <%--ЗАМЕНИТЬ КНИГУ--%>
                    <%--</c:if>--%>
                    <%--<c:if test="${empty book.title}">--%>
                        <%--ДОБАВИТЬ КНИГУ--%>
                    <%--</c:if>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <c:if test="${!empty book.title}">
                <tr >
                    <td class = "fieldname" align="right">
                        <form:label path="id">
                            <spring:message text="ID: "/>
                        </form:label>
                    </td>
                    <td align="left">
                        <form:input class="yearfield" path="id" readonly="true"  disabled="true" />
                        <form:hidden path="id"/>
                    </td>
                </tr>
            </c:if>
            <tr>
                <td class = "fieldname" align="right">
                    <form:label path="title">
                        <spring:message text="Название книги:"/>
                    </form:label>
                </td>
                <td align="left">
                    <form:input cssClass="field" width="250px" path="title"/>
                </td>
            </tr>

            <tr>
                <td class = "fieldname" align="right">
                    <form:label path="description">
                        <spring:message text="Описание:"/>
                    </form:label>
                </td>
                <td align="left">
                    <form:input cssClass="field" width="250px" path="description"/>
                </td>
            </tr>

            <c:if test="${empty book.title}">
                <tr>
                    <td class = "fieldname" align="right">
                        <form:label path="author">
                            <spring:message text="Автор:"/>
                        </form:label>
                    </td>
                    <td align="left">
                        <form:input cssClass="field" width="250px" path="author"/>
                    </td>
                </tr>
            </c:if>

            <c:if test="${!empty book.title}">
                <tr>
                    <td class = "fieldname" align="right">
                        <form:label path="author">
                            <spring:message text="Автор: "/>
                        </form:label>
                    </td>
                    <td align="left">
                        <form:input cssClass="field" path="author" readonly="true" width="250px" disabled="true"/>
                        <form:hidden path="author"/>
                    </td>
                </tr>
            </c:if>
            <tr>
                <td class = "fieldname" align="right">
                    <form:label path="isbn">
                        <spring:message text="ISBN:"/>
                    </form:label>
                </td>
                <td align="left">
                    <form:input cssClass="field" width="250px" path="isbn"/>
                </td>
            </tr>
            <tr>
                <td class = "fieldname" align="right">
                    <form:label path="printYear">
                        <spring:message text="Год издания:"/>
                    </form:label>
                </td>
                <td align="left">
                    <form:input class="yearfield" path="printYear"/>
                </td>
            </tr>
            <tr>
                <td class = "fieldname" align="right">
                    <c:if test="${!empty book.title}">
                        <input class="btn" type="submit"
                               value="<spring:message text="ЗАМЕНИТЬ КНИГУ"/>"/>
                    </c:if>
                    <c:if test="${empty book.title}">
                        <input class="btn" type="submit"
                               value="<spring:message text="ДОБАВИТЬ КНИГУ"/>"/>
                    </c:if>
                </td>
            </tr>
        </table>
    </form:form>

</body>
</html>
