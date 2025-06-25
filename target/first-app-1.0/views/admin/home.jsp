<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Shop - Manager Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        header {
            background: #4CAF50;
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .container {
            max-width: 1500px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        .tabs {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }
        .tab {
            padding: 0.75rem 1.5rem;
            background: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .tab.active {
            background: #4CAF50;
            color: white;
        }
        .tab-content {
            display: none;
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            width:1350px;
            margin: 0 auto;
            align: center;
            /* Add min-width for orders tab */
        }
        #orders.tab-content {
            min-width: 900px;
        }
        .tab-content.active {
            display: block;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }
        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        th {
            background-color: #f8f9fa;
            font-weight: bold;
        }
        .form-group {
            margin-bottom: 1rem;
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }
        input, select, textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
            box-sizing: border-box;
        }
        .submit-btn {
            background: #4CAF50;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            text-decoration: none;
        }
        .submit-btn:hover {
            background: #45a049;
        }
        .actions {
            display: flex;
            flex-direction: row;
            gap: 0.25rem;
            align-items: center;
            justify-content: center;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            padding: 0.5rem 0;
        }
        .btn-edit, .btn-delete {
            display: inline-block;
            margin: 0;
            border: none;
            border-radius: 4px;
            font-size: 0.9rem;
            padding: 0.5rem 1rem;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.2s, color 0.2s;
        }
        .btn-edit {
            background: #ffc107;
            color: #000;
        }
        .btn-edit:hover {
            background: #e0a800;
            color: #222;
        }
        .btn-delete {
            background: #dc3545;
            color: white;
        }
        .btn-delete:hover {
            background: #b52a37;
        }
    </style>
</head>
<body>
    <header>
        <h1>Pet Shop Manager Dashboard</h1>
        <a href="${pageContext.request.contextPath}/logout" class="submit-btn">Logout</a>
    </header>

    <div class="container">
        <div class="tabs">
            <button type="button" class="tab active" data-tab="inventory">Pet Inventory</button>
            <button type="button" class="tab" data-tab="orders">Orders</button>
            <button type="button" class="tab" data-tab="add-pet">Add Pet</button>
        </div>

        <!-- Inventory Tab -->
        <div class="tab-content active" id="inventory">
            <h2>Pet Inventory</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Type</th>
                        <th>Breed</th>
                        <th>Age</th>
                        <th>Gender</th>
                        <th>Price</th>
                        <th>Added By</th>
                        <th>Added Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="pet" items="${pets}">
                        <tr>
                            <td>${pet.petId}</td>
                            <td>${pet.name}</td>
                            <td>${pet.type}</td>
                            <td>${pet.breed}</td>
                            <td>${pet.age} month${pet.age == 1 ? '' : 's'} old</td>
                            <td>${pet.gender}</td>
                            <td><fmt:formatNumber value="${pet.price}" type="currency"/></td>
                            <td>${pet.addedBy}</td>
                            <td><fmt:formatDate value="${pet.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin-editpage?id=${pet.petId}" 
                                   class="btn-edit">Edit</a>
                                <a href="${pageContext.request.contextPath}/admin-delete?id=${pet.petId}" 
                                   onclick="return confirm('Are you sure you want to delete this pet?')" 
                                   class="btn-delete">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Orders Tab -->
        <div class="tab-content" id="orders">
            <h2>Order Management</h2>
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Date</th>
                        <th>Total</th>
                        <th>Status</th>
                        <th>Address</th>
                        <th>Phone</th>
                        <th>Email</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>${order.orderId}</td>
                            <td>${order.customerName}</td>
                            <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td><fmt:formatNumber value="${order.totalAmount}" type="currency"/></td>
                            <td>
                                <select style="width:auto; min-width:80px; max-width:120px;" onchange="updateOrderStatus('${order.orderId}', this.value)">
                                    <option value="pending" ${order.status == 'pending' ? 'selected' : ''}>Pending</option>
                                    <option value="processing" ${order.status == 'processing' ? 'selected' : ''}>Processing</option>
                                    <option value="completed" ${order.status == 'completed' ? 'selected' : ''}>Completed</option>
                                    <option value="cancelled" ${order.status == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                                </select>
                            </td>
                            <td>${order.shippingAddress}</td>
                            <td>${order.phone}</td>
                            <td>${order.email}</td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin-view-order?id=${order.orderId}" class="btn-edit">View</a>
                                <a href="${pageContext.request.contextPath}/admin-delete-order?id=${order.orderId}" class="btn-delete" onclick="return confirm('Are you sure you want to delete this order?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Add Pet Tab -->
        <div class="tab-content" id="add-pet">
            <h2>Add New Pet</h2>
            <form action="${pageContext.request.contextPath}/admin-add-pet" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="name">Pet Name</label>
                    <input type="text" id="name" name="name" required>
                </div>
                
                <div class="form-group">
                    <label for="type">Type</label>
                    <select id="type" name="type" required>
                        <option value="">Select Type</option>
                        <option value="Dog">Dog</option>
                        <option value="Cat">Cat</option>
                        <option value="Bird">Bird</option>
                        <option value="Fish">Fish</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="breed">Breed</label>
                    <input type="text" id="breed" name="breed" required>
                </div>
                
                <div class="form-group">
                    <label for="age">Age (months)</label>
                    <input type="number" id="age" name="age" required min="0">
                </div>
                
                <div class="form-group">
                    <label for="gender">Gender</label>
                    <select id="gender" name="gender" required>
                        <option value="">Select Gender</option>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="price">Price</label>
                    <input type="number" step="0.01" id="price" name="price" required min="0">
                </div>
                
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" rows="4"></textarea>
                </div>
                
                <div class="form-group">
                    <label for="image">Pet Image</label>
                    <input type="file" id="image" name="image" accept="image/*">
                </div>

                <div class="form-group">
                    <label for="addedBy">Added By</label>
                    <input type="text" id="addedBy" name="addedBy" value="${sessionScope.loggedUser.username}" readonly style="background-color:#f4f4f4; color:#888; cursor:not-allowed;">
                </div>
                
                <button type="submit" class="submit-btn">Add Pet</button>
            </form>
        </div>
    </div>

    <!-- Messenger Chat Button with original style -->
    <a href="https://business.facebook.com/latest/inbox/messenger?asset_id=691110987420603" target="_blank" class="submit-btn" id="chat-toggle"
       style="position: fixed; bottom: 20px; right: 20px; border-radius: 50%; width: 60px; height: 60px; font-size: 24px; display: flex; align-items: center; justify-content: center; text-decoration: none; background: #4CAF50; color: white;">
        💬
    </a>
    
    <script>
        // Tab switching
        document.querySelectorAll('.tab').forEach(tab => {
            tab.addEventListener('click', () => {
                document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
                document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
                tab.classList.add('active');
                document.getElementById(tab.dataset.tab).classList.add('active');
            });
        });

        // Order status update
        function updateOrderStatus(orderId, status) {
            fetch('${pageContext.request.contextPath}/admin-update-order', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `orderId=${orderId}&status=${status}`
            })
            .then(response => response.text())
            .then(result => {
                if (result === 'success') {
                    alert('Order status updated successfully');
                } else {
                    alert('Error updating order status: ' + result);
                }
            })
            .catch(error => {
                alert('Error updating order status: ' + error);
            });
        }
    </script>
</body>
</html>