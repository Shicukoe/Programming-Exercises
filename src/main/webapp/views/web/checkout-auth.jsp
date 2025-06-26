<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Checkout Authentication</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f9fa; }
        .container { max-width: 800px; margin: 40px auto; background: #fff; border-radius: 8px; box-shadow: 0 2px 8px #ccc; padding: 32px; }
        .auth-forms { display: flex; gap: 40px; justify-content: space-between; }
        .auth-form { flex: 1; background: #f6f6f6; border-radius: 8px; padding: 24px; box-shadow: 0 1px 4px #eee; }
        h2 { color: #ffc107; margin-bottom: 16px; }
        label { display: block; margin-top: 12px; font-weight: bold; }
        input[type=text], input[type=password], input[type=email], input[type=tel] {
            width: 100%; padding: 8px; margin-top: 4px; border: 1px solid #ccc; border-radius: 4px;
        }
        .btn {
            background: #ffc107; color: #222; border: none; padding: 10px 24px; border-radius: 4px; font-weight: bold; margin-top: 18px; cursor: pointer;
        }
        .error { color: #d32f2f; margin-top: 10px; }
        .success { color: #388e3c; margin-top: 10px; }
    </style>
</head>
<body>
<div class="container">
    <h1>Checkout: Login or Register</h1>
    <div class="auth-forms">
        <!-- Login Form -->
        <form class="auth-form" method="post" action="${pageContext.request.contextPath}/checkout">
            <h2>Login</h2>
            <input type="hidden" name="action" value="login" />
            <label for="loginUsername">Username</label>
            <input type="text" id="loginUsername" name="loginUsername" required />
            <label for="loginPassword">Password</label>
            <input type="password" id="loginPassword" name="loginPassword" required />
            <button class="btn" type="submit">Login &amp; Continue</button>
            <c:if test="${not empty errorMessage}">
                <div class="error">${errorMessage}</div>
            </c:if>
        </form>
        <!-- Registration Form -->
        <form class="auth-form" method="post" action="${pageContext.request.contextPath}/checkout">
            <h2>Register</h2>
            <input type="hidden" name="action" value="register" />
            <label for="regUsername">Username</label>
            <input type="text" id="regUsername" name="regUsername" required />
            <label for="regPassword">Password</label>
            <input type="password" id="regPassword" name="regPassword" required />
            <label for="regFullName">Full Name</label>
            <input type="text" id="regFullName" name="regFullName" required />
            <label for="regEmail">Email</label>
            <input type="email" id="regEmail" name="regEmail" required />
            <label for="regPhone">Phone</label>
            <input type="tel" id="regPhone" name="regPhone" required />
            <label for="regAddress">Address</label>
            <input type="text" id="regAddress" name="regAddress" required />
            <button class="btn" type="submit">Register &amp; Continue</button>
            <c:if test="${not empty errorMessage}">
                <div class="error">${errorMessage}</div>
            </c:if>
        </form>
    </div>
</div>
</body>
</html>
