<%@ page import="java.util.List,com.laptrinhjavaweb.model.CartItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shopping Cart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 800px;
            margin: 2rem auto;
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h2 {
            margin-bottom: 1.5rem;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 1rem;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background: #4CAF50;
            color: white;
        }
        .btn {
            background: #4CAF50;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn:hover {
            background: #45a049;
        }
        .empty {
            text-align: center;
            color: #888;
            padding: 2rem 0;
        }
        .flex-container {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 1.5rem;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Shopping Cart</h2>
    <% 
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        double total = 0;
    %>
    <% if (cart == null || cart.isEmpty()) { %>
        <div class="empty">Your cart is empty.</div>
    <% } else { %>
        <table>
            <tr>
                <th>Name</th>
                <th>Quantity</th>
                <th>Unit Price</th>
                <th>Total Price</th>
                <th>Action</th>
            </tr>
            <% for (CartItem item : cart) {
                double itemTotal = item.getPrice() * item.getQuantity();
                total += itemTotal;
            %>
            <tr>
                <td><%= item.getName() %></td>
                <td>
                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="<%= item.getId() %>" />
                        <input type="hidden" name="action" value="decrease" />
                        <button class="btn" type="submit" style="padding:2px 8px;">-</button>
                    </form>
                    <span style="margin:0 8px; font-weight:bold;"> <%= item.getQuantity() %> </span>
                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="<%= item.getId() %>" />
                        <input type="hidden" name="action" value="increase" />
                        <button class="btn" type="submit" style="padding:2px 8px;">+</button>
                    </form>
                </td>
                <td>$<%= String.format("%.2f", item.getPrice()) %></td>
                <td>$<%= String.format("%.2f", itemTotal) %></td>
                <td>
                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="<%= item.getId() %>" />
                        <input type="hidden" name="action" value="delete" />
                        <button class="btn" type="submit" style="background:#e53935;">Delete</button>
                    </form>
                </td>
            </tr>
            <% } %>
            <tr>
                <td colspan="4" align="right"><strong>Total:</strong></td>
                <td><strong>$<%= String.format("%.2f", total) %></strong></td>
            </tr>
        </table>
        <div style="display:flex; justify-content:flex-end; gap:10px; margin-top:1.5rem;">
            <a href="${pageContext.request.contextPath}/shopping" class="btn" style="background:#4CAF50; color:#000; font-size:1rem; padding:8px 20px; border-radius:4px; font-weight:bold; letter-spacing:0.5px; box-shadow:0 2px 8px rgba(0,0,0,0.08);">Continue Shopping</a>
            <form action="${pageContext.request.contextPath}/checkout" method="post" style="display:inline;">
                <button class="btn" type="submit" style="background:#ffc107; color:#000; font-size:1rem; padding:8px 20px; border-radius:4px; font-weight:bold; letter-spacing:0.5px; box-shadow:0 2px 8px rgba(0,0,0,0.08);">Proceed to Checkout</button>
            </form>
        </div>
    <% } %>
</div>
</body>
</html>
