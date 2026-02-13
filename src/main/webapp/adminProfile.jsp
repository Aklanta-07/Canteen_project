<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="in.dto.AdminDTO" %>
<%
    AdminDTO admin = (AdminDTO) request.getAttribute("admin");
    if(admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Profile</title>
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

        .profile-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            max-width: 600px;
            width: 100%;
            overflow: hidden;
        }

        .profile-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: white;
            margin: 0 auto 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            font-weight: bold;
            color: #667eea;
            border: 5px solid rgba(255, 255, 255, 0.3);
        }

        .profile-header h1 {
            font-size: 28px;
            margin-bottom: 5px;
        }

        .profile-header .role {
            font-size: 16px;
            opacity: 0.9;
            font-weight: 300;
        }

        .profile-body {
            padding: 40px 30px;
        }

        .profile-item {
            margin-bottom: 25px;
            padding-bottom: 20px;
            border-bottom: 1px solid #e0e0e0;
        }

        .profile-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .profile-item label {
            display: block;
            font-size: 12px;
            color: #999;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .profile-item .value {
            font-size: 18px;
            color: #333;
            font-weight: 500;
        }

        .profile-actions {
            padding: 20px 30px 30px;
            display: flex;
            gap: 15px;
            justify-content: center;
        }

        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            font-weight: 600;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #f5f5f5;
            color: #666;
        }

        .btn-secondary:hover {
            background: #e0e0e0;
        }

        @media (max-width: 600px) {
            .profile-header {
                padding: 30px 20px;
            }

            .profile-body {
                padding: 30px 20px;
            }

            .profile-actions {
                flex-direction: column;
                padding: 20px;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <div class="profile-header">
            <div class="profile-avatar">
                <%= admin.getFullName() != null && admin.getFullName().length() > 0 
                    ? admin.getFullName().substring(0, 1).toUpperCase() 
                    : "A" %>
            </div>
            <h1><%= admin.getFullName() != null ? admin.getFullName() : "Admin" %></h1>
            <div class="role"><%= admin.getRole() != null ? admin.getRole() : "Administrator" %></div>
        </div>

        <div class="profile-body">
            <div class="profile-item">
                <label>Username</label>
                <div class="value"><%= admin.getUserName() != null ? admin.getUserName() : "N/A" %></div>
            </div>

            <div class="profile-item">
                <label>Email Address</label>
                <div class="value"><%= admin.getEmail() != null ? admin.getEmail() : "N/A" %></div>
            </div>

            <div class="profile-item">
                <label>Phone Number</label>
                <div class="value"><%= admin.getPhoneNo() != 0 ? admin.getPhoneNo() : "N/A" %></div>
            </div>

            <div class="profile-item">
                <label>Full Name</label>
                <div class="value"><%= admin.getFullName() != null ? admin.getFullName() : "N/A" %></div>
            </div>
        </div>

        <div class="profile-actions">
            <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
            <a href="editAdminProfile.jsp" class="btn btn-primary">Edit Profile</a>
        </div>
    </div>
</body>
</html>