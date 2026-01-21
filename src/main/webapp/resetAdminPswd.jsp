<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Reset Password</title>
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
        margin-bottom: 20px;
    }
    
    label {
        display: block;
        margin-bottom: 8px;
        color: #333;
        font-weight: 500;
        font-size: 14px;
    }
    
    input[type="email"],
    input[type="password"] {
        width: 100%;
        padding: 12px;
        border: 2px solid #ddd;
        border-radius: 6px;
        font-size: 14px;
        transition: border-color 0.3s;
    }
    
    input[type="email"]:focus,
    input[type="password"]:focus {
        outline: none;
        border-color: #667eea;
    }
    
    input[readonly] {
        background-color: #f5f5f5;
        cursor: not-allowed;
    }
    
    .password-hint {
        background: #f8f9fa;
        padding: 12px;
        border-radius: 6px;
        margin-top: 10px;
        font-size: 12px;
        color: #666;
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
</style>
</head>
<body>

<%
  // Retrieve email from session
   String email = (String) session.getAttribute("adminEmail");
   if(email == null) {
       response.sendRedirect("forgotAdminPswd.jsp");
       return;
   }
%>

<div class="container">
    <h2>🔐 Reset Password</h2>
    <p class="subtitle">Create a new password for your account</p>

    <%
        String msg = request.getParameter("msg");
        if("Error".equals(msg)) {
    %>
        <div class="alert alert-error">
            <span>❌</span>
            <span>Passwords don't match. Please try again.</span>
        </div>
    <% } else if("success".equals(msg)) { %>
        <div class="alert alert-success">
            <span>✅</span>
            <span>Password reset successfully!</span>
        </div>
    <% } %>

    <form action="admin-reset-pswd" method="post">
        
        <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" value="<%= email %>" readonly required>
        </div>

        <div class="form-group">
            <label for="newPassword">New Password</label>
            <input type="password" id="newPassword" name="newPassword" minlength="6" maxlength="20" required>
            <div class="password-hint">
                Password must be minimum 6 characters
            </div>
        </div>

        <div class="form-group">
            <label for="confirmPassword">Confirm Password</label>
            <input type="password" id="confirmPassword" name="confirmPassword" minlength="6" maxlength="20" required>
        </div>

        <button type="submit">Reset Password</button>
        
        <div class="back-link">
            <a href="forgotAdminPswd.jsp">← Back to Forgot Password</a>
        </div>
    </form>
</div>

</body>
</html>