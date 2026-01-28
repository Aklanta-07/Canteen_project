<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu Management</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
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
            padding: 20px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .header {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .section-header {
            font-size: 2rem;
            color: #333;
            font-weight: 700;
        }

        .add-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: transform 0.2s, box-shadow 0.2s;
            text-decoration: none;
        }
        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .table-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .search-filter {
            padding: 20px 30px;
            border-bottom: 1px solid #e0e0e0;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .search-box {
            flex: 1;
            min-width: 250px;
            position: relative;
        }

        .search-box input {
            width: 100%;
            padding: 12px 15px 12px 45px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .search-box input:focus {
            outline: none;
            border-color: #667eea;
        }

        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }

        .filter-select {
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            background: white;
            transition: border-color 0.3s;
        }

        .filter-select:focus {
            outline: none;
            border-color: #667eea;
        }
        
        a {
          text-decoration: none;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        thead th {
            color: white;
            padding: 18px 15px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        tbody tr {
            border-bottom: 1px solid #f0f0f0;
            transition: background-color 0.2s;
        }

        tbody tr:hover {
            background-color: #f8f9ff;
        }

        tbody td {
            padding: 18px 15px;
            color: #333;
            font-size: 14px;
        }

        .badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
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

        .status-available {
            color: #28a745;
            font-weight: 600;
        }

        .status-unavailable {
            color: #dc3545;
            font-weight: 600;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .btn-edit {
            background: #007bff;
            color: white;
        }

        .btn-edit:hover {
            background: #0056b3;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 123, 255, 0.3);
        }

        .btn-delete {
            background: #dc3545;
            color: white;
        }

        .btn-delete:hover {
            background: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(220, 53, 69, 0.3);
        }

        .price {
            font-weight: 600;
            color: #28a745;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .empty-state i {
            font-size: 64px;
            margin-bottom: 20px;
            opacity: 0.3;
        }
        .alert {
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: slideDown 0.3s ease;
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

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 15px;
            }

            .search-filter {
                flex-direction: column;
            }

            .table-container {
                overflow-x: auto;
            }

            table {
                min-width: 800px;
            }
        }
        
        .search-btn {
            background: #2196F3;
            color: white;
            border: none;
            padding: 12px 25px;
            font-size: 15px;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 8px 0 #1565C0,
                        0 12px 20px rgba(33, 150, 243, 0.4);
            position: relative;
            outline: none;
        }

        .search-btn:hover {
            background: #1E88E5;
            transform: translateY(-3px);
            box-shadow: 0 11px 0 #1565C0,
                        0 15px 25px rgba(33, 150, 243, 0.5);
        }

        .search-btn:active {
            transform: translateY(5px);
            box-shadow: 0 3px 0 #1565C0,
                        0 5px 10px rgba(33, 150, 243, 0.4);
        }

        /* Optional: Add icon */
        .search-btn::before {
            content: '🔍';
            margin-right: 10px;
            font-size: 15px;
        }

        /* Pressed effect */
        .search-btn:focus {
            outline: none;
        }
        
    </style>
</head>
<body>
    <div class="container">
    
    <c:if test="${param.message == 'deleted'}">
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i> Menu item removed successfully!
    </div>
    </c:if>

    <c:if test="${param.error == 'deleteFailed'}">
    <div class="alert alert-error">
        <i class="fas fa-times-circle"></i> Failed to remove menu item. Please try again.
    </div>
    </c:if>
    
    <c:if test="${param.message == 'updated'}">
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i> Menu item update successfully!
    </div>
    </c:if>
    
        <div class="header">
            <h1 class="section-header"><i class="fas fa-utensils"></i> Menu Management</h1>
             <a href="adminDashboard.jsp?section=add-menu" class="add-btn">
                <i class="fas fa-plus"></i> Add New Menu
            </a>
        </div>

    <div class="table-container">
     <form action="menulist" method="post">
            <div class="search-filter">
                <select class="filter-select" name="category">
                    <option value="">All Meal Types</option>
                    <option value="breakfast">Breakfast</option>
                    <option value="lunch">Lunch</option>
                    <option value="dinner">Dinner</option>
                </select>
                <select class="filter-select" name="availability">
                    <option value="">All Status</option>
                    <option value="available">Available</option>
                    <option value="unavailable">Unavailable</option>
                </select>
                
                <button type="submit" class="search-btn">Search</button>
            </div>
    </form>
    
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Date</th>
                            <th>Meal Type</th>
                            <th>Dish Name</th>
                            <th>Price</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty menus}">
                                <tr>
                                    <td colspan="7">
                                        <div class="empty-state">
                                            <i class="fas fa-inbox"></i>
                                            <h3>No menu items found</h3>
                                            <p>Start by adding your first menu item</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${menus}" var="menu" varStatus="index">
                                    <tr>
                                        <td>${menu.menuId}</td>
                                        <td>${menu.menuDate}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${menu.category == 'Breakfast'}">
                                                    <span class="badge badge-breakfast">${menu.category}</span>
                                                </c:when>
                                                <c:when test="${menu.category == 'Lunch'}">
                                                    <span class="badge badge-lunch">${menu.category}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-dinner">${menu.category}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><strong>${menu.itemName}</strong></td>
                                        <td class="price">₹${menu.price}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${menu.availability == 'available'}">
                                                    <span class="status-available">
                                                        <i class="fas fa-check-circle"></i> Available
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-unavailable">
                                                        <i class="fas fa-times-circle"></i> Unavailable
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                 <a href="manage-menu?action=edit&menuId=${menu.menuId}" class="btn btn-edit">
                                                    <i class="fas fa-edit"></i> Edit
                                                 </a>
                                                 <a href="manage-menu?action=delete&menuId=${menu.menuId}" 
                                                    class="btn btn-delete"
                                                    onclick="return confirm('Are you sure you want to delete ${menu.itemName}?')">
                                                    <i class="fas fa-trash"></i> Delete
                                                 </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
        </div>
    </div>
    
    <script>
    setTimeout(function() {
        var alert = document.querySelector('.alert');
        if(alert) {
            alert.style.transition = 'opacity 0.3s';
            alert.style.opacity = '0';
            setTimeout(function() {
                alert.remove();
            }, 300);
        }
    }, 3000); // Hide after 3 seconds
    
    
    
   </script>
    
</body>
</html>
