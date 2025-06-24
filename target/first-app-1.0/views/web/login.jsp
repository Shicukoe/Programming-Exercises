<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Shop - Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }
        h1 {
            color: #4CAF50;
            text-align: center;
            margin-bottom: 1.5rem;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }
        input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
        }
        .submit-btn {
            width: 100%;
            padding: 0.75rem;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
        }
        .submit-btn:hover {
            background-color: #45a049;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 1rem;
            color: #666;
            text-decoration: none;
        }
        .back-link:hover {
            color: #333;
        }
        .error-message {
            color: #f44336;
            margin-top: 0.5rem;
            font-size: 0.9rem;
            display: none;
        }
        .error-message.show {
            display: block;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>Pet Shop Login</h1>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input style="width: 366px" type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input style="width: 366px" type="password" id="password" name="password" required>
            </div>
            <c:if test="${not empty errorMessage}">
                <div class="error-message show">${errorMessage}</div>
            </c:if>
            <button type="submit" class="submit-btn">Login</button>
        </form>
        <a href="${pageContext.request.contextPath}/homepage" class="back-link">Back to Home</a>
    </div>

    <script>
        // Client-side validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const usernameError = document.getElementById('username-error');
            const passwordError = document.getElementById('password-error');
            let hasError = false;

            usernameError.style.display = 'none';
            passwordError.style.display = 'none';

            if (!username) {
                usernameError.textContent = 'Username is required';
                usernameError.style.display = 'block';
                hasError = true;
            }

            if (!password) {
                passwordError.textContent = 'Password is required';
                passwordError.style.display = 'block';
                hasError = true;
            }

            if (hasError) {
                e.preventDefault();
            }
        });
    </script>
</body>
</html>
