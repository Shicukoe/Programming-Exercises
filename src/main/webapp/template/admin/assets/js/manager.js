document.addEventListener('DOMContentLoaded', function() {
    // Sample inventory data
    let inventory = [
        { id: 1, name: "Buddy", type: "dog", breed: "Labrador", age: 12, price: 800, status: "available", description: "Friendly and playful Labrador puppy", image: "https://images.unsplash.com/photo-1586671267731-da2cf3ceeb80?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80" },
        { id: 2, name: "Max", type: "dog", breed: "Poodle", age: 24, price: 1200, status: "available", description: "Smart and elegant standard poodle", image: "https://images.unsplash.com/photo-1594149929911-78975a43d4f5?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80" },
        { id: 3, name: "Charlie", type: "dog", breed: "Beagle", age: 18, price: 600, status: "sold", description: "Curious and friendly beagle", image: "https://images.unsplash.com/photo-1505628346881-b72b27e84530?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80" },
        { id: 4, name: "Luna", type: "cat", breed: "Siamese", age: 8, price: 400, status: "available", description: "Beautiful blue-eyed Siamese", image: "https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80" },
        { id: 5, name: "Oliver", type: "cat", breed: "Persian", age: 36, price: 700, status: "available", description: "Fluffy and regal Persian cat", image: "https://images.unsplash.com/photo-1533738363-b7f9aef128ce?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80" },
        { id: 6, name: "Leo", type: "cat", breed: "Bengal", age: 12, price: 900, status: "sold", description: "Energetic and spotted Bengal", image: "https://images.unsplash.com/photo-1592194996308-7b43878e84b6?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80" },
        { id: 7, name: "Coco", type: "bunny", breed: "Dutch", age: 4, price: 80, status: "available", description: "Adorable Dutch bunny with perfect markings", image: "https://images.unsplash.com/photo-1556838803-cc94986cb631?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80" },
        { id: 8, name: "Snowball", type: "bunny", breed: "Lionhead", age: 8, price: 120, status: "available", description: "Fluffy Lionhead bunny with a mane", image: "https://images.unsplash.com/photo-1469532773895-0d5d14a49c06?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80" },
        { id: 9, name: "Thumper", type: "bunny", breed: "Flemish Giant", age: 6, price: 150, status: "sold", description: "Large and gentle Flemish Giant", image: "https://images.unsplash.com/photo-1585969646097-a1b0038c37a1?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80" },
        { id: 10, name: "Royal Canin Dog Food", type: "food", breed: "", age: 0, price: 45, status: "available", description: "Premium dog food for all breeds", image: "https://images.unsplash.com/photo-1589927986089-35812388d1f4?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80", brand: "Royal Canin", size: "5kg" },
        { id: 11, name: "Purina Cat Chow", type: "food", breed: "", age: 0, price: 25, status: "available", description: "Complete nutrition for adult cats", image: "https://images.unsplash.com/photo-1628840042765-356cda07504e?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80", brand: "Purina", size: "3kg" },
        { id: 12, name: "Hills Science Diet Bunny Food", type: "food", breed: "", age: 0, price: 18, status: "available", description: "Specially formulated for rabbits", image: "https://m.media-amazon.com/images/I/81hCyBvQD5L._AC_UF1000,1000_QL80_.jpg", brand: "Hills Science Diet", size: "2kg" }
    ];

    // Sample orders data
    let orders = JSON.parse(localStorage.getItem('monitoOrders')) || [
    // You can keep your sample data here as fallback
    { id: 1001, customer: "John Doe", date: "2023-05-15", items: ["Charlie (Beagle)", "Leo (Bengal)"], total: 1500, status: "completed" },
    { id: 1002, customer: "Jane Smith", date: "2023-05-18", items: ["Thumper (Flemish Giant)"], total: 150, status: "completed" },
    { id: 1003, customer: "Bob Johnson", date: "2023-05-20", items: ["Royal Canin Dog Food", "Purina Cat Chow"], total: 70, status: "pending" },
    { id: 1004, customer: "Alice Brown", date: "2023-05-01", items: ["Max (Poodle)"], total: 1200, status: "refunded" }
];
    // Add this function to refresh orders from localStorage
    function refreshOrders() {
        const storedOrders = JSON.parse(localStorage.getItem('monitoOrders'));
        if (storedOrders) {
            orders = storedOrders;
        }
        displayOrders(orders);
    }
    // Display inventory
    displayInventory(inventory);
    displayOrders(orders);

    // Set up filters
    document.getElementById('inventory-filter').addEventListener('change', function() {
        filterInventory();
    });
    document.getElementById('inventory-status').addEventListener('change', function() {
        filterInventory();
    });

    document.getElementById('order-filter').addEventListener('change', function() {
        filterOrders();
    });
    document.getElementById('order-date-filter').addEventListener('change', function() {
        filterOrders();
    });

    // Add item form
    const itemType = document.getElementById('item-type');
    itemType.addEventListener('change', function() {
        if (this.value === 'food') {
            document.getElementById('breed-group').style.display = 'none';
            document.getElementById('age-group').style.display = 'none';
            document.getElementById('food-brand-group').style.display = 'block';
            document.getElementById('food-size-group').style.display = 'block';
        } else {
            document.getElementById('breed-group').style.display = 'block';
            document.getElementById('age-group').style.display = 'block';
            document.getElementById('food-brand-group').style.display = 'none';
            document.getElementById('food-size-group').style.display = 'none';
        }
    });

    document.getElementById('add-item-form').addEventListener('submit', function(e) {
        e.preventDefault();
        
        const type = document.getElementById('item-type').value;
        const name = document.getElementById('item-name').value;
        const breed = document.getElementById('item-breed').value;
        const age = document.getElementById('item-age').value;
        const price = document.getElementById('item-price').value;
        const description = document.getElementById('item-description').value;
        const image = document.getElementById('item-image').value;
        const brand = document.getElementById('food-brand').value;
        const size = document.getElementById('food-size').value;

        const newItem = {
            id: inventory.length > 0 ? Math.max(...inventory.map(item => item.id)) + 1 : 1,
            name,
            type,
            breed: type === 'food' ? '' : breed,
            age: type === 'food' ? 0 : parseInt(age),
            price: parseFloat(price),
            status: "available",
            description,
            image
        };

        if (type === 'food') {
            newItem.brand = brand;
            newItem.size = size;
        }

        inventory.push(newItem);
        displayInventory(inventory);
        this.reset();
        alert('Item added successfully!');
    });

    // Reports
    document.getElementById('report-period').addEventListener('change', function() {
        if (this.value === 'custom') {
            document.getElementById('custom-range').style.display = 'block';
        } else {
            document.getElementById('custom-range').style.display = 'none';
        }
    });

    document.getElementById('generate-report').addEventListener('click', function() {
        const period = document.getElementById('report-period').value;
        let startDate, endDate;
        
        const today = new Date();
        
        if (period === 'day') {
            startDate = new Date(today);
            endDate = new Date(today);
        } else if (period === 'week') {
            startDate = new Date(today);
            startDate.setDate(today.getDate() - today.getDay());
            endDate = new Date(today);
            endDate.setDate(today.getDate() + (6 - today.getDay()));
        } else if (period === 'month') {
            startDate = new Date(today.getFullYear(), today.getMonth(), 1);
            endDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);
        } else if (period === 'year') {
            startDate = new Date(today.getFullYear(), 0, 1);
            endDate = new Date(today.getFullYear(), 11, 31);
        } else if (period === 'custom') {
            startDate = new Date(document.getElementById('start-date').value);
            endDate = new Date(document.getElementById('end-date').value);
            
            if (isNaN(startDate.getTime()) || isNaN(endDate.getTime())) {
                alert('Please select valid dates');
                return;
            }
        }
        
        // Filter orders by date
        const filteredOrders = orders.filter(order => {
            const orderDate = new Date(order.date);
            return orderDate >= startDate && orderDate <= endDate;
        });
        
        // Calculate totals
        const completedOrders = filteredOrders.filter(order => order.status === 'completed');
        const totalSales = completedOrders.reduce((sum, order) => sum + order.total, 0);
        const totalOrders = filteredOrders.length;
        const completedCount = completedOrders.length;
        const refundedCount = filteredOrders.filter(order => order.status === 'refunded').length;
        
        // Display report
        const reportResults = document.getElementById('report-results');
        reportResults.innerHTML = `
            <h3>Sales Report (${startDate.toDateString()} to ${endDate.toDateString()})</h3>
            <p>Total Orders: ${totalOrders}</p>
            <p>Completed Orders: ${completedCount}</p>
            <p>Refunded Orders: ${refundedCount}</p>
            <p>Total Sales: $${totalSales.toFixed(2)}</p>
            
            <h4>Order Details</h4>
            <ul>
                ${filteredOrders.map(order => `
                    <li>
                        Order #${order.id} - ${order.customer} - $${order.total} - ${order.status}
                    </li>
                `).join('')}
            </ul>
        `;
    });

    function displayInventory(items) {
        const tbody = document.querySelector('#inventory-table tbody');
        tbody.innerHTML = '';
        
        items.forEach(item => {
            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td>${item.id}</td>
                <td>${item.name}</td>
                <td>${item.type}</td>
                <td>${item.breed || '-'}</td>
                <td>${item.type === 'food' ? '-' : item.age}</td>
                <td>$${item.price}</td>
                <td>${item.status}</td>
                <td>
                    <button class="edit-item" data-id="${item.id}">Edit</button>
                    <button class="delete-item" data-id="${item.id}">Delete</button>
                </td>
            `;
            tbody.appendChild(tr);
        });
        
        // Add event listeners to edit and delete buttons
        document.querySelectorAll('.edit-item').forEach(button => {
            button.addEventListener('click', function() {
                const id = parseInt(this.getAttribute('data-id'));
                editItem(id);
            });
        });
        
        document.querySelectorAll('.delete-item').forEach(button => {
            button.addEventListener('click', function() {
                const id = parseInt(this.getAttribute('data-id'));
                deleteItem(id);
            });
        });
    }

    function displayOrders(orderList) {
        const tbody = document.querySelector('#orders-table tbody');
        tbody.innerHTML = '';
        
        orderList.forEach(order => {
            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td>${order.id}</td>
                <td>${order.customer}</td>
                <td>${order.date}</td>
                <td>${order.items.join(', ')}</td>
                <td>$${order.total}</td>
                <td>${order.status}</td>
                <td>
                    <select class="order-status" data-id="${order.id}">
                        <option value="pending" ${order.status === 'pending' ? 'selected' : ''}>Pending</option>
                        <option value="completed" ${order.status === 'completed' ? 'selected' : ''}>Completed</option>
                        <option value="refunded" ${order.status === 'refunded' ? 'selected' : ''}>Refunded</option>
                    </select>
                </td>
            `;
            tbody.appendChild(tr);
        });
        
        // Add event listeners to status dropdowns
        document.querySelectorAll('.order-status').forEach(select => {
            select.addEventListener('change', function() {
                const id = parseInt(this.getAttribute('data-id'));
                const newStatus = this.value;
                updateOrderStatus(id, newStatus);
            });
        });
        // Call refreshOrders when the page loads and when the orders tab is clicked
        document.addEventListener('DOMContentLoaded', function() {
            refreshOrders();
        });
        // Add event listener to orders tab
        document.querySelector('.tab[data-tab="orders"]').addEventListener('click', refreshOrders);
    }
    
    function filterInventory() {
        const typeFilter = document.getElementById('inventory-filter').value;
        const statusFilter = document.getElementById('inventory-status').value;
        
        let filteredItems = [...inventory];
        
        if (typeFilter !== 'all') {
            if (typeFilter === 'pets') {
                filteredItems = filteredItems.filter(item => ['dog', 'cat', 'bunny'].includes(item.type));
            } else if (typeFilter === 'food') {
                filteredItems = filteredItems.filter(item => item.type === 'food');
            } else {
                filteredItems = filteredItems.filter(item => item.type === typeFilter);
            }
        }
        
        if (statusFilter !== 'all') {
            filteredItems = filteredItems.filter(item => item.status === statusFilter);
        }
        
        displayInventory(filteredItems);
    }

    function filterOrders() {
        const statusFilter = document.getElementById('order-filter').value;
        const dateFilter = document.getElementById('order-date-filter').value;
        
        let filteredOrders = [...orders];
        
        if (statusFilter !== 'all') {
            filteredOrders = filteredOrders.filter(order => order.status === statusFilter);
        }
        
        if (dateFilter) {
            filteredOrders = filteredOrders.filter(order => order.date === dateFilter);
        }
        
        displayOrders(filteredOrders);
    }

    function editItem(id) {
        const item = inventory.find(item => item.id === id);
        if (!item) return;
        
        // In a real app, you would show a modal or form to edit the item
        // For this demo, we'll just prompt for new price and status
        const newPrice = prompt('Enter new price', item.price);
        if (newPrice === null) return;
        
        const newStatus = prompt('Enter new status (available/sold)', item.status);
        if (newStatus === null) return;
        
        item.price = parseFloat(newPrice);
        item.status = newStatus.toLowerCase();
        
        displayInventory(inventory);
        alert('Item updated successfully!');
    }

    function deleteItem(id) {
        if (confirm('Are you sure you want to delete this item?')) {
            inventory = inventory.filter(item => item.id !== id);
            displayInventory(inventory);
            alert('Item deleted successfully!');
        }
    }

    function updateOrderStatus(id, newStatus) {
        const order = orders.find(order => order.id === id);
        if (order) {
            order.status = newStatus;
            alert(`Order #${id} status updated to ${newStatus}`);
        }
    }
});