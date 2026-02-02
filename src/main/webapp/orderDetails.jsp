<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details - Canteen Management</title>
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
            --danger: #EF4444;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg-light);
            color: var(--text-dark);
            line-height: 1.6;
            padding-bottom: 2rem;
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
            max-width: 1000px;
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

        /* Order Info Card */
        .order-info-card {
            background: var(--bg-white);
            border-radius: 16px;
            padding: 2rem;
            box-shadow: var(--shadow-md);
            margin-bottom: 2rem;
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 2px solid var(--border);
        }

        .order-title {
            font-family: 'Poppins', sans-serif;
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
        }

        .order-date {
            color: var(--text-gray);
            font-size: 0.95rem;
        }

        .status-badge {
            padding: 0.5rem 1.25rem;
            border-radius: 25px;
            font-size: 0.875rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending { background: #FEF3C7; color: #92400E; }
        .status-confirmed { background: #DBEAFE; color: #1E40AF; }
        .status-preparing { background: #E0E7FF; color: #4338CA; }
        .status-ready { background: #D1FAE5; color: #065F46; }
        .status-completed { background: #D1FAE5; color: #065F46; }
        .status-cancelled { background: #FEE2E2; color: #991B1B; }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .info-item {
            display: flex;
            flex-direction: column;
        }

        .info-label {
            font-size: 0.75rem;
            color: var(--text-gray);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        .info-value {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--text-dark);
        }

        /* Order Items Card */
        .items-card {
            background: var(--bg-white);
            border-radius: 16px;
            padding: 2rem;
            box-shadow: var(--shadow-md);
            margin-bottom: 2rem;
        }

        .items-header {
            font-family: 'Poppins', sans-serif;
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--border);
        }

        .items-table {
            width: 100%;
            border-collapse: collapse;
        }

        .items-table thead {
            background: var(--bg-light);
        }

        .items-table th {
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            color: var(--text-gray);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .items-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--border);
        }

        .items-table tbody tr:last-child td {
            border-bottom: none;
        }

        .item-name {
            font-weight: 600;
            color: var(--text-dark);
        }

        .item-quantity {
            color: var(--text-gray);
        }

        .item-price {
            font-weight: 600;
            color: var(--primary-blue);
        }

        /* Summary Card */
        .summary-card {
            background: var(--bg-white);
            border-radius: 16px;
            padding: 2rem;
            box-shadow: var(--shadow-md);
            margin-bottom: 2rem;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 0.75rem 0;
            font-size: 1rem;
        }

        .summary-row.divider {
            border-top: 1px solid var(--border);
            margin-top: 0.5rem;
            padding-top: 1rem;
        }

        .summary-row.total {
            border-top: 2px solid var(--border);
            margin-top: 1rem;
            padding-top: 1.5rem;
            font-size: 1.5rem;
            font-weight: 700;
            font-family: 'Poppins', sans-serif;
        }

        .summary-row.total .amount {
            color: var(--primary-blue);
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .btn {
            padding: 0.875rem 2rem;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            font-family: 'Poppins', sans-serif;
        }

        .btn-cancel {
            background: white;
            color: var(--danger);
            border: 2px solid var(--danger);
        }

        .btn-cancel:hover:not(:disabled) {
            background: var(--danger);
            color: white;
        }

        .btn-cancel:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .btn-back {
            background: var(--primary-blue);
            color: white;
        }

        .btn-back:hover {
            background: var(--primary-blue-dark);
        }

        /* Cancelled Message */
        .cancelled-message {
            background: #FEE2E2;
            border-left: 4px solid var(--danger);
            padding: 1rem 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
        }

        .cancelled-message strong {
            color: var(--danger);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header h1 {
                font-size: 1.25rem;
            }

            .order-header {
                flex-direction: column;
                gap: 1rem;
            }

            .order-title {
                font-size: 1.5rem;
            }

            .items-table {
                font-size: 0.875rem;
            }

            .items-table th,
            .items-table td {
                padding: 0.75rem 0.5rem;
            }

            .info-grid {
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
                <h1>📋 Order Details</h1>
                <a href="MyOrdersServlet" class="back-btn">← Back to Orders</a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <div class="container main-content">
        <c:choose>
            <c:when test="${empty order}">
                <!-- Order Not Found -->
                <div class="order-info-card">
                    <h2>Order Not Found</h2>
                    <p>The order you're looking for doesn't exist or you don't have permission to view it.</p>
                    <a href="MyOrdersServlet" class="btn btn-back">← Back to Orders</a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Order Info Card -->
                <div class="order-info-card">
                    <div class="order-header">
                        <div>
                            <h1 class="order-title">Order #${order.orderId}</h1>
                            <p class="order-date">
                                Placed on <fmt:formatDate value="${order.orderDate}" pattern="EEEE, dd MMMM yyyy 'at' hh:mm a" />
                            </p>
                        </div>
                        <span class="status-badge status-${fn:toLowerCase(order.orderStatus)}">
                            ${order.orderStatus}
                        </span>
                    </div>

                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">Customer Email</span>
                            <span class="info-value">${order.userEmail}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Payment Status</span>
                            <span class="info-value">${order.paymentStatus}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Order Status</span>
                            <span class="info-value">${order.orderStatus}</span>
                        </div>
                    </div>

                    <!-- Cancellation Message -->
                    <c:if test="${order.orderStatus eq 'CANCELLED'}">
                        <div class="cancelled-message">
                            <strong>Order Cancelled</strong><br>
                            Reason: ${order.cancellationReason}<br>
                            <c:if test="${not empty order.cancelledAt}">
                                Cancelled on: <fmt:formatDate value="${order.cancelledAt}" pattern="dd MMM yyyy 'at' hh:mm a" />
                            </c:if>
                        </div>
                    </c:if>
                </div>

                <!-- Order Items -->
                <div class="items-card">
                    <h2 class="items-header">Order Items</h2>
                    <table class="items-table">
                        <thead>
                            <tr>
                                <th>Item Name</th>
                                <th>Quantity</th>
                                <th>Unit Price</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${items}">
                                <tr>
                                    <td class="item-name">${item.itemName}</td>
                                    <td class="item-quantity">× ${item.quantity}</td>
                                    <td>₹<fmt:formatNumber value="${item.unitPrice}" pattern="#,##0.00" /></td>
                                    <td class="item-price">₹<fmt:formatNumber value="${item.totalPrice}" pattern="#,##0.00" /></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Order Summary -->
                <div class="summary-card">
                    <div class="summary-row">
                        <span>Subtotal:</span>
                        <span>₹<fmt:formatNumber value="${order.subtotal}" pattern="#,##0.00" /></span>
                    </div>
                    <div class="summary-row">
                        <span>Tax (5%):</span>
                        <span>₹<fmt:formatNumber value="${order.taxAmount}" pattern="#,##0.00" /></span>
                    </div>
                    <div class="summary-row total">
                        <span>Total Amount:</span>
                        <span class="amount">₹<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0" /></span>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="action-buttons">
                    <a href="MyOrdersServlet" class="btn btn-back">← Back to Orders</a>
                    
                    <c:if test="${order.orderStatus eq 'PENDING'}">
                        <button class="btn btn-cancel" onclick="cancelOrder(${order.orderId})">
                            ✕ Cancel This Order
                        </button>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        function cancelOrder(orderId) {
            const reason = prompt('Please provide a reason for cancellation (optional):');
            
            if (reason === null) {
                return; // User clicked cancel
            }
            
            if (confirm('Are you sure you want to cancel this order?')) {
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
                        window.location.reload();
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