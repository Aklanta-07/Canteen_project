<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <% // Check if user is logged in
    if(session.getAttribute("userEmail") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) session.getAttribute("userEmail");
%>  
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Canteen - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f6fa;
        }
        
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 260px;
            background: linear-gradient(180deg, #2c3e50 0%, #34495e 100%);
            padding: 20px 0;
            z-index: 1000;
            transition: all 0.3s;
        }
        
        .sidebar-header {
            padding: 0 20px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            text-align: center;
        }
        
        .sidebar-header h4 {
            color: white;
            margin-top: 10px;
            font-size: 22px;
        }
        
        .sidebar-header i {
            font-size: 40px;
            color: #3498db;
        }
        
        .sidebar-menu {
            margin-top: 20px;
        }
        
        .menu-item {
            padding: 15px 20px;
            color: #ecf0f1;
            text-decoration: none;
            display: flex;
            align-items: center;
            transition: all 0.3s;
            border-left: 4px solid transparent;
        }
        
        .menu-item:hover, .menu-item.active {
            background-color: rgba(52, 152, 219, 0.2);
            border-left-color: #3498db;
            color: white;
        }
        
        .menu-item i {
            margin-right: 15px;
            width: 20px;
            text-align: center;
        }
        
        .main-content {
            margin-left: 260px;
            padding: 20px;
            min-height: 100vh;
        }
        
        .top-bar {
            background: white;
            padding: 15px 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }
        
        .welcome-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.3);
        }
        
        .menu-showcase {
            margin-top: 30px;
        }
        
        .menu-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            margin-bottom: 20px;
        }
        
        .menu-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        
        .menu-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 60px;
            color: white;
        }
        
        /* When using <img> tags for real images */
        img.menu-image {
            object-fit: cover;
            display: block;
        }
        
        .menu-card-body {
            padding: 20px;
        }
        
        .menu-card-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #2c3e50;
        }
        
        .menu-badge {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            margin-top: 10px;
        }
        
        .badge-breakfast {
            background: #fff3cd;
            color: #856404;
        }
        
        .badge-lunch {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .badge-dinner {
            background: #f8d7da;
            color: #721c24;
        }
        
        .stats-row {
            margin-top: 30px;
        }
        
        .stat-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        .stat-icon {
            font-size: 40px;
            margin-bottom: 15px;
        }
        
        .stat-number {
            font-size: 32px;
            font-weight: bold;
            color: #2c3e50;
        }
        
        .stat-label {
            color: #7f8c8d;
            margin-top: 5px;
        }
        
        .highlighted {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
            margin: 5px 10px;
            position: relative;
            animation: pulse-glow 2s infinite;
        }

        .highlighted::after {
            content: 'NEW';
            position: absolute;
            top: -8px;
            right: 10px;
            background: #ff6b6b;
            color: white;
            padding: 3px 10px;
            border-radius: 12px;
            font-size: 0.7em;
            font-weight: bold;
            box-shadow: 0 2px 8px rgba(255,107,107,0.5);
            animation: bounce 1.5s infinite;
        }

        @keyframes pulse-glow {
            0%, 100% { box-shadow: 0 0 15px rgba(102, 126, 234, 0.5); }
            50% { box-shadow: 0 0 25px rgba(102, 126, 234, 0.8); }
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
        }
        
        @media (max-width: 768px) {
            .sidebar {
                left: -260px;
            }
            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <i class="fas fa-utensils"></i>
            <h4>Ama Canteen</h4>
        </div>
        <div class="sidebar-menu">
            <a href="home.jsp" class="menu-item active">
                <i class="fas fa-home"></i>
                <span>Home</span>
            </a>
            <a href="menu.jsp" class="menu-item">
                <i class="fas fa-book-open"></i>
                <span>Today's Menu</span>
            </a>
            <a href="order.jsp" class="menu-item">
                <i class="fas fa-shopping-cart"></i>
                <span>Place Order</span>
            </a>
            <a href="orders.jsp" class="menu-item">
                <i class="fas fa-history"></i>
                <span>Order History</span>
            </a>
            <a href="calCalculator.jsp" class="menu-item highlighted">
                <i class="fas fa-calculator"></i>
                <span>Calorie Calculator</span>
            </a>
            <a href="profile" class="menu-item">
                <i class="fas fa-user"></i>
                <span>My Profile</span>
            </a>
            <a href="feedback.jsp" class="menu-item">
                <i class="fas fa-comment-dots"></i>
                <span>Feedback</span>
            </a>
            <a href="notifications.jsp" class="menu-item">
                <i class="fas fa-bell"></i>
                <span>Notifications</span>
            </a>
            <a href="logout" class="menu-item">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </a>
        </div>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
        <div class="top-bar">
            <div>
                <h5 class="mb-0">Dashboard</h5>
                <small class="text-muted">Welcome back!</small>
            </div>
            <div class="user-info">
                <div>
                    <div class="fw-bold"><%= username %></div>
                    <small class="text-muted">Student</small>
                </div>
                <div class="user-avatar">
                    <%= username.substring(0,1).toUpperCase() %>
                </div>
            </div>
        </div>
        
        <!-- Welcome Section -->
        <div class="welcome-section">
            <h2>Welcome to Our Canteen, <%= username %>!</h2>
            <p class="mb-0">Enjoy delicious, fresh, and healthy meals every day</p>
        </div>
        
        <!-- Stats Row -->
        <div class="stats-row row">
            <div class="col-md-4 mb-3">
                <div class="stat-card">
                    <div class="stat-icon text-primary">
                        <i class="fas fa-utensils"></i>
                    </div>
                    <div class="stat-number">3</div>
                    <div class="stat-label">Meals Available Today</div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="stat-card">
                    <div class="stat-icon text-success">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-number">Open</div>
                    <div class="stat-label">Canteen Status</div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="stat-card">
                    <div class="stat-icon text-warning">
                        <i class="fas fa-receipt"></i>
                    </div>
                    <div class="stat-number">15</div>
                    <div class="stat-label">Your Total Orders</div>
                </div>
            </div>
        </div>
        
        <!-- Menu Showcase -->
        <div class="menu-showcase">
            <h4 class="mb-4">Today's Special Menu</h4>
            <div class="row">
                <div class="col-md-4">
                    <div class="menu-card">
                        <!-- Option 1: Use real image (uncomment when you have images) -->
                        <!-- <img src="images/breakfast.jpg" class="menu-image" alt="Breakfast"> -->
                        
                        <!-- Option 2: Use icon placeholder (current) -->
                        <div class="menu-image">
                            <i class="fas fa-coffee"></i>
                        </div>
                        
                        <div class="menu-card-body">
                            <h5 class="menu-card-title">Breakfast Special</h5>
                            <p class="text-muted">Idli, Vada, Sambar, Chutney, Coffee</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="menu-badge badge-breakfast">7:00 AM - 10:00 AM</span>
                                <span class="fw-bold text-success">₹40</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="menu-card">
                        <!-- Option 1: Use real image (uncomment when you have images) -->
                        <!-- <img src="images/lunch.jpg" class="menu-image" alt="Lunch"> -->
                        
                        <!-- Option 2: Use icon placeholder (current) -->
                        <div class="menu-image" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
                            <i class="fas fa-hamburger"></i>
                        </div>
                        
                        <div class="menu-card-body">
                            <h5 class="menu-card-title">Lunch Combo</h5>
                            <p class="text-muted">Rice, Dal, Roti, Sabji, Salad, Curd</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="menu-badge badge-lunch">12:00 PM - 3:00 PM</span>
                                <span class="fw-bold text-success">₹80</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="menu-card">
                        <!-- Option 1: Use real image (uncomment when you have images) -->
                        <!-- <img src="images/dinner.jpg" class="menu-image" alt="Dinner"> -->
                        
                        <!-- Option 2: Use icon placeholder (current) -->
                        <div class="menu-image" style="background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);">
                            <i class="fas fa-pizza-slice"></i>
                        </div>
                        
                        <div class="menu-card-body">
                            <h5 class="menu-card-title">Dinner Delight</h5>
                            <p class="text-muted">Roti, Paneer Curry, Rice, Dal, Papad</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="menu-badge badge-dinner">7:00 PM - 9:00 PM</span>
                                <span class="fw-bold text-success">₹70</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="text-center mt-4">
            <a href="order.jsp" class="btn btn-primary btn-lg">
                <i class="fas fa-shopping-cart"></i> Place Your Order Now
            </a>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>