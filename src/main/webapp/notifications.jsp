<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notifications - Ama Canteen</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary-blue: #5B6FE5;
            --dark-bg: #2D3748;
            --sidebar-bg: #384152;
            --bg-light: #F7FAFC;
            --bg-white: #FFFFFF;
            --text-dark: #1A202C;
            --text-gray: #718096;
            --text-light: #A0AEC0;
            --border: #E2E8F0;
            --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.1);
            --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
            --success: #48BB78;
            --warning: #ED8936;
            --danger: #F56565;
            --info: #4299E1;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg-light);
            color: var(--text-dark);
            min-height: 100vh;
        }

        /* Main Content */
        .main-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Header */
        .page-header {
            background: white;
            padding: 1.5rem 2rem;
            border-radius: 12px;
            box-shadow: var(--shadow-sm);
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .back-btn {
            background: var(--bg-light);
            color: var(--text-dark);
            padding: 0.625rem 1rem;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.875rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .back-btn:hover {
            background: var(--border);
            transform: translateX(-2px);
        }

        .header-title {
            font-family: 'Poppins', sans-serif;
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--text-dark);
        }

        .header-actions {
            display: flex;
            gap: 1rem;
        }

        .btn {
            padding: 0.625rem 1.25rem;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.875rem;
        }

        .btn-primary {
            background: var(--primary-blue);
            color: white;
        }

        .btn-primary:hover {
            background: #4A5FD4;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(91, 111, 229, 0.3);
        }

        .btn-outline {
            background: white;
            color: var(--primary-blue);
            border: 2px solid var(--primary-blue);
        }

        .btn-outline:hover {
            background: var(--primary-blue);
            color: white;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: var(--shadow-sm);
            border-left: 4px solid var(--primary-blue);
        }

        .stat-label {
            color: var(--text-gray);
            font-size: 0.875rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.5rem;
        }

        .stat-value {
            font-family: 'Poppins', sans-serif;
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-blue);
        }

        /* Notifications List */
        .notifications-container {
            background: white;
            border-radius: 12px;
            box-shadow: var(--shadow-md);
            overflow: hidden;
        }

        .notifications-header {
            padding: 1.5rem 2rem;
            border-bottom: 2px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .notifications-title {
            font-family: 'Poppins', sans-serif;
            font-size: 1.25rem;
            font-weight: 600;
        }

        .notification-item {
            padding: 1.5rem 2rem;
            border-bottom: 1px solid var(--border);
            display: flex;
            gap: 1.5rem;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .notification-item:hover {
            background: var(--bg-light);
        }

        .notification-item.unread {
            background: #EBF4FF;
            border-left: 4px solid var(--primary-blue);
        }

        .notification-icon {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            flex-shrink: 0;
        }

        .icon-order-update { background: #E6FFFA; }
        .icon-order-confirmed { background: #E6FFFA; }
        .icon-order-preparing { background: #FFF5F7; }
        .icon-order-ready { background: #F0FFF4; }
        .icon-order-completed { background: #F0FFF4; }
        .icon-order-cancelled { background: #FFF5F5; }

        .notification-content {
            flex: 1;
        }

        .notification-message {
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }

        .notification-meta {
            display: flex;
            align-items: center;
            gap: 1rem;
            font-size: 0.875rem;
            color: var(--text-gray);
        }

        .notification-time {
            display: flex;
            align-items: center;
            gap: 0.375rem;
        }

        .notification-actions {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }

        .action-btn {
            background: none;
            border: none;
            color: var(--text-gray);
            cursor: pointer;
            padding: 0.5rem;
            border-radius: 6px;
            transition: all 0.3s ease;
            font-size: 1.25rem;
        }

        .action-btn:hover {
            background: var(--bg-light);
            color: var(--danger);
        }

        .unread-badge {
            background: var(--primary-blue);
            color: white;
            padding: 0.25rem 0.625rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 700;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
        }

        .empty-icon {
            font-size: 5rem;
            margin-bottom: 1.5rem;
            opacity: 0.3;
        }

        .empty-title {
            font-family: 'Poppins', sans-serif;
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
        }

        .empty-text {
            color: var(--text-gray);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .header-left {
                width: 100%;
            }

            .header-actions {
                width: 100%;
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }

            .notification-item {
                flex-direction: column;
                gap: 1rem;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Main Content -->
    <main class="main-content">
        <!-- Page Header -->
        <div class="page-header">
            <div class="header-left">
                <a href="home.jsp" class="back-btn">
                    ← Back to Home
                </a>
                <h1 class="header-title">🔔 Notifications</h1>
            </div>
            <div class="header-actions">
                <c:if test="${unreadCount > 0}">
                    <button class="btn btn-outline" onclick="markAllAsRead()">
                        ✓ Mark All as Read
                    </button>
                </c:if>
                <button class="btn btn-primary" onclick="window.location.reload()">
                    🔄 Refresh
                </button>
            </div>
        </div>

        <!-- Stats -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-label">Total Notifications</div>
                <div class="stat-value">${not empty notifications ? fn:length(notifications) : 0}</div>
            </div>
            <div class="stat-card" style="border-left-color: var(--warning);">
                <div class="stat-label">Unread</div>
                <div class="stat-value" style="color: var(--warning);">${unreadCount}</div>
            </div>
            <div class="stat-card" style="border-left-color: var(--success);">
                <div class="stat-label">Read</div>
                <div class="stat-value" style="color: var(--success);">
                    ${not empty notifications ? fn:length(notifications) - unreadCount : 0}
                </div>
            </div>
        </div>

        <!-- Notifications List -->
        <div class="notifications-container">
            <div class="notifications-header">
                <h2 class="notifications-title">All Notifications</h2>
            </div>

            <c:choose>
                <c:when test="${empty notifications}">
                    <!-- Empty State -->
                    <div class="empty-state">
                        <div class="empty-icon">📭</div>
                        <h3 class="empty-title">No Notifications Yet</h3>
                        <p class="empty-text">You're all caught up! Notifications will appear here when you have updates.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Notifications List -->
                    <c:forEach var="notif" items="${notifications}">
                        <div class="notification-item ${notif.isRead eq 'N' ? 'unread' : ''}" 
                             onclick="markAsRead(${notif.notificationId})">
                            
                            <div class="notification-icon icon-${fn:toLowerCase(fn:replace(notif.notificationType, '_', '-'))}">
                                <c:choose>
                                    <c:when test="${fn:contains(notif.message, 'confirmed')}">✅</c:when>
                                    <c:when test="${fn:contains(notif.message, 'preparing')}">🍳</c:when>
                                    <c:when test="${fn:contains(notif.message, 'ready')}">✓</c:when>
                                    <c:when test="${fn:contains(notif.message, 'completed')}">😊</c:when>
                                    <c:when test="${fn:contains(notif.message, 'cancelled')}">😔</c:when>
                                    <c:otherwise>📦</c:otherwise>
                                </c:choose>
                            </div>

                            <div class="notification-content">
                                <p class="notification-message">${notif.message}</p>
                                <div class="notification-meta">
                                    <span class="notification-time">
                                        🕐 <fmt:formatDate value="${notif.createdAt}" pattern="dd MMM yyyy, hh:mm a" />
                                    </span>
                                    <c:if test="${notif.isRead eq 'N'}">
                                        <span class="unread-badge">NEW</span>
                                    </c:if>
                                </div>
                            </div>

                            <div class="notification-actions" onclick="event.stopPropagation()">
                                <button class="action-btn" 
                                        onclick="deleteNotification(${notif.notificationId})"
                                        title="Delete">
                                    🗑️
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <script>
        // Mark single notification as read
        function markAsRead(notificationId) {
            fetch('NotificationServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'action=markAsRead&notificationId=' + notificationId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    window.location.reload();
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        }

        // Mark all as read
        function markAllAsRead() {
            if (confirm('Mark all notifications as read?')) {
                fetch('NotificationServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'action=markAllRead'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('✅ All notifications marked as read!');
                        window.location.reload();
                    } else {
                        alert('❌ ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('❌ Network error. Please try again.');
                });
            }
        }

        // Delete notification
        function deleteNotification(notificationId) {
            if (confirm('Delete this notification?')) {
                fetch('NotificationServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'action=deleteNotification&notificationId=' + notificationId
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        window.location.reload();
                    } else {
                        alert('❌ ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('❌ Network error. Please try again.');
                });
            }
        }
    </script>
</body>
</html>