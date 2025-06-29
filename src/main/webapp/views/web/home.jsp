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
        .left-banner {
            border-right: 2px solid #388E3C;
            padding: 2rem 1rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-width: 180px;
            box-shadow: 2px 0 8px rgba(56,142,60,0.08);
        }
        .right-banner {
            border-left: 2px solid #388E3C;
            padding: 2rem 1rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-width: 180px;
            box-shadow: -2px 0 8px rgba(56,142,60,0.08);
        }
        .banner-img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 50%;
            margin-bottom: 1rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.10);
        }
        .banner-title {
            font-size: 1.3rem;
            font-weight: bold;
            color: #388E3C;
            margin-bottom: 0.5rem;
        }
        .banner-desc {
            color: #388E3C;
            font-size: 1rem;
            text-align: center;
        }
        .main-banner-row {
            display: flex;
            justify-content: space-between;
            align-items: stretch;
            margin-bottom: 2rem;
        }
    </style>
</head>
<body>
    <header class="header-banner">
        <img src="${pageContext.request.contextPath}/template/web/assets/images/logo.png" style="width: 100px;height: 100px;float: left;" alt="Monito Logo" class="logo">
        <h1>Welcome to Monito Pet Shop</h1>
        <p>Your one-stop shop for all pet needs</p>
    </header>

    <div class="main-banner-row" style="display: flex; align-items: stretch; justify-content: space-between; margin-bottom: 2rem; min-height: 70vh;">
        <div class="left-banner" style="display:flex; align-items:center; justify-content:center; height:100%; min-width:340px; max-width:480px; padding:0; border-right: none;">
            <img src="https://images.pexels.com/photos/1805164/pexels-photo-1805164.jpeg?auto=compress&w=400&h=800&fit=crop" class="banner-img" alt="Happy Dog" style="height:100vh; max-height:calc(100vh - 60px); width:340px; min-width:340px; object-fit:cover; object-position: right center; border-radius:0; box-shadow:none; border:none; background:none; margin:0; -webkit-box-reflect: below 0 linear-gradient(transparent, rgba(0,0,0,0.10));" />
        </div>
        <div style="flex: 1; padding: 1rem 1.5rem 0 1.5rem; text-align: center; background: linear-gradient(120deg, #f8fffc 60%, #e3f0ff 100%); border-radius: 0 0 2rem 2rem; box-shadow: 0 2px 12px rgba(56,142,60,0.07); display: flex; flex-direction: column; align-items: center; justify-content: flex-start; min-height:unset;">
            <c:if test="${not empty errorMessage}">
                <div style="color: red; text-align: center; margin-bottom: 1rem; font-weight: bold;">
                    ${errorMessage}
                </div>
            </c:if>
            <h2 style="color:#388E3C; font-size:2.2rem; margin-bottom:0.5rem; letter-spacing:1px; text-align:center;">About Us</h2>
            <p style="font-size:1.15rem; color:#333; margin-bottom:1.5rem; text-align:center;">Monito Pet Shop is a grand new website for providing healthy pets and quality pet supplies at affordable prices. Our mission is to match loving families with their perfect pets.</p>
            <h2 style="color:#388E3C; font-size:1.7rem; margin-bottom:0.5rem; text-align:center;">Our Services</h2>
            <ul style="list-style: disc inside; max-width: 500px; margin: 0 0 1.5rem 0; font-size:1.08rem; color:#444; text-align:left; display:inline-block;">
                <li>Wide variety of pets including dogs, cats, bunnies, and more</li>
                <li>Expert advice on pet care</li>
                <li>Professional grooming services</li>
            </ul>
            <div class="login-options" style="margin-top:1rem; justify-content: center; width:100%;">
                <a href="${pageContext.request.contextPath}/shopping" class="login-btn" id="customer-btn" style="background: linear-gradient(90deg, #43e97b 0%, #38f9d7 100%); color:#222; font-weight:bold; box-shadow:0 2px 8px rgba(56,142,60,0.10);">Enter as Customer</a>
                <a href="${pageContext.request.contextPath}/login" class="login-btn" id="manager-btn" style="background: linear-gradient(90deg, #43e97b 0%, #38f9d7 100%); color:#222; font-weight:bold; box-shadow:0 2px 8px rgba(56,142,60,0.10);">Manager Login</a>
            </div>
        </div>
        <div class="right-banner" style="display:flex; align-items:center; justify-content:center; height:100%; min-width:340px; max-width:480px; padding:0; border-left: none;">
            <img src="https://images.pexels.com/photos/1170986/pexels-photo-1170986.jpeg?auto=compress&w=400&h=800&fit=crop" class="banner-img" alt="Cute Cat" style="height:100vh; max-height:calc(100vh - 60px); width:340px; min-width:340px; object-fit:cover; border-radius:0; box-shadow:none; border:none; background:none; margin:0;" />
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