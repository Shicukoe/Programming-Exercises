<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation</title>
    <style>
        .confirmation {
            max-width: 600px;
            margin: 40px auto;
            padding: 30px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            text-align: center;
        }
        .confirmation h2 {
            color: #4CAF50;
        }
        .btn {
            background: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 20px;
        }
        .btn:hover {
            background: #45a049;
        }
        .order-summary {
            margin: 30px auto 0 auto;
            max-width: 500px;
            text-align: left;
        }
        .order-summary table {
            width: 100%;
            border-collapse: collapse;
        }
        .order-summary th, .order-summary td {
            padding: 8px;
            border-bottom: 1px solid #eee;
        }
        .order-summary th {
            background: #f8f9fa;
        }
    </style>
</head>
<body>
    <div class="confirmation">
        <h2>Thank you for your order!</h2>
        <p>Your order has been placed successfully.</p>
        <div class="order-summary">
            <h3>Order Details</h3>
            <p><b>Name:</b> ${order.fullName}</p>
            <p><b>Email:</b> ${order.email}</p>
            <p><b>Phone:</b> ${order.phone}</p>
            <p><b>Address:</b> ${order.shippingAddress}</p>
            <table>
                <thead>
                    <tr>
                        <th>Pet Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${cart}">
                        <tr>
                            <td>${item.name}</td>
                            <td><fmt:formatNumber value="${item.price}" type="currency"/></td>
                            <td>${item.quantity}</td>
                            <td><fmt:formatNumber value="${item.price * item.quantity}" type="currency"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="3" style="text-align:right;"><b>Total:</b></td>
                        <td><fmt:formatNumber value="${totalPrice}" type="currency"/></td>
                    </tr>
                </tfoot>
            </table>
        </div>
        <a href="${pageContext.request.contextPath}/shopping" class="btn">Continue Shopping</a>
    </div>
</body>
</html>
