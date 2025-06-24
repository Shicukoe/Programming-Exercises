document.addEventListener('DOMContentLoaded', function() {
    // Get cart from localStorage
    const cart = JSON.parse(localStorage.getItem('monitoCart')) || [];
    const cartSummary = document.getElementById('cart-summary');
    const totalAmount = document.getElementById('total-amount');
    const customerForm = document.getElementById('customer-form');
    const submitOrder = document.getElementById('submit-order');
    const thankYou = document.getElementById('thank-you');
    const continueBtn = document.getElementById('continue-btn');

    // Display cart items
    if (cart.length === 0) {
        cartSummary.innerHTML = '<p>Your cart is empty</p>';
        submitOrder.disabled = true;
    } else {
        let total = 0;
        cart.forEach(item => {
            const itemTotal = item.price * item.quantity;
            total += itemTotal;
            
            const itemDiv = document.createElement('div');
            itemDiv.className = 'cart-item';
            itemDiv.innerHTML = `
                <span>${item.name} x ${item.quantity}</span>
                <span>$${itemTotal.toFixed(2)}</span>
            `;
            cartSummary.appendChild(itemDiv);
        });

        // Add delivery cost if home delivery is selected
        const deliveryRadios = document.getElementsByName('delivery');
        deliveryRadios.forEach(radio => {
            radio.addEventListener('change', function() {
                updateTotal(total);
            });
        });

        updateTotal(total);
    }

    function updateTotal(subtotal) {
        let total = subtotal;
        const delivery = document.querySelector('input[name="delivery"]:checked').value;
        
        if (delivery === 'home') {
            total += 10;
        }

        totalAmount.textContent = total.toFixed(2);
    }

    // Form submission
    submitOrder.addEventListener('click', function(e) {
        e.preventDefault();
        
        // Validate form
        const name = document.getElementById('name').value;
        const birthday = document.getElementById('birthday').value;
        const address = document.getElementById('address').value;
        const email = document.getElementById('email').value;
        const phone = document.getElementById('phone').value;
        const agreeTerms = document.getElementById('agree-terms').checked;

        if (!name || !birthday || !address || !email || !phone || !agreeTerms) {
            alert('Please fill in all required fields and agree to the terms.');
            return;
        }

        // In a real app, you would process payment here
        // For this demo, we'll just show the thank you message
        
        // Hide form and show thank you message
        document.querySelectorAll('.form-section').forEach(section => {
            section.style.display = 'none';
        });
        thankYou.style.display = 'block';

        // Clear cart
        localStorage.removeItem('monitoCart');
    });

    // Continue shopping button
    continueBtn.addEventListener('click', function() {
        window.location.href = 'customer.html';
    });

    // Show/hide credit card fields based on payment method
    const paymentRadios = document.getElementsByName('payment');
    const creditCardFields = document.getElementById('credit-card-fields');

    paymentRadios.forEach(radio => {
        radio.addEventListener('change', function() {
            if (this.value === 'credit') {
                creditCardFields.style.display = 'block';
            } else {
                creditCardFields.style.display = 'none';
            }
        });
    });
});