<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem;
            background: #4CAF50;
            color: white;
        }
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        .pet-section {
            background-color: white;
            padding: 1rem;
            margin-bottom: 2rem;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .pet-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            padding: 20px;
        }
        .pet-card {
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 8px;
            background: white;
            text-align: center;
        }
        .pet-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 4px;
            margin-bottom: 10px;
        }
        .cart-icon {
            position: relative;
            cursor: pointer;
            font-size: 24px;
        }
        .cart-count {
            position: absolute;
            top: -8px;
            right: -8px;
            background: red;
            color: white;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 12px;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
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
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
        }
        .modal-content {
            background: white;
            margin: 15% auto;
            padding: 20px;
            width: 70%;
            max-width: 500px;
            border-radius: 8px;
        }
        .close {
            float: right;
            cursor: pointer;
            font-size: 24px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Monito Pet Shop - Customer</h1>
    <div class="user-info">
        <div class="cart-icon" onclick="showCart()">
            🛒 <span class="cart-count" id="cartCount">0</span>
        </div>

        <c:choose>
            <c:when test="${not empty sessionScope.username}">
                <span>Welcome, ${sessionScope.username}!</span>
                <a href="${pageContext.request.contextPath}/logout" class="btn">Logout</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login" class="btn">Login</a>
            </c:otherwise>
        </c:choose>
        </div>
    </div>

    <div class="container">
        <!-- Pet sections will be dynamically loaded -->
        <div class="pet-section">
            <h2>Available Pets</h2>
            <div class="pet-grid" id="pets-grid">
                <!-- Pet cards will be populated here -->
                 <c:if test="${empty petList}">
                            <p>No petList found in request scope.</p>
                        </c:if>
                        <c:if test="${not empty petList and empty petList.listResult}">
                            <p>petList is present, but no pets found.</p>
                </c:if>        
                <c:forEach var="pet" items="${petList.listResult}">
                    <div class="pet-card">                
                        <c:if test="${not empty pet.image}">
                            <img src="data:image/jpeg;base64,${pet.base64Image}" 
                                 alt="${pet.name}" class="pet-image">
                        </c:if>
                        <h3>${pet.name}</h3>
                        <p>Type: ${pet.type}</p>
                        <p>Breed: ${pet.breed}</p>
                        <p>Age: ${pet.age} months</p>
                        <p>Gender: ${pet.gender}</p>
                        <p>Price: $<fmt:formatNumber value="${pet.price}" pattern="#,##0.00"/></p>                       
                        <button class="btn" onclick="addToCart('${pet.petId}', '${pet.name}', '${pet.price}')">
                            Add to Cart
                        </button>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <!-- Cart Modal -->
    <div id="cartModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeCart()">&times;</span>
            <h2>Shopping Cart</h2>
            <div id="cartItems"></div>
            <div id="cartTotal"></div>
            <button class="btn" onclick="checkout()">Checkout</button>
        </div>
    </div>

    <form id="checkoutForm" action="${pageContext.request.contextPath}/checkout" method="post" style="display:none;">
        <!-- No hidden cartData input needed, cart is managed server-side -->
    </form>

    <script>
        // Cart management using server session via AJAX
        let cart = [];

        // Fetch cart from server on page load
        function fetchCart() {
            fetch('${pageContext.request.contextPath}/cart?action=get')
                .then(response => response.json())
                .then(data => {
                    cart = data || [];
                    updateCartDisplay();
                });
        }

        function updateCartDisplay() {
            document.getElementById('cartCount').textContent = cart.length;
        }

        function addToCart(id, name, price) {
            id = Number(id);
            price = parseFloat(price);
            fetch('${pageContext.request.contextPath}/cart', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ action: 'add', id, name, price })
            })
            .then(response => response.json())
            .then(data => {
                cart = data;
                updateCartDisplay();
                alert(name + ' added to cart!');
            });
        }

        function showCart() {
            const modal = document.getElementById('cartModal');
            const items = document.getElementById('cartItems');
            const total = document.getElementById('cartTotal');

            // Use template literal for table rendering
            items.innerHTML = `
                <table style="width:100%; border-collapse:collapse;">
                    <thead>
                        <tr>
                            <th style="text-align:left;">Pet Name</th>
                            <th style="text-align:right;">Price</th>
                            <th style="text-align:right;">Quantity</th>
                            <th style="text-align:right;">Subtotal</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${cart.map((item, idx) => {
                            const itemTotal = (item.price * item.quantity).toFixed(2);
                            return `
                                <tr>
                                    <td>${item.name}</td>
                                    <td style="text-align:right;">$${item.price.toFixed(2)}</td>
                                    <td style="text-align:right;">${item.quantity}</td>
                                    <td style="text-align:right;">$${itemTotal}</td>
                                    <td><button onclick="removeFromCart(${idx})" class="btn" style="padding:2px 8px;">Remove</button></td>
                                </tr>
                            `;
                        }).join('')}
                    </tbody>
                </table>
            `;

            const totalAmount = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
            total.textContent = `Total: $${totalAmount.toFixed(2)}`;
            modal.style.display = 'block';
        }

        function closeCart() {
            document.getElementById('cartModal').style.display = 'none';
        }

        function removeFromCart(index) {
            fetch('${pageContext.request.contextPath}/cart', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ action: 'remove', index })
            })
            .then(response => response.json())
            .then(data => {
                cart = data;
                updateCartDisplay();
                showCart();
            });
        }

        function checkout() {
            if (cart.length === 0) {
                alert('Your cart is empty!');
                return;
            }
            // Go to checkout page (server will use session cart)
            window.location.href = '${pageContext.request.contextPath}/checkout';
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            if (event.target == document.getElementById('cartModal')) {
                closeCart();
            }
        }

        fetchCart();
    </script>
</body>
</html>
