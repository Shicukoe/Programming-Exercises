<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout - Pet Shop</title>
    <style>
        .checkout-form {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .error {
            color: red;
            margin-bottom: 10px;
        }
        .btn {
            background: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        .btn:hover {
            background: #45a049;
        }
        .order-summary {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }
        .order-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
    </style>
</head>
<body>
    <div class="checkout-form">
        <h2>Checkout</h2>
        <c:if test="${not empty errorMessage}">
            <div class="error">${errorMessage}</div>
        </c:if>
        <form id="checkoutForm" action="${pageContext.request.contextPath}/checkout" method="post">
            <div class="form-group">
                <label for="fullName">Full Name *</label>
                <input type="text" id="fullName" name="fullName" required>
            </div>
            <div class="form-group">
                <label for="email">Email *</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="phone">Phone *</label>
                <input type="tel" id="phone" name="phone" pattern="[0-9]{10}" required>
            </div>
            <div class="form-group">
                <label for="address">Shipping Address *</label>
                <input type="text" id="address" name="address" required>
            </div>
            <input type="hidden" name="cartData" id="cartDataInput">
            <div class="order-summary">
                <h3>Order Summary</h3>
                <table style="width:100%; border-collapse:collapse;">
                    <thead>
                        <tr>
                            <th style="text-align:left;">Pet Name</th>
                            <th style="text-align:right;">Price</th>
                            <th style="text-align:right;">Quantity</th>
                            <th style="text-align:right;">Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cart}">
                            <tr>
                                <td>${item.name}</td>
                                <td style="text-align:right;"><fmt:formatNumber value="${item.price}" type="currency"/></td>
                                <td style="text-align:right;">${item.quantity}</td>
                                <td style="text-align:right;"><fmt:formatNumber value="${item.price * item.quantity}" type="currency"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="3" style="text-align:right;"><b>Total:</b></td>
                            <td style="text-align:right;"><fmt:formatNumber value="${totalPrice}" type="currency"/></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
            <button type="submit" class="btn">Continue to Summary</button>
        </form>
    </div>
    <script>
        // On page load, set cartDataInput value from sessionStorage
        const cart = JSON.parse(sessionStorage.getItem('cart') || '[]');
        document.getElementById('cartDataInput').value = JSON.stringify(cart);
    </script>
</body>
</html>
