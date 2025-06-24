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
        <input type="hidden" name="cartData" id="cartDataInput">
    </form>

    <script>
        // Cart management using sessionStorage
        let cart = JSON.parse(sessionStorage.getItem('cart') || '[]').map(item => ({
            ...item,
            price: Number(item.price),
            quantity: Number(item.quantity)
        }));
        
        function updateCartDisplay() {
            document.getElementById('cartCount').textContent = cart.length;
        }
        
        function addToCart(id, name, price) {
            id = Number(id); // Ensure id is a number
            price = parseFloat(price); // Ensure price is a number
            // Check if item already exists in cart
            const existingItem = cart.find(item => Number(item.id) === id);
            if (existingItem) {
                existingItem.quantity++;
            } else {
                cart.push({id, name, price, quantity: 1});
            }
            sessionStorage.setItem('cart', JSON.stringify(cart));
            updateCartDisplay();
            alert(name + ' added to cart!');
        }
        
        function showCart() {
            const modal = document.getElementById('cartModal');
            const items = document.getElementById('cartItems');
            const total = document.getElementById('cartTotal');
            
            items.innerHTML = cart.map(item => {
                const itemTotal = (item.price * item.quantity).toFixed(2);
                return `
                    <div class="cart-item" style="display: flex; justify-content: space-between; margin: 10px 0; padding: 10px; border-bottom: 1px solid #ddd;">
                        <span>${item.name}</span>
                        <span>Quantity: ${item.quantity}</span>
                        <span>$${itemTotal}</span>
                        <button onclick="removeFromCart(${cart.indexOf(item)})" class="btn" style="padding: 2px 8px;">Remove</button>
                    </div>
                `;
            }).join('');
            
            const totalAmount = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
            total.textContent = `Total: $${totalAmount.toFixed(2)}`;
            modal.style.display = 'block';
        }
        
        function closeCart() {
            document.getElementById('cartModal').style.display = 'none';
        }
        
        function removeFromCart(index) {
            cart.splice(index, 1);
            sessionStorage.setItem('cart', JSON.stringify(cart));
            updateCartDisplay();
            showCart(); // Refresh cart display
        }
        
        function checkout() {
            if (cart.length === 0) {
                alert('Your cart is empty!');
                return;
            }
            // Save cart to sessionStorage (for persistence)
            sessionStorage.setItem('cart', JSON.stringify(cart));
            // Set cart JSON in hidden form and submit
            document.getElementById('cartDataInput').value = JSON.stringify(cart);
            document.getElementById('checkoutForm').submit();
        }
        
        // Close modal when clicking outside
        window.onclick = function(event) {
            if (event.target == document.getElementById('cartModal')) {
                closeCart();
            }
        }
        
        updateCartDisplay();
    </script>
</body>
</html>
