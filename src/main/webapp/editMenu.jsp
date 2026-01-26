<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Menu Item</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            max-width: 700px;
            width: 100%;
        }

        .form-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            overflow: hidden;
        }

        .form-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 30px;
            color: white;
            text-align: center;
        }

        .form-header h1 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .form-header p {
            opacity: 0.9;
            font-size: 14px;
        }

        .form-body {
            padding: 40px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .form-group label .required {
            color: #dc3545;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
            font-family: inherit;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-control:disabled {
            background-color: #f5f5f5;
            cursor: not-allowed;
        }

        select.form-control {
            cursor: pointer;
        }

        .input-icon {
            position: relative;
        }

        .input-icon i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }

        .input-icon .form-control {
            padding-left: 45px;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 35px;
        }

        .btn {
            flex: 1;
            padding: 14px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(108, 117, 125, 0.3);
        }

        .alert {
            padding: 15px 20px;
            margin-bottom: 25px;
            border-radius: 8px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }

        .info-box {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            border-left: 4px solid #667eea;
        }

        .info-box p {
            margin: 5px 0;
            color: #666;
            font-size: 14px;
        }

        .info-box strong {
            color: #333;
        }

        @media (max-width: 768px) {
            .form-body {
                padding: 25px;
            }

            .form-actions {
                flex-direction: column;
            }

            .form-header h1 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-card">
            <div class="form-header">
                <h1><i class="fas fa-edit"></i> Edit Menu Item</h1>
                <p>Update the details of your menu item</p>
            </div>

            <div class="form-body">
                <c:if test="${param.error == 'updateFailed'}">
                    <div class="alert alert-info">
                        <i class="fas fa-exclamation-circle"></i> Failed to update menu item. Please try again.
                    </div>
                </c:if>

                <div class="info-box">
                    <p><strong>Menu ID:</strong> #${menu.menuId}</p>
                    <p><strong>Current Item:</strong> ${menu.itemName}</p>
                </div>

                <form action="manage-menu" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="menuId" value="${menu.menuId}">

                    <div class="form-group">
                        <label for="menuDate">
                            Menu Date <span class="required">*</span>
                        </label>
                        <div class="input-icon">
                            <i class="fas fa-calendar"></i>
                            <input type="date" 
                                   id="menuDate" 
                                   name="menuDate" 
                                   class="form-control" 
                                   value="${menu.menuDate}" 
                                   required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="category">
                            Meal Type <span class="required">*</span>
                        </label>
                        <div class="input-icon">
                            <i class="fas fa-utensils"></i>
                            <select id="category" 
                                    name="category" 
                                    class="form-control" 
                                    required>
                                <option value="">Select Meal Type</option>
                                <option value="breakfast" ${menu.category == 'breakfast' ? 'selected' : ''}>Breakfast</option>
                                <option value="lunch" ${menu.category == 'lunch' ? 'selected' : ''}>Lunch</option>
                                <option value="dinner" ${menu.category == 'dinner' ? 'selected' : ''}>Dinner</option>
          
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="itemName">
                            Dish Name <span class="required">*</span>
                        </label>
                        <div class="input-icon">
                            <i class="fas fa-drumstick-bite"></i>
                            <input type="text" 
                                   id="itemName" 
                                   name="itemName" 
                                   class="form-control" 
                                   value="${menu.itemName}" 
                                   placeholder="Enter dish name"
                                   minlength="3"
                                   maxlength="50"
                                   pattern="^(?=.*[a-zA-Z])[a-zA-Z\s,]+$"
                                   title="Only letters, commas and spaces allowed, cannot be only spaces & commas"
                                   required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="price">
                            Price (₹) <span class="required">*</span>
                        </label>
                        <div class="input-icon">
                            <i class="fas fa-rupee-sign"></i>
                            <input type="number" 
                                   id="price" 
                                   name="price" 
                                   class="form-control" 
                                   value="${menu.price}" 
                                   step="0.01" 
                                   min="10" 
                                   max="10000"
                                   placeholder="0.00"
                                   required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="availability">
                            Availability Status <span class="required">*</span>
                        </label>
                        <div class="input-icon">
                            <i class="fas fa-toggle-on"></i>
                            <select id="availability" 
                                    name="availability" 
                                    class="form-control" 
                                    required>
                                <option value="">Select Status</option>
                                <option value="available" ${menu.availability == 'available' ? 'selected' : ''}>Available</option>
                                <option value="unavailable" ${menu.availability == 'unavailable' ? 'selected' : ''}>Unavailable</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Update Menu
                        </button>
                        <a href="menulist" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Set max date to prevent future dates (optional)
        document.getElementById('menuDate').max = new Date().toISOString().split('T')[0];
    </script>
</body>
</html>