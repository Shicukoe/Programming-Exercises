<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

  <header class="header">
    <div class="header__logo">
      <a href="<c:url value='/trang-chu' />"><img src = "${pageContext.request.contextPath}/template/web/assets/images/logo.svg"></a>
    </div>
    <div class="header__menu">
      <ul>
        <c:choose>
          <c:when test="${not empty sessionScope.username}">
            <li style="font-weight:bold; color:#ffc107;">Welcome, ${sessionScope.username}!</li>
            <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
          </c:when>
          <c:otherwise>
            <li>
              <a href="${pageContext.request.contextPath}/dang-nhap" login-button>Login</a>
            </li>
          </c:otherwise>
        </c:choose>
      </ul>
    </div>
  </header>