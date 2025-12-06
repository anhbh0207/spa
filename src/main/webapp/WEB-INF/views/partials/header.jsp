<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="topbar">
    <div><b><c:out value="${pageTitle}" /></b></div>
    <div>
        <c:if test="${not empty sessionScope.currentUser}">
            Xin chào, <b>${sessionScope.currentUser.username}</b>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Đăng xuất</a>
        </c:if>
    </div>
</div>
