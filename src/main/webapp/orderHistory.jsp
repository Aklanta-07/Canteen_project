<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders - Canteen Management</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary-blue: #2563EB;
            --primary-blue-dark: #1E40AF;
            --bg-light: #F8FAFC;
            --bg-white: #FFFFFF;
            --text-dark: #0F172A;
            --text-gray: #64748B;
            --border: #E2E8F0;
            --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.07);
            --success: #10B981;
            --warning: #F59E0B;
            --danger: #EF4444;
            --info: #3B82F6;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg-light);
            color: var(--text-dark);
            line-height: 1.6;
        }

        /* Header */
        .header {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--primary-blue-dark) 100%);
            color: white;
            padding: 1.5rem 0;
            box-shadow: var(--shadow-md);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1.5rem;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            font-family: 'Poppins', sans-serif;
            font-size: 1.75rem;
            font-weight: 700;
        }

        .back-btn {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            padding: 0.5rem 1.25rem;
            border-radius: 8px;
            text-decoration: none;
            color: white;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .back-btn:hover {
            background: rgba(255, 255, 255, 0.25);
        }

        /* Main Content */
        .main-content {
            padding: 2rem 0;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: var(--bg-white);
            border-radius: 16px;
            box-shadow: var(--shadow-sm);
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
            margin-bottom: 2rem;
        }

        .btn-primary {
            display: inline-block;
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--primary-blue-dark) 100%);
            color: white;
            padding: 0.75rem 2rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(37, 99, 235, 0.4);
        }

        /* Order Cards */
        .orders-grid {
            display: grid;
            gap: 1.5rem;
        }

        .order-card {
            background: var(--bg-white);
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--border);
            transition: all 0.3s ease;
        }

        .order-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border);
        }

        .order-id {
            font-family: 'Poppins', sans-serif;
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-dark);
        }

        .order-date {
            color: var(--text-gray);
            font-size: 0.875rem;
        }

        .status-badge {
            padding: 0.375rem 0.875rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-pending { background: #FEF3C7; color: #92400E; }
        .status-confirmed { background: #DBEAFE; color: #1E40AF; }
        .status-preparing { background: #E0E7FF; color: #4338CA; }
        .status-ready { background: #D1FAE5; color: #065F46; }
        .status-completed { background: #D1FAE5; color: #065F46; }
        .status-cancelled { background: #FEE2E2; color: #991B1B; }

        .order-body {
            margin-bottom: 1rem;
        }

        .order-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .summary-item {
            display: flex;
            flex-direction: column;
        }

        .summary-label {
            font-size: 0.75rem;
            color: var(--text-gray);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.25rem;
        }

        .summary-value {
            font-weight: 600;
            color: var(--text-dark);
        }

        .order-total {
            font-family: 'Poppins', sans-serif;
            font-size: 1.5rem;
            color: var(--primary-blue);
        }

        .order-footer {
            display: flex;
            gap: 0.75rem;
            flex-wrap: wrap;
        }

        .btn {
            padding: 0.5rem 1.25rem;
            border: none;
            border-radius: 6px;
            font-size: 0.875rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-view {
            background: var(--primary-blue);
            color: white;
        }

        .btn-view:hover {
            background: var(--primary-blue-dark);
        }

        .btn-cancel {
            background: white;
            color: var(--danger);
            border: 2px solid var(--danger);
        }

        .btn-cancel:hover {
            background: var(--danger);
            color: white;
        }

        .btn-cancel:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header h1 {
                font-size: 1.25rem;
            }

            .order-header {
                flex-direction: column;
                gap: 0.75rem;
            }

            .order-summary {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="header-content">
                <h1>📦 My Orders</h1>
                <a href="home.jsp" class="back-btn">← Back to Menu</a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <div class="container main-content">
        <c:choose>
            <c:when test="${empty orders}">
                <!-- Empty State -->
                <div class="empty-state">
                    <div class="empty-icon">📭</div>
                    <h2 class="empty-title">No Orders Yet</h2>
                    <p class="empty-text">You haven't placed any orders yet. Start ordering delicious food!</p>
                    <a href="menu.jsp" class="btn-primary">Browse Menu</a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Orders Grid -->
                <div class="orders-grid">
                    <c:forEach var="order" items="${orders}">
                        <div class="order-card">
                            <!-- Order Header -->
                            <div class="order-header">
                                <div>
                                    <div class="order-id">Order #${order.orderId}</div>
                                    <div class="order-date">
                                        <fmt:formatDate value="${order.orderDate}" pattern="EEEE, dd MMM yyyy 'at' hh:mm a" />
                                    </div>
                                </div>
                                <span class="status-badge status-${fn:toLowerCase(order.orderStatus)}">
                                    ${order.orderStatus}
                                </span>
                            </div>

                            <!-- Order Body -->
                            <div class="order-body">
                                <div class="order-summary">
                                    <div class="summary-item">
                                        <span class="summary-label">Subtotal</span>
                                        <span class="summary-value">₹<fmt:formatNumber value="${order.subtotal}" pattern="#,##0.00" /></span>
                                    </div>
                                    <div class="summary-item">
                                        <span class="summary-label">Tax (5%)</span>
                                        <span class="summary-value">₹<fmt:formatNumber value="${order.taxAmount}" pattern="#,##0.00" /></span>
                                    </div>
                                    <div class="summary-item">
                                        <span class="summary-label">Total Amount</span>
                                        <span class="summary-value order-total">₹<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0" /></span>
                                    </div>
                                    <div class="summary-item">
                                        <span class="summary-label">Payment</span>
                                        <span class="summary-value">${order.paymentStatus}</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Order Footer -->
                            <div class="order-footer">
                                <a href="OrderDetails?orderId=${order.orderId}" class="btn btn-view">
                                    👁️ View Details
                                </a>
                                
                                <c:if test="${order.orderStatus eq 'PENDING'}">
                                    <button class="btn btn-cancel" 
                                            onclick="cancelOrder(${order.orderId}, '${order.orderId}')">
                                        ✕ Cancel Order
                                    </button>
                                </c:if>
                                
                                <c:if test="${order.orderStatus eq 'CANCELLED'}">
                                    <span style="color: var(--text-gray); font-size: 0.875rem;">
                                        Cancelled: ${order.cancellationReason}
                                    </span>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        function cancelOrder(orderId, orderNumber) {
            const reason = prompt('Please provide a reason for cancellation (optional):');
            
            if (reason === null) {
                return; // User clicked cancel
            }
            
            if (confirm('Are you sure you want to cancel Order #' + orderNumber + '?')) {
                // Send cancel request to servlet
                fetch('OrderServlet?action=cancelOrder', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'orderId=' + orderId + '&reason=' + encodeURIComponent(reason || 'User requested cancellation')
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('✅ Order cancelled successfully!');
                        window.location.reload(); // Refresh page
                    } else {
                        alert('❌ Failed to cancel order: ' + data.message);
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