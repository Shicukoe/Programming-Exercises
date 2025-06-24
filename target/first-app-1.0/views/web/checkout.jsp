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
        .form-group input {
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
        
        <form action="${pageContext.request.contextPath}/checkout" method="post">
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
            
            <div class="form-group">
                <label for="birthday">Birthday *</label>
                <input type="date" id="birthday" name="birthday" required>
            </div>
            
            <div class="order-summary">
                <h3>Order Summary</h3>
                <div id="orderItems"></div>
                <div id="orderTotal" style="font-weight: bold; text-align: right; margin-top: 10px;"></div>
            </div>
            
            <button type="submit" class="btn">Place Order</button>
        </form>
    </div>
    
    <script>
        // Display cart items from sessionStorage
        const cart = JSON.parse(sessionStorage.getItem('cart') || '[]').map(item => ({
            ...item,
            price: Number(item.price),
            quantity: Number(item.quantity)
        }));
        const orderItems = document.getElementById('orderItems');
        const orderTotal = document.getElementById('orderTotal');
        
        let total = 0;
        orderItems.innerHTML = cart.map(item => {
            const itemTotal = item.price * item.quantity;
            total += itemTotal;
            return `<div class="order-item">
                <span>${item.name} x ${item.quantity}</span>
                <span>$${itemTotal.toFixed(2)}</span>
            </div>`;
        }).join('');
        
        orderTotal.textContent = `Total: $${total.toFixed(2)}`;
        
        // Redirect if cart is empty
        if (cart.length === 0) {
            alert('Your cart is empty!');
            window.location.href = '${pageContext.request.contextPath}/shopping';
        }
        
        // Show success notification after placing order
        document.querySelector('form').addEventListener('submit', function(e) {
            e.preventDefault();
            // Simulate order placement (in real app, let server handle and redirect)
            sessionStorage.removeItem('cart');
            const modal = document.createElement('div');
            modal.style.position = 'fixed';
            modal.style.top = 0;
            modal.style.left = 0;
            modal.style.width = '100vw';
            modal.style.height = '100vh';
            modal.style.background = 'rgba(0,0,0,0.5)';
            modal.style.display = 'flex';
            modal.style.alignItems = 'center';
            modal.style.justifyContent = 'center';
            modal.innerHTML = `
                <div style="background: white; padding: 2rem 3rem; border-radius: 8px; text-align: center;">
                    <h2>Order placed successfully!</h2>
                    <button id="okBtn" style="margin-top: 1rem; padding: 0.5rem 2rem; background: #4CAF50; color: white; border: none; border-radius: 4px; font-size: 1rem; cursor: pointer;">OK</button>
                </div>
            `;
            document.body.appendChild(modal);
            document.getElementById('okBtn').onclick = function() {
                window.location.href = '${pageContext.request.contextPath}/shopping';
            };
        });
    </script>
</body>
</html>
