<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, in.dbconnection.DatabaseConnection" %>
<%
    if(session.getAttribute("userEmail") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String userEmail = (String) session.getAttribute("userEmail");
    String usertype = (String) session.getAttribute("usertype");
    String displayUserType = usertype != null ? usertype.substring(0, 1).toUpperCase() + usertype.substring(1) : "User";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Place Order - Canteen</title>
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
        
        .order-container {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
        }
        
        .meal-card {
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            transition: all 0.3s;
            cursor: pointer;
        }
        
        .meal-card:hover {
            border-color: #3498db;
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.2);
        }
        
        .meal-card.selected {
            border-color: #3498db;
            background-color: #e8f4fd;
        }
        
        .meal-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }
        
        .quantity-control {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .quantity-btn {
            width: 35px;
            height: 35px;
            border: none;
            border-radius: 50%;
            background: #3498db;
            color: white;
            font-size: 18px;
            cursor: pointer;
        }
        
        .quantity-btn:hover {
            background: #2980b9;
        }
        
        .quantity-display {
            font-size: 20px;
            font-weight: bold;
            min-width: 30px;
            text-align: center;
        }
        
        .order-summary {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            position: sticky;
            top: 20px;
        }
        
        .summary-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #dee2e6;
        }
        
        .summary-total {
            font-size: 20px;
            font-weight: bold;
            color: #2c3e50;
            padding-top: 15px;
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
            <a href="menu.jsp" class="menu-item">
                <i class="fas fa-book-open"></i><span>Today's Menu</span>
            </a>
            <a href="order.jsp" class="menu-item active">
                <i class="fas fa-shopping-cart"></i><span>Place Order</span>
            </a>
            <a href="orders.jsp" class="menu-item">
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
            <a href="LogoutServlet" class="menu-item">
                <i class="fas fa-sign-out-alt"></i><span>Logout</span>
            </a>
        </div>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        <div class="top-bar">
            <h5 class="mb-0"><i class="fas fa-shopping-cart"></i> Place Your Order</h5>
        </div>
        
        <div class="row">
            <div class="col-lg-8">
                <div class="order-container">
                    <h4 class="mb-4">Select Your Meals</h4>
                    
                    <form id="orderForm" action="PlaceOrderServlet" method="post">
                        <div class="row">
                            <!-- Breakfast Card -->
                            <div class="col-md-6">
                                <div class="meal-card" onclick="toggleMeal('breakfast')">
                                    <div class="text-center">
                                        <div class="meal-icon text-warning">
                                            <i class="fas fa-coffee"></i>
                                        </div>
                                        <h5>Breakfast Special</h5>
                                        <p class="text-muted small">Idli, Vada, Sambar, Chutney</p>
                                        <h4 class="text-success">₹40</h4>
                                        <span class="badge bg-warning text-dark">7:00 AM - 10:00 AM</span>
                                    </div>
                                    <div class="quantity-control justify-content-center mt-3" id="breakfast-qty" style="display: none;">
                                        <button type="button" class="quantity-btn" onclick="changeQty('breakfast', -1)">-</button>
                                        <span class="quantity-display" id="breakfast-display">1</span>
                                        <button type="button" class="quantity-btn" onclick="changeQty('breakfast', 1)">+</button>
                                    </div>
                                    <input type="hidden" name="breakfast" id="breakfast-input" value="0">
                                </div>
                            </div>
                            
                            <!-- Lunch Card -->
                            <div class="col-md-6">
                                <div class="meal-card" onclick="toggleMeal('lunch')">
                                    <div class="text-center">
                                        <div class="meal-icon text-info">
                                            <i class="fas fa-hamburger"></i>
                                        </div>
                                        <h5>Lunch Combo</h5>
                                        <p class="text-muted small">Rice, Dal, Roti, Sabji, Salad</p>
                                        <h4 class="text-success">₹80</h4>
                                        <span class="badge bg-info text-dark">12:00 PM - 3:00 PM</span>
                                    </div>
                                    <div class="quantity-control justify-content-center mt-3" id="lunch-qty" style="display: none;">
                                        <button type="button" class="quantity-btn" onclick="changeQty('lunch', -1)">-</button>
                                        <span class="quantity-display" id="lunch-display">1</span>
                                        <button type="button" class="quantity-btn" onclick="changeQty('lunch', 1)">+</button>
                                    </div>
                                    <input type="hidden" name="lunch" id="lunch-input" value="0">
                                </div>
                            </div>
                            
                            <!-- Dinner Card -->
                            <div class="col-md-6">
                                <div class="meal-card" onclick="toggleMeal('dinner')">
                                    <div class="text-center">
                                        <div class="meal-icon text-danger">
                                            <i class="fas fa-pizza-slice"></i>
                                        </div>
                                        <h5>Dinner Delight</h5>
                                        <p class="text-muted small">Roti, Paneer Curry, Rice, Dal</p>
                                        <h4 class="text-success">₹70</h4>
                                        <span class="badge bg-danger">7:00 PM - 9:00 PM</span>
                                    </div>
                                    <div class="quantity-control justify-content-center mt-3" id="dinner-qty" style="display: none;">
                                        <button type="button" class="quantity-btn" onclick="changeQty('dinner', -1)">-</button>
                                        <span class="quantity-display" id="dinner-display">1</span>
                                        <button type="button" class="quantity-btn" onclick="changeQty('dinner', 1)">+</button>
                                    </div>
                                    <input type="hidden" name="dinner" id="dinner-input" value="0">
                                </div>
                            </div>
                            
                            <!-- Snacks Card -->
                            <div class="col-md-6">
                                <div class="meal-card" onclick="toggleMeal('snacks')">
                                    <div class="text-center">
                                        <div class="meal-icon text-success">
                                            <i class="fas fa-cookie-bite"></i>
                                        </div>
                                        <h5>Evening Snacks</h5>
                                        <p class="text-muted small">Samosa, Tea, Pakora</p>
                                        <h4 class="text-success">₹30</h4>
                                        <span class="badge bg-success">4:00 PM - 6:00 PM</span>
                                    </div>
                                    <div class="quantity-control justify-content-center mt-3" id="snacks-qty" style="display: none;">
                                        <button type="button" class="quantity-btn" onclick="changeQty('snacks', -1)">-</button>
                                        <span class="quantity-display" id="snacks-display">1</span>
                                        <button type="button" class="quantity-btn" onclick="changeQty('snacks', 1)">+</button>
                                    </div>
                                    <input type="hidden" name="snacks" id="snacks-input" value="0">
                                </div>
                            </div>
                        </div>
                        
                        <div class="mt-4">
                            <label class="form-label">Special Instructions (Optional)</label>
                            <textarea class="form-control" name="instructions" rows="3" placeholder="Any special requests..."></textarea>
                        </div>
                    </form>
                </div>
            </div>
            
            <div class="col-lg-4">
                <div class="order-summary">
                    <h5 class="mb-3">Order Summary</h5>
                    <div id="summary-items"></div>
                    <div class="summary-item summary-total">
                        <span>Total Amount:</span>
                        <span id="total-amount">₹0</span>
                    </div>
                    <button type="button" class="btn btn-primary w-100 mt-3" onclick="submitOrder()">
                        <i class="fas fa-check"></i> Confirm Order
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Store quantities and prices
        const quantities = {};
        const prices = {};
        
        // Toggle meal selection
        function toggleMeal(menuId, price) {
            const card = document.getElementById('card-' + menuId);
            const qtyDiv = document.getElementById('qty-' + menuId);
            
            if (!quantities[menuId] || quantities[menuId] === 0) {
                quantities[menuId] = 1;
                prices[menuId] = price;
                card.classList.add('selected');
                qtyDiv.style.display = 'flex';
            } else {
                quantities[menuId] = 0;
                card.classList.remove('selected');
                qtyDiv.style.display = 'none';
            }
            
            updateDisplay(menuId);
            updateSummary();
        }
        
        // Change quantity
        function changeQty(menuId, price, delta) {
            event.stopPropagation();
            quantities[menuId] = Math.max(1, (quantities[menuId] || 0) + delta);
            prices[menuId] = price;
            updateDisplay(menuId);
            updateSummary();
        }
        
        // Update quantity display
        function updateDisplay(menuId) {
            document.getElementById('display-' + menuId).textContent = quantities[menuId] || 0;
            document.getElementById('input-' + menuId).value = quantities[menuId] || 0;
        }
        
        // Update order summary
        function updateSummary() {
            let summaryHTML = '';
            let total = 0;
            let itemCount = 0;
            
            for (let menuId in quantities) {
                if (quantities[menuId] > 0) {
                    const itemName = document.querySelector(`input[name="name_${menuId}"]`).value;
                    const amount = quantities[menuId] * prices[menuId];
                    total += amount;
                    itemCount++;
                    
                    summaryHTML += `
                        <div class="summary-item">
                            <span>${itemName} x${quantities[menuId]}</span>
                            <span>₹${amount.toFixed(2)}</span>
                        </div>
                    `;
                }
            }
            
            if (itemCount === 0) {
                summaryHTML = '<p class="text-muted text-center">No items selected</p>';
            }
            
            document.getElementById('summary-items').innerHTML = summaryHTML;
            document.getElementById('total-amount').textContent = '₹' + total.toFixed(2);
        }
        
        // Submit order
        function submitOrder() {
            const total = Object.keys(quantities).reduce((sum, menuId) => 
                sum + ((quantities[menuId] || 0) * (prices[menuId] || 0)), 0
            );
            
            if (total === 0) {
                alert('Please select at least one item!');
                return;
            }
            
            if (confirm('Confirm your order of ₹' + total.toFixed(2) + '?')) {
                document.getElementById('orderForm').submit();
            }
        }
    </script>
</body>
</html>