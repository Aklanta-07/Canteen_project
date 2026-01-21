<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Forgot Password</title>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 20px;
    }
    
    .container {
        background: white;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        width: 100%;
        max-width: 450px;
    }
    
    h2 {
        color: #333;
        margin-bottom: 10px;
        text-align: center;
    }
    
    .subtitle {
        color: #666;
        text-align: center;
        margin-bottom: 30px;
        font-size: 14px;
        line-height: 1.5;
    }
    
    .alert {
        padding: 12px 15px;
        border-radius: 6px;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .alert-error {
        background-color: #fee;
        border: 1px solid #fcc;
        color: #c33;
    }
    
    .alert-success {
        background-color: #efe;
        border: 1px solid #cfc;
        color: #3c3;
    }
    
    .form-group {
        margin-bottom: 25px;
    }
    
    label {
        display: block;
        margin-bottom: 8px;
        color: #333;
        font-weight: 500;
        font-size: 14px;
    }
    
    input[type="email"] {
        width: 100%;
        padding: 12px;
        border: 2px solid #ddd;
        border-radius: 6px;
        font-size: 14px;
        transition: border-color 0.3s;
    }
    
    input[type="email"]:focus {
        outline: none;
        border-color: #667eea;
    }
    
    button[type="submit"] {
        width: 100%;
        padding: 14px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: transform 0.2s, box-shadow 0.2s;
    }
    
    button[type="submit"]:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
    }
    
    .back-link {
        text-align: center;
        margin-top: 20px;
    }
    
    .back-link a {
        color: #667eea;
        text-decoration: none;
        font-size: 14px;
    }
    
    .back-link a:hover {
        text-decoration: underline;
    }
    
    .info-box {
        background: #f8f9fa;
        padding: 15px;
        border-radius: 6px;
        margin-bottom: 20px;
        font-size: 13px;
        color: #555;
        border-left: 4px solid #667eea;
    }
</style>
</head>
<body>

<div class="container">
    <h2>🔑 Forgot Password?</h2>
    <p class="subtitle">
        No worries! Enter your email address and we'll help you reset your password.
    </p>

    <%
        String message = request.getParameter("message");
        if("Access denied".equals(message)) {
    %>
        <div class="alert alert-error">
            <span>❌</span>
            <span>Invalid Email! Please try again.</span>
        </div>
    <% } else if("success".equals(message)) { %>
        <div class="alert alert-success">
            <span>✅</span>
            <span>Verification email sent! Please check your inbox.</span>
        </div>
    <% } %>

    <div class="info-box">
        💡 <strong>Note:</strong> Make sure to enter the email address associated with your account.
    </div>

    <form action="admin-forgot-pswd" method="post">
        <div class="form-group">
            <label for="email">Email Address</label>
            <input 
                type="email" 
                id="email" 
                name="email" 
                placeholder="Enter your email" 
                required>
        </div>

        <button type="submit"> Reset </button>
        
        <div class="back-link">
            <a href="adminLogin.jsp">← Back to Login</a>
        </div>
    </form>
</div>

</body>
</html>