<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, in.dbconnection.DatabaseConnection" %>
<%
    if(session.getAttribute("userEmail") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) session.getAttribute("userEmail");
    String usertype = (String) session.getAttribute("usertype");
    String displayUserType = usertype != null ? usertype.substring(0, 1).toUpperCase() + usertype.substring(1) : "User";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Today's Menu - Canteen</title>
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
        }
        
        .sidebar-header {
            padding: 0 20px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            text-align: center;
            color: white;
        }
        
        .sidebar-header h4 { margin-top: 10px; font-size: 22px; }
        .sidebar-header i { font-size: 40px; color: #3498db; }
        
        .sidebar-menu { margin-top: 20px; }
        
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
        
        .menu-item i { margin-right: 15px; width: 20px; text-align: center; }
        
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
            margin-bottom: 30px;
        }
        
        .menu-category {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
        }
        
        .category-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .category-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-right: 15px;
        }
        
        .icon-breakfast { background: #fff3cd; color: #856404; }
        .icon-lunch { background: #d1ecf1; color: #0c5460; }
        .icon-dinner { background: #f8d7da; color: #721c24; }
        .icon-snacks { background: #d4edda; color: #155724; }
        
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .menu-item-card {
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            padding: 20px;
            transition: all 0.3s;
            position: relative;
        }
        
        .menu-item-card:hover {
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transform: translateY(-3px);
        }
        
        .item-name {
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 8px;
        }
        
        .item-description {
            color: #7f8c8d;
            font-size: 14px;
            margin-bottom: 12px;
        }
        
        .item-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
        }
        
        .item-price {
            font-size: 20px;
            font-weight: bold;
            color: #27ae60;
        }
        
        .availability-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .badge-available {
            background: #d4edda;
            color: #155724;
        }
        
        .badge-unavailable {
            background: #f8d7da;
            color: #721c24;
        }
        
       .time-slot {
           display: inline-block;
           padding: 5px 10px;
           background: #e3f2fd;
           border-radius: 20px;
           font-size: 13px;
           color: #1976d2;
           margin-top: 9px;
           font-weight: 500;
           border: 2px solid #1976d2;
           box-shadow: 0 2px 4px rgba(0,0,0,0.1);
       }
        
        .no-items {
            text-align: center;
            padding: 40px;
            color: #95a5a6;
        }
        
        .filter-bar {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <i class="fas fa-utensils"></i>
            <h4>Canteen Portal</h4>
        </div>
        <div class="sidebar-menu">
            <a href="home.jsp" class="menu-item">
                <i class="fas fa-home"></i><span>Home</span>
            </a>
            <a href="menu.jsp" class="menu-item active">
                <i class="fas fa-book-open"></i><span>Today's Menu</span>
            </a>
            <a href="order" class="menu-item">
                <i class="fas fa-shopping-cart"></i><span>Place Order</span>
            </a>
            <a href="MyOrdersServlet" class="menu-item">
                <i class="fas fa-history"></i><span>Order History</span>
            </a>
            <a href="profile" class="menu-item">
                <i class="fas fa-user"></i><span>My Profile</span>
            </a>
            <a href="feedback.jsp" class="menu-item">
                <i class="fas fa-comment-dots"></i><span>Feedback</span>
            </a>
            <a href="notifications.jsp" class="menu-item">
                <i class="fas fa-bell"></i><span>Notifications</span>
            </a>
            <a href="logout" class="menu-item">
                <i class="fas fa-sign-out-alt"></i><span>Logout</span>
            </a>
        </div>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        <div class="top-bar">
            <h5 class="mb-0"><i class="fas fa-book-open"></i> Today's Menu</h5>
        </div>
        
        <!-- Filter Bar -->
        <div class="filter-bar">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h6 class="mb-0">
                        <i class="fas fa-calendar-day"></i> 
                        <%= new java.text.SimpleDateFormat("EEEE, MMMM dd, yyyy").format(new java.util.Date()) %>
                    </h6>
                </div>
                <div class="col-md-4 text-end">
                    <span class="badge bg-success"><i class="fas fa-circle"></i> Kitchen Open</span>
                </div>
            </div>
        </div>
        
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            
            try {
                conn = DatabaseConnection.getConnection();
                
                // Fetch menu items by category
                String[] categories = {"breakfast", "lunch", "dinner", "snacks"};
                String[] categoryNames = {"Breakfast", "Lunch", "Dinner", "Snacks"};
                String[] categoryIcons = {"fa-coffee", "fa-hamburger", "fa-pizza-slice", "fa-cookie-bite"};
                String[] iconClasses = {"icon-breakfast", "icon-lunch", "icon-dinner", "icon-snacks"};
                
                for(int i = 0; i < categories.length; i++) {
                    String category = categories[i];
                    String categoryName = categoryNames[i];
                    String categoryIcon = categoryIcons[i];
                    String iconClass = iconClasses[i];
        %>
        
        <!-- Category Section -->
        <div class="menu-category">
            <div class="category-header">
                <div class="category-icon <%= iconClass %>">
                    <i class="fas <%= categoryIcon %>"></i>
                </div>
                <h4 class="mb-0"><%= categoryName %></h4>
            </div>
            
            <div class="menu-grid">
                <%
                    String sql =
                    "SELECT * FROM menus WHERE MEAL_TYPE = ? AND availability = 'available' AND TRUNC(menu_date) = TRUNC(SYSDATE) ORDER BY DISH_NAME";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, category);
                    rs = pstmt.executeQuery();
                    
                    boolean hasItems = false;
                    while(rs.next()) {
                        hasItems = true;
                %>
                
                <div class="menu-item-card">
                    <div class="item-name"><%= rs.getString("DISH_NAME") %></div>
                    <div class="item-description"><%= rs.getString("description") %></div>
                    
                    <% if(rs.getString("time_slot") != null) { %>
                        <div class="time-slot">
                            <i class="fas fa-clock"></i> <%= rs.getString("time_slot") %>
                        </div>
                    <% } %>  
                    
                    <div class="item-footer">
                        <div class="item-price">₹<%= rs.getDouble("price") %></div>
                        <span class="availability-badge badge-available">
                            <i class="fas fa-check-circle"></i> Available
                        </span>
                    </div>
                </div>
                
                <%
                    }
                    
                    if(!hasItems) {
                %>
                    <div class="no-items">
                        <i class="fas fa-utensils" style="font-size: 48px; color: #ddd; margin-bottom: 10px;"></i>
                        <p>No items available in this category</p>
                    </div>
                <%
                    }
                    
                    rs.close();
                    pstmt.close();
                %>
            </div>
        </div>
        
        <%
                }
                
            } catch(Exception e) {
                e.printStackTrace();
        %>
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i> Error loading menu. Please try again later.
            </div>
        <%
            } finally {
                try {
                    if(rs != null) rs.close();
                    if(pstmt != null) pstmt.close();
                    if(conn != null) conn.close();
                } catch(Exception e) {
                    e.printStackTrace();
                }
            }
        %>
        
        <div class="text-center mt-4">
            <a href="order" class="btn btn-primary btn-lg">
                <i class="fas fa-shopping-cart"></i> Place Your Order
            </a>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>