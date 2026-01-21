<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Dashboard</title>
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
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .login-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            width: 100%;
            max-width: 450px;
            animation: slideUp 0.5s ease-out;
        }
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .login-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 40px 30px;
            text-align: center;
            color: white;
        }
        .login-header h1 {
            font-size: 28px;
            margin-bottom: 8px;
            font-weight: 600;
        }
        .login-header p {
            font-size: 14px;
            opacity: 0.9;
        }
        .admin-icon {
            width: 80px;
            height: 80px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 40px;
        }
        .login-body {
            padding: 40px 30px;
        }
        .form-group {
            margin-bottom: 25px;
            position: relative;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
            font-size: 14px;
        }
        .input-wrapper {
            position: relative;
        }
        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            font-size: 18px;
        }
        .form-control {
            width: 100%;
            padding: 14px 15px 14px 45px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s ease;
            outline: none;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #999;
            font-size: 18px;
            user-select: none;
        }
        .password-toggle:hover {
            color: #667eea;
        }
        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            font-size: 14px;
        }
        .remember-me {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .remember-me input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }
        .forgot-password {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }
        .forgot-password:hover {
            text-decoration: underline;
        }
        .btn-login {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
        }
        .btn-login:active {
            transform: translateY(0);
        }
        .alert {
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            display: none;
        }
        .alert-error {
            background: #fee;
            color: #c33;
            border: 1px solid #fcc;
            display: block;
        }
        .alert-success {
            background: #efe;
            color: #3c3;
            border: 1px solid #cfc;
            display: block;
        }
        .login-footer {
            text-align: center;
            padding: 20px 30px;
            background: #f8f9fa;
            font-size: 13px;
            color: #666;
        }
        .flash-message {
            animation: slideDown 0.5s ease-out, fadeOut 0.5s ease-out 2.5s;
            animation-fill-mode: forwards;
        }

        @keyframes slideDown {
          from {
            opacity: 0;
            transform: translateY(-20px);
          }
          to {
            opacity: 1;
            transform: translateY(0);
          }
       }

       @keyframes fadeOut {
         from {
           opacity: 1;
         }
         to {
           opacity: 0;
           visibility: hidden;
         }
       }

        @media (max-width: 480px) {
            .login-header h1 {
                font-size: 24px;
            }
            .login-body {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <div class="admin-icon">👤</div>
            <h1>Admin Portal</h1>
            <p>Sign in to access your dashboard</p>
        </div>
        <div class="login-body">
            <% String error = request.getParameter("error"); String success = request.getParameter("success"); %>
            <% if (error != null) { %>
                <div class="alert alert-error">
                    <% if (error.equals("invalid")) { %>
                        Invalid email or password. Please try again.
                    <% } else if (error.equals("locked")) { %>
                        Your account has been locked. Please contact administrator.
                    <% } else if (error.equals("inactive")) { %>
                        Your account is inactive. Please contact administrator.
                    <% } else { %>
                        Login failed. Please try again.
                    <% } %>
                </div>
            <% } %>
            <% if (success != null && success.equals("logout")) { %>
                <div class="alert alert-success">
                    You have been successfully logged out.
                </div>
            <% } %>
            
            <%
              String msg = request.getParameter("msg");
                if(msg != null) {
                  if("success".equals(msg)) {
            %>
               <div class="alert alert-success flash-message" id="flashMessage">
                    ✓ Password reset successfully! Please login with your new password.
               </div>
            <%
                 }
               }
            %>
 
            <form action="admin-login" method="post" id="loginForm">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-wrapper">
                        <span class="input-icon">📧</span>
                        <input type="email" id="email" name="email" class="form-control" placeholder="Enter your email" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-wrapper">
                        <span class="input-icon">🔒</span>
                        <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
                        <span class="password-toggle" onclick="togglePassword()">👁️</span>
                    </div>
                </div>
                <div class="remember-forgot">
                    <label class="remember-me">
                        <input type="checkbox" name="remember" value="true">
                        <span>Remember me</span>
                    </label>
                    <a href="forgotAdminPswd.jsp" class="forgot-password">Forgot Password?</a>
                </div>
                <button type="submit" class="btn-login">Sign In</button>
            </form>
        </div>
        <div class="login-footer">
            © 2026 Admin Dashboard. All rights reserved.
        </div>
    </div>
    <script>
    
     // Auto-hide after 3 seconds
        setTimeout(function() {
            const flashMsg = document.getElementById('flashMessage');
            if(flashMsg) {
            flashMsg.style.display = 'none';
            }
        }, 3000);
    
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const toggleIcon = document.querySelector('.password-toggle');
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.textContent = '👁️‍🗨️';
            } else {
                passwordInput.type = 'password';
                toggleIcon.textContent = '👁️';
            }
        }
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value;
            if (!email || !password) {
                e.preventDefault();
                alert('Please fill in all fields');
                return false;
            }
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('Please enter a valid email address');
                return false;
            }
        });
    </script>
</body>
</html>