<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

  <header class="header">
    <div class="header__logo">
      <a href="<c:url value='/trang-chu' />"><img src = "${pageContext.request.contextPath}/template/web/assets/images/logo.svg"></a>
    </div>
    <div class="header__menu">
      <ul>
        <li>
          <a href="${pageContext.request.contextPath}/dang-nhap" login-button>Login</a>
        </li>
      </ul>
    </div>
  </header>