<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>View Order - Admin Dashboard</title>
    <link href="${pageContext.request.contextPath}/template/admin/assets/css/styles.css" rel="stylesheet">
    <style>
        .order-details-container {
            max-width: 800px;
            margin: 2rem auto;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 2rem;
        }
        .order-summary-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }
        .order-summary-table th, .order-summary-table td {
            padding: 1rem;
            border-bottom: 1px solid #eee;
            text-align: left;
        }
        .order-summary-table th {
            background: #f8f9fa;
        }
        .order-status-select {
            padding: 0.5rem;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        .back-btn {
            margin-top: 2rem;
            background: #4CAF50;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="order-details-container">
        <h2>Order Details</h2>
        <div>
            <strong>Order ID:</strong> ${order.orderId}<br>
            <strong>Customer:</strong> ${order.customerName}<br>
            <strong>Date:</strong> <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm:ss"/><br>
            <strong>Status:</strong>
            <form action="${pageContext.request.contextPath}/admin-update-order" method="post" style="display:inline;">
                <input type="hidden" name="orderId" value="${order.orderId}" />
                <select name="status" class="order-status-select" onchange="this.form.submit()">
                    <option value="pending" ${order.status == 'pending' ? 'selected' : ''}>Pending</option>
                    <option value="processing" ${order.status == 'processing' ? 'selected' : ''}>Processing</option>
                    <option value="completed" ${order.status == 'completed' ? 'selected' : ''}>Completed</option>
                    <option value="cancelled" ${order.status == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                </select>
            </form>
            <br>
            <strong>Shipping Address:</strong> ${order.shippingAddress}<br>
            <strong>Phone:</strong> ${order.phone}<br>
            <strong>Email:</strong> ${order.email}<br>
        </div>
        <h3 style="margin-top:2rem;">Order Items</h3>
        <table class="order-summary-table">
            <thead>
                <tr>
                    <th>Pet Name</th>
                    <th>Type</th>
                    <th>Breed</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${orderItems}">
                    <tr>
                        <td>${item.petName}</td>
                        <td>${item.petType}</td>
                        <td>${item.petBreed}</td>
                        <td><fmt:formatNumber value="${item.priceAtTime}" type="currency"/></td>
                        <td>${item.quantity}</td>
                        <td><fmt:formatNumber value="${item.priceAtTime * item.quantity}" type="currency"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div style="text-align:right; font-weight:bold; margin-top:1rem;">
            Total: <fmt:formatNumber value="${order.totalAmount}" type="currency"/>
        </div>
        <a href="${pageContext.request.contextPath}/admin-home" class="back-btn">Back to Orders</a>
    </div>
</body>
</html>
