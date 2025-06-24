// Shared functions across all pages

// Home page functionality
document.addEventListener('DOMContentLoaded', function() {
    // Check if we're on the home page
    if (document.getElementById('customer-btn')) {
        const customerBtn = document.getElementById('customer-btn');
        const managerBtn = document.getElementById('manager-btn');
        const managerLogin = document.getElementById('manager-login');
        const managerForm = document.getElementById('manager-form');

        customerBtn.addEventListener('click', function() {
            window.location.href = 'customer.html';
        });

        managerBtn.addEventListener('click', function() {
            window.location.href = 'login.html';
        });

        managerForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;

            if (username === 'monito123' && password === '12345678') {
                window.location.href = 'manager.html';
            } else {
                alert('Invalid username or password');
            }
        });
    }

    // Check if we're on the manager page
    if (document.getElementById('logout-btn')) {
    const logoutBtn = document.getElementById('logout-btn');
    logoutBtn.addEventListener('click', function() {
        window.location.href = 'home.html';
    });
}

    // Tab functionality for manager page
    if (document.querySelector('.tabs')) {
        const tabs = document.querySelectorAll('.tab');
        tabs.forEach(tab => {
            tab.addEventListener('click', function() {
                // Remove active class from all tabs and contents
                document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
                document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
                
                // Add active class to clicked tab and corresponding content
                this.classList.add('active');
                const tabId = this.getAttribute('data-tab');
                document.getElementById(tabId).classList.add('active');
            });
        });
    }

    // Chat button functionality
    if (document.getElementById('chat-btn')) {
        const chatBtn = document.getElementById('chat-btn');
        chatBtn.addEventListener('click', function() {
            window.open('https://www.facebook.com/messages/t/MonitoPetShop', '_blank');
        });
    }

    if (document.getElementById('manager-chat-btn')) {
        const chatBtn = document.getElementById('manager-chat-btn');
        const chatBox = document.getElementById('chat-box');
        const closeChat = document.getElementById('close-chat');

        chatBtn.addEventListener('click', function() {
            chatBox.style.display = chatBox.style.display === 'block' ? 'none' : 'block';
        });

        closeChat.addEventListener('click', function() {
            chatBox.style.display = 'none';
        });

        // Simple chat functionality
        const chatInput = document.getElementById('chat-input');
        const sendMessage = document.getElementById('send-message');
        const chatMessages = document.getElementById('chat-messages');

        sendMessage.addEventListener('click', function() {
            if (chatInput.value.trim() !== '') {
                const messageDiv = document.createElement('div');
                messageDiv.textContent = 'You: ' + chatInput.value;
                chatMessages.appendChild(messageDiv);
                chatInput.value = '';
                chatMessages.scrollTop = chatMessages.scrollHeight;
            }
        });

        chatInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter' && chatInput.value.trim() !== '') {
                const messageDiv = document.createElement('div');
                messageDiv.textContent = 'You: ' + chatInput.value;
                chatMessages.appendChild(messageDiv);
                chatInput.value = '';
                chatMessages.scrollTop = chatMessages.scrollHeight;
            }
        });
    }
});