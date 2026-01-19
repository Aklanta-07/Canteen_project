<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
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
            max-width: 800px;
            margin: 40px auto;
        }

        .profile-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            overflow: hidden;
        }

        .profile-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 40px 30px;
            text-align: center;
            color: white;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 48px;
            font-weight: bold;
            color: #667eea;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .profile-name {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .profile-username {
            font-size: 16px;
            opacity: 0.9;
        }

        .profile-body {
            padding: 40px 30px;
        }

        .info-section {
            margin-bottom: 30px;
        }

        .section-title {
            font-size: 14px;
            text-transform: uppercase;
            color: #667eea;
            font-weight: 600;
            margin-bottom: 20px;
            letter-spacing: 1px;
        }

        .info-grid {
            display: grid;
            gap: 20px;
        }

        .info-item {
            display: flex;
            align-items: flex-start;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 10px;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .info-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .info-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 18px;
            margin-right: 15px;
            flex-shrink: 0;
        }

        .info-content {
            flex: 1;
        }

        .info-label {
            font-size: 12px;
            color: #6c757d;
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            font-size: 16px;
            color: #212529;
            font-weight: 500;
            word-break: break-word;
        }

        .badge {
            display: inline-block;
            padding: 6px 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            text-align: center;
            display: inline-block;
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
            background: #f8f9fa;
            color: #495057;
            border: 2px solid #dee2e6;
        }

        .btn-secondary:hover {
            background: #e9ecef;
            border-color: #adb5bd;
        }

        .error-message {
            background: #fff3cd;
            color: #856404;
            padding: 15px;
            border-radius: 10px;
            margin: 20px 30px;
            border-left: 4px solid #ffc107;
        }

        @media (max-width: 600px) {
            .container {
                margin: 20px auto;
            }

            .profile-header {
                padding: 30px 20px;
            }

            .profile-body {
                padding: 30px 20px;
            }

            .action-buttons {
                flex-direction: column;
            }

            .profile-name {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="profile-card">
            <c:choose>
                <c:when test="${not empty user}">
                    <div class="profile-header">
                        <div class="profile-avatar">
                            ${user.fullName.substring(0, 1).toUpperCase()}
                        </div>
                        <div class="profile-name">${user.fullName}</div>
                        <div class="profile-username">${user.userName}</div>
                    </div>

                    <div class="profile-body">
                        <div class="info-section">
                            <div class="section-title">Personal Information</div>
                            <div class="info-grid">
                                <div class="info-item">
                                    <div class="info-icon">📧</div>
                                    <div class="info-content">
                                        <div class="info-label">Email Address</div>
                                        <div class="info-value">${user.email}</div>
                                    </div>
                                </div>

                                <div class="info-item">
                                    <div class="info-icon">📱</div>
                                    <div class="info-content">
                                        <div class="info-label">Phone Number</div>
                                        <div class="info-value">${user.phoneNo}</div>
                                    </div>
                                </div>

                                <div class="info-item">
                                    <div class="info-icon">👤</div>
                                    <div class="info-content">
                                        <div class="info-label">Account Type</div>
                                        <div class="info-value">
                                            <span class="badge">${user.userType}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="action-buttons">
                            <a href="editProfile.jsp" class="btn btn-primary">Edit Profile</a>
                            <a href="logout" class="btn btn-secondary">Logout</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="error-message">
                        <strong>Error:</strong> Unable to load user profile. Please try logging in again.
                    </div>
                    <div class="profile-body">
                        <div class="action-buttons">
                            <a href="login.jsp" class="btn btn-primary">Go to Login</a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>