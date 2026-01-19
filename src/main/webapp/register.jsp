<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Canteen Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px 0;
        }
        .register-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            overflow: hidden;
            max-width: 1000px;
            width: 100%;
        }
        .register-left {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 60px 40px;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .register-left i {
            font-size: 80px;
            margin-bottom: 20px;
        }
        .register-left h2 {
            margin-bottom: 20px;
        }
        .register-left p {
            font-size: 16px;
            line-height: 1.6;
        }
        .register-right {
            padding: 40px;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-register {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 12px;
            font-weight: 600;
            letter-spacing: 1px;
            transition: all 0.3s;
        }
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }
        .input-group-text {
            background-color: #f8f9fa;
            border-right: none;
        }
        .form-control {
            border-left: none;
        }
        .password-strength {
            height: 5px;
            border-radius: 3px;
            margin-top: 5px;
            transition: all 0.3s;
        }
        .strength-weak { background: #dc3545; width: 33%; }
        .strength-medium { background: #ffc107; width: 66%; }
        .strength-strong { background: #28a745; width: 100%; }
        .form-label {
            font-weight: 500;
            margin-bottom: 8px;
        }
        .error-message {
            font-size: 14px;
            margin-top: 5px;
        }
        .features-list {
            list-style: none;
            padding: 0;
            margin-top: 20px;
        }
        .features-list li {
            padding: 8px 0;
            font-size: 15px;
        }
        .features-list i {
            margin-right: 10px;
            color: #ffffff;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="register-container row g-0">
            <!-- Left Side -->
            <div class="col-md-5 register-left d-none d-md-block">
                <i class="fas fa-user-plus"></i>
                <h2>Join Our Canteen Community</h2>
                <p>Create an account and enjoy hassle-free meal ordering</p>
                
                <ul class="features-list">
                    <li><i class="fas fa-check-circle"></i> Quick & Easy Ordering</li>
                    <li><i class="fas fa-check-circle"></i> View Daily Menu</li>
                    <li><i class="fas fa-check-circle"></i> Track Order History</li>
                    <li><i class="fas fa-check-circle"></i> Special Meal Requests</li>
                    <li><i class="fas fa-check-circle"></i> Secure Payments</li>
                </ul>
            </div>
            
            <!-- Right Side - Registration Form -->
            <div class="col-md-7 register-right">
                <h3 class="mb-4 text-center">Create Your Account</h3>
                
                <!-- Success Message -->
                <% if(request.getParameter("success") != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> Registration successful! Please login.
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>
                
                <!-- Error Message -->
                <% if(request.getParameter("error") != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> 
                        <% 
                            String error = request.getParameter("error");
                            if(error.equals("exists")) {
                                out.print("Username or email already exists!");
                            } else if(error.equals("password")) {
                                out.print("Passwords do not match!");
                            } else {
                                out.print("Registration failed. Please try again.");
                            }
                        %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>
                
                <form action="RegisterServlet" method="post" onsubmit="return validateForm()">
                    <div class="row">
                        <!-- Full Name -->
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Full Name *</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <input type="text" class="form-control" name="fullname" id="fullname" 
                                       placeholder="Enter your full name" required>
                            </div>
                        </div>
                        
                        <!-- Username -->
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Username *</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-at"></i></span>
                                <input type="text" class="form-control" name="username" id="username" 
                                       placeholder="Choose a username" required>
                            </div>
                            <small class="text-muted">Only letters, numbers, and underscores</small>
                        </div>
                    </div>
                    
                    <div class="row">
                        <!-- Email -->
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Email Address *</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                <input type="email" class="form-control" name="email" id="email" 
                                       placeholder="your.email@example.com" required>
                            </div>
                        </div>
                        
                        <!-- Phone -->
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Phone Number *</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                <input type="tel" class="form-control" name="phone" id="phone" 
                                       placeholder="10-digit number" pattern="[0-9]{10}" required>
                            </div>
                        </div>
                    </div>
                    
                    <!-- User Type -->
                    <div class="mb-3">
                        <label class="form-label">I am a *</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user-tag"></i></span>
                            <select class="form-select" name="usertype" required>
                                <option value="">Select user type</option>
                                <option value="student">Student</option>
                                <option value="working">Working</option>
                            </select>
                        </div>
                    </div>
                    
                    
                    <div class="row">
                        <!-- Password -->
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Password *</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                <input type="password" class="form-control" name="password" id="password" 
                                       placeholder="Create a password" required onkeyup="checkPasswordStrength()">
                                <span class="input-group-text" onclick="togglePassword('password')" style="cursor: pointer;">
                                    <i class="fas fa-eye" id="password-eye"></i>
                                </span>
                            </div>
                            <div class="password-strength" id="password-strength"></div>
                            <small class="text-muted">Min. 6 characters</small>
                        </div>
                        
                        <!-- Confirm Password -->
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Confirm Password *</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                <input type="password" class="form-control" name="confirmpassword" id="confirmpassword" 
                                       placeholder="Re-enter password" required>
                                <span class="input-group-text" onclick="togglePassword('confirmpassword')" style="cursor: pointer;">
                                    <i class="fas fa-eye" id="confirmpassword-eye"></i>
                                </span>
                            </div>
                            <small class="error-message text-danger" id="password-match"></small>
                        </div>
                    </div>
                    
                    <!-- Terms and Conditions -->
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="terms" required>
                        <label class="form-check-label" for="terms">
                            I agree to the <a href="#" class="text-decoration-none">Terms & Conditions</a> 
                            and <a href="#" class="text-decoration-none">Privacy Policy</a>
                        </label>
                    </div>
                    
                    <!-- Submit Button -->
                    <button type="submit" class="btn btn-primary btn-register w-100 mb-3">
                        <i class="fas fa-user-plus"></i> CREATE ACCOUNT
                    </button>
                    
                    <!-- Login Link -->
                    <div class="text-center">
                        <span>Already have an account?</span>
                        <a href="login.jsp" class="text-decoration-none fw-bold"> Login here</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle Password Visibility
        function togglePassword(fieldId) {
            const field = document.getElementById(fieldId);
            const eye = document.getElementById(fieldId + '-eye');
            
            if (field.type === 'password') {
                field.type = 'text';
                eye.classList.remove('fa-eye');
                eye.classList.add('fa-eye-slash');
            } else {
                field.type = 'password';
                eye.classList.remove('fa-eye-slash');
                eye.classList.add('fa-eye');
            }
        }
        
        // Check Password Strength
        function checkPasswordStrength() {
            const password = document.getElementById('password').value;
            const strengthBar = document.getElementById('password-strength');
            
            let strength = 0;
            if (password.length >= 6) strength++;
            if (password.length >= 10) strength++;
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
            if (/\d/.test(password)) strength++;
            if (/[^a-zA-Z\d]/.test(password)) strength++;
            
            strengthBar.className = 'password-strength';
            if (strength <= 2) {
                strengthBar.classList.add('strength-weak');
            } else if (strength <= 4) {
                strengthBar.classList.add('strength-medium');
            } else {
                strengthBar.classList.add('strength-strong');
            }
        }
        
        // Validate Form
        function validateForm() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmpassword').value;
            const username = document.getElementById('username').value;
            const phone = document.getElementById('phone').value;
            const matchMsg = document.getElementById('password-match');
            
            // Check password match
            if (password !== confirmPassword) {
                matchMsg.textContent = 'Passwords do not match!';
                return false;
            }  tgh.ertj
            
            // Check password length
            if (password.length < 6) {
                alert('Password must be at least 6 characters long!');
                return false;
            }
            
            // Check username format
            if (!/^[a-zA-Z0-9_]+$/.test(username)) {
                alert('Username can only contain letters, numbers, and underscores!');
                return false;
            }
            
            // Check phone number
            if (!/^\d{10}$/.test(phone)) {
                alert('Please enter a valid 10-digit phone number!');
                return false;
            }
            
            return true;
        }
        
        // Real-time password match check
        document.getElementById('confirmpassword').addEventListener('keyup', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            const matchMsg = document.getElementById('password-match');
            
            if (confirmPassword.length > 0) {
                if (password === confirmPassword) {
                    matchMsg.textContent = '✓ Passwords match';
                    matchMsg.classList.remove('text-danger');
                    matchMsg.classList.add('text-success');
                } else {
                    matchMsg.textContent = '✗ Passwords do not match';
                    matchMsg.classList.remove('text-success');
                    matchMsg.classList.add('text-danger');
                }
            } else {
                matchMsg.textContent = '';
            }
        });
    </script>
</body>
</html>