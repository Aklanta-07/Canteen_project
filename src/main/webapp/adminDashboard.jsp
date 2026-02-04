<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    // Check if admin is logged in
    if(session.getAttribute("adminEmail") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    
    String adminEmail = (String) session.getAttribute("adminEmail");
    if(adminEmail == null) adminEmail = "Admin";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Menu Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f6fa;
        }

        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 280px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            box-shadow: 4px 0 10px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        .sidebar-header {
            padding: 30px 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .sidebar-header h2 {
            font-size: 24px;
            margin-bottom: 5px;
        }

        .sidebar-header p {
            font-size: 12px;
            opacity: 0.8;
        }

        .admin-profile {
            padding: 25px 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .profile-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: rgba(255,255,255,0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 36px;
            border: 3px solid rgba(255,255,255,0.3);
        }

        .profile-name {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .profile-role {
            font-size: 13px;
            opacity: 0.8;
        }

        .sidebar-menu {
            padding: 20px 0;
        }

        .menu-item {
            padding: 15px 25px;
            display: flex;
            align-items: center;
            gap: 15px;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
            cursor: pointer;
            border-left: 4px solid transparent;
        }

        .menu-item:hover {
            background: rgba(255,255,255,0.1);
            border-left-color: white;
        }

        .menu-item.active {
            background: rgba(255,255,255,0.15);
            border-left-color: white;
        }

        .menu-item-icon {
            font-size: 20px;
            width: 24px;
        }

        .menu-item-text {
            font-size: 15px;
            font-weight: 500;
        }

        .logout-btn {
            position: absolute;
            bottom: 20px;
            left: 20px;
            right: 20px;
            padding: 12px;
            background: rgba(255,255,255,0.2);
            border: 1px solid rgba(255,255,255,0.3);
            color: white;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background: rgba(255,255,255,0.3);
        }

        /* Main Content Styles */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 30px;
        }

        .top-bar {
            background: white;
            padding: 20px 30px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-title {
            font-size: 28px;
            color: #2c3e50;
            font-weight: 600;
        }

        .date-display {
            color: #7f8c8d;
            font-size: 14px;
        }

        .content-section {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: none;
        }

        .content-section.active {
            display: block;
        }

        .section-header {
            font-size: 22px;
            color: #2c3e50;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }

        /* Add Menu Form Styles */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group-full {
            grid-column: 1 / -1;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #34495e;
            font-weight: 500;
            font-size: 14px;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        textarea.form-control {
            resize: vertical;
            min-height: 100px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 14px 30px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #95a5a6;
            color: white;
            padding: 14px 30px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            margin-left: 10px;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background: #7f8c8d;
        }

        /* Menu List Table */
        .menu-list-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .menu-list-table th {
            background: #f8f9fa;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #2c3e50;
            border-bottom: 2px solid #dee2e6;
        }

        .menu-list-table td {
            padding: 15px;
            border-bottom: 1px solid #dee2e6;
            color: #495057;
        }

        .menu-list-table tr:hover {
            background: #f8f9fa;
        }

        .badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-breakfast {
            background: #fff3cd;
            color: #856404;
        }

        .badge-lunch {
            background: #d4edda;
            color: #155724;
        }

        .badge-dinner {
            background: #d1ecf1;
            color: #0c5460;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn-edit, .btn-delete {
            padding: 6px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 13px;
            transition: all 0.3s ease;
        }

        .btn-edit {
            background: #3498db;
            color: white;
        }

        .btn-edit:hover {
            background: #2980b9;
        }

        .btn-delete {
            background: #e74c3c;
            color: white;
        }

        .btn-delete:hover {
            background: #c0392b;
        }

        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
        }

        .alert.show {
            display: block;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
        }

        .stat-icon.purple {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .stat-icon.green {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
        }

        .stat-icon.orange {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }

        .stat-info h3 {
            font-size: 32px;
            color: #2c3e50;
            margin-bottom: 5px;
        }

        .stat-info p {
            color: #7f8c8d;
            font-size: 14px;
        }
        
        .message {
        padding: 15px;
        margin: 10px 0;
        border-radius: 4px;
        position: relative;
       }
       .success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
       }
       .error {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
       }
       .close-btn {
        float: right;
        cursor: pointer;
        font-weight: bold;
       }

        @media (max-width: 768px) {
            .sidebar {
                width: 0;
                overflow: hidden;
            }

            .main-content {
                margin-left: 0;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <h2>🍽️ MenuMaster</h2>
                <p>Admin Panel</p>
            </div>

            <div class="admin-profile">
                <div class="profile-avatar">👤</div>
                <div class="profile-name"><%= adminEmail %></div>
                <div class="profile-role">Administrator</div>
            </div>

            <nav class="sidebar-menu">
                <a class="menu-item active" onclick="showSection('dashboard')">
                    <span class="menu-item-icon">📊</span>
                    <span class="menu-item-text">Dashboard</span>
                </a>
                <a class="menu-item" onclick="showSection('add-menu')">
                    <span class="menu-item-icon">➕</span>
                    <span class="menu-item-text">Add Menu</span>
                </a>
                <a class="menu-item" href="menulist">
                    <span class="menu-item-icon">📋</span>
                    <span class="menu-item-text">Menu List</span>
                </a>
                <a class="menu-item" href="AdminOrdersServlet">
                    <span class="menu-item-icon">📦</span>
                    <span class="menu-item-text">Orders</span>
                </a>
                <a class="menu-item" onclick="showSection('profile')">
                    <span class="menu-item-icon">👤</span>
                    <span class="menu-item-text">Profile</span>
                </a>
                <a class="menu-item" onclick="showSection('settings')">
                    <span class="menu-item-icon">⚙️</span>
                    <span class="menu-item-text">Settings</span>
                </a>
            </nav>

            <button class="logout-btn" onclick="logout()">🚪 Logout</button>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="top-bar">
                <h1 class="page-title">Admin Dashboard</h1>
                <div class="date-display" id="currentDate"></div>
            </div>

            <!-- Dashboard Section -->
            <section id="dashboard" class="content-section active">
                <h2 class="section-header">Dashboard Overview</h2>
                
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon purple">📋</div>
                        <div class="stat-info">
                            <h3>24</h3>
                            <p>Total Menus</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon green">✅</div>
                        <div class="stat-info">
                            <h3>18</h3>
                            <p>Active Menus</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon orange">📅</div>
                        <div class="stat-info">
                            <h3>7</h3>
                            <p>This Week</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Add Menu Section -->
            <section id="add-menu" class="content-section">
                <h2 class="section-header">Add New Menu</h2>
                
            <%
              String added = request.getParameter("added");
              String error = request.getParameter("error");
            %>

            <% if("success".equals(added)) { %>
           <div class="message success" id="successMsg">
           <span class="close-btn" onclick="this.parentElement.style.display='none'">&times;</span>
           <strong>Success!</strong> Menu added successfully.
           </div>
           <% } %>

           <% if("failed".equals(error)) { %>
           <div class="message error" id="errorMsg">
           <span class="close-btn" onclick="this.parentElement.style.display='none'">&times;</span>
           <strong>Error!</strong> Failed to add record.
           </div>
           <% } %>
                
                <div id="menuAlert" class="alert"></div>

                <form id="addMenuForm" action="admin-add-menu" method="post">
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="menuDate">Menu Date *</label>
                            <input type="date" id="menuDate" name="menuDate" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label for="mealType">Meal Type *</label>
                            <select id="mealType" name="mealType" class="form-control" required>
                                <option value="">Select Meal Type</option>
                                <option value="breakfast">Breakfast</option>
                                <option value="lunch">Lunch</option>
                                <option value="dinner">Dinner</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="dishName">Dish Name *</label>
                            <input type="text" id="dishName" name="dishName" class="form-control"
                                   placeholder="e.g., Chicken Biryani" 
                                   required
                                   minlength="3"
                                   maxlength="50"
                                   pattern="^(?=.*[a-zA-Z])[a-zA-Z\s,]+$"
                                   title="Only letters, commas and spaces allowed, cannot be only spaces & commas">
                        </div>

                        <div class="form-group">
                            <label for="category">Category *</label>
                            <select id="category" name="category" class="form-control" required>
                                <option value="">Select Category</option>
                                <option value="veg">Vegetarian</option>
                                <option value="non-veg">Non-Vegetarian</option>
                                <option value="vegan">Vegan</option>
                            </select>
                        </div>

                        <div class="form-group form-group-full">
                            <label for="description">Description</label>
                            <textarea id="description" name="description" class="form-control" 
                                      placeholder="Brief description of the dish"></textarea>
                        </div>

                        <div class="form-group">
                            <label for="price">Price (₹) *</label>
                           <input type="number" id="price" name="price" class="form-control"
                                  placeholder="0.00" 
                                  step="0.01" 
                                  min="10" 
                                  max="10000"
                                  required>
                        </div>

                        <div class="form-group">
                            <label for="availability">Availability *</label>
                            <select id="availability" name="availability" class="form-control" required>
                                <option value="available">Available</option>
                                <option value="unavailable">Unavailable</option>
                            </select>
                        </div>
                        
                          <div class="form-group">
                            <label for="timeslot">Time Slot *</label>
                            <select id="timeslot" name="timeslot" class="form-control" required>  
                              <option value="7AM-10AM">7AM-10AM</option>
                              <option value="1PM-3PM">1PM-3PM</option>
                              <option value="8PM-11PM">8PM-11PM</option>
                            </select>
                        </div>
                        
                    </div>

                    <div style="margin-top: 25px;">
                        <button type="submit" class="btn-primary">💾 Save Menu</button>
                        <button type="reset" class="btn-secondary">🔄 Reset</button>
                    </div>
                </form>
            </section>
            
            <!-- Menu List Section -->
            <section id="menu-list" class="content-section">
               
            </section>

            <!-- Profile Section -->
            <section id="profile" class="content-section">
                <h2 class="section-header">My Profile</h2>
                <p>Profile management coming soon...</p>
            </section>

            <!-- Settings Section -->
            <section id="settings" class="content-section">
                <h2 class="section-header">Settings</h2>
                <p>Settings panel coming soon...</p>
            </section>
        </main>
    </div>

    <script>
        // Display current date
        function updateDate() {
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const today = new Date();
            document.getElementById('currentDate').textContent = today.toLocaleDateString('en-US', options);
        }

        // Show section
        function showSection(sectionId) {
            // Hide all sections
            const sections = document.querySelectorAll('.content-section');
            sections.forEach(section => section.classList.remove('active'));

            // Remove active from all menu items
            const menuItems = document.querySelectorAll('.menu-item');
            menuItems.forEach(item => item.classList.remove('active'));

            // Show selected section
            document.getElementById(sectionId).classList.add('active');

            // Add active to clicked menu item
            event.target.closest('.menu-item').classList.add('active');
        }
        
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const section = urlParams.get('section');
            if (section) {
                showSection(section);
            }
        };
            
        setTimeout(function() {
            var successMsg = document.getElementById('successMsg');
            var errorMsg = document.getElementById('errorMsg');
            if(successMsg) successMsg.style.display = 'none';
            if(errorMsg) errorMsg.style.display = 'none';
        }, 5000);
       
        // Logout function
        function logout() {
            if(confirm('Are you sure you want to logout?')) {
                window.location.href = '${pageContext.request.contextPath}/admin-logout';
            }
        }

        // Set minimum date to today
        document.getElementById('menuDate').min = new Date().toISOString().split('T')[0];

        // Initialize
        updateDate();
    </script>
</body>
</html>