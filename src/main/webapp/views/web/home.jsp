<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Monito Pet Shop</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        header {
            background-color: #4CAF50;
            color: white;
            padding: 1rem;
            text-align: center;
        }
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        .login-options {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin-top: 2rem;
        }
        .login-btn {
            padding: 1rem 2rem;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        .login-btn:hover {
            background-color: #45a049;
        }
        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 1rem;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>
    <header class="header-banner">
        <img src="${pageContext.request.contextPath}/template/web/assets/images/logo.png" style="width: 100px;height: 100px;float: left;" alt="Monito Logo" class="logo">
        <h1>Welcome to Monito Pet Shop</h1>
        <p>Your one-stop shop for all pet needs</p>
    </header>

    <div class="container">
        <c:if test="${not empty errorMessage}">
            <div style="color: red; text-align: center; margin-bottom: 1rem; font-weight: bold;">
                ${errorMessage}
            </div>
        </c:if>
        <h2>About Us</h2>
        <p>Monito Pet Shop is a grand new website for providing healthy pets and quality pet supplies at affordable prices. Our mission is to match loving families with their perfect pets.</p>
        
        <h2>Our Services</h2>
        <ul>
            <li>Wide variety of pets including dogs, cats, bunnies, and more</li>
            <li>Expert advice on pet care</li>
            <li>Professional grooming services</li>
        </ul>

        <div class="login-options">
            <a href="${pageContext.request.contextPath}/shopping" class="login-btn" id="customer-btn">Enter as Customer</a>
            <a href="${pageContext.request.contextPath}/login" class="login-btn" id="manager-btn">Manager Login</a>
        </div>
    </div>

    <footer>
        <p>Contact Us:</p>
        <p>Phone: (123) 456-7890 | Fax: (123) 456-7891 | Email: info@monito.com</p>
        <p>Facebook: @MonitoPetShop | Instagram: @MonitoPetShop | Twitter: @MonitoPetShop</p>
    </footer>

    <script src="${pageContext.request.contextPath}template/web/assets/js/script.js"></script>
</body>
</html>