<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders - Admin Dashboard</title>
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
            max-width: 1400px;
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

        /* Filter Tabs */
        .filter-tabs {
            background: var(--bg-white);
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: var(--shadow-sm);
            margin: 2rem 0;
            display: flex;
            gap: 0.75rem;
            flex-wrap: wrap;
        }

        .tab {
            padding: 0.625rem 1.25rem;
            border: 2px solid var(--border);
            background: white;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .tab:hover {
            border-color: var(--primary-blue);
            background: rgba(37, 99, 235, 0.05);
        }

        .tab.active {
            background: var(--primary-blue);
            color: white;
            border-color: var(--primary-blue);
        }

        .tab-badge {
            background: rgba(0, 0, 0, 0.1);
            padding: 0.125rem 0.5rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 700;
        }

        .tab.active .tab-badge {
            background: rgba(255, 255, 255, 0.25);
        }

        /* Orders Table */
        .orders-card {
            background: var(--bg-white);
            border-radius: 12px;
            box-shadow: var(--shadow-md);
            overflow: hidden;
        }

        .orders-table {
            width: 100%;
            border-collapse: collapse;
        }

        .orders-table thead {
            background: var(--bg-light);
        }

        .orders-table th {
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            color: var(--text-gray);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid var(--border);
        }

        .orders-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--border);
        }

        .orders-table tbody tr:hover {
            background: var(--bg-light);
        }

        .order-id {
            font-weight: 700;
            color: var(--primary-blue);
            font-family: 'Poppins', sans-serif;
        }

        .customer-email {
            color: var(--text-gray);
            font-size: 0.875rem;
        }

        .order-amount {
            font-weight: 700;
            font-size: 1.125rem;
        }

        /* Status Badge */
        .status-badge {
            padding: 0.375rem 0.875rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            display: inline-block;
        }

        .status-pending { background: #FEF3C7; color: #92400E; }
        .status-confirmed { background: #DBEAFE; color: #1E40AF; }
        .status-preparing { background: #E0E7FF; color: #4338CA; }
        .status-ready { background: #D1FAE5; color: #065F46; }
        .status-completed { background: #D1FAE5; color: #065F46; }
        .status-cancelled { background: #FEE2E2; color: #991B1B; }

        /* Action Buttons */
        .action-btns {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 6px;
            font-size: 0.875rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.375rem;
        }

        .btn-view {
            background: var(--primary-blue);
            color: white;
        }

        .btn-view:hover {
            background: var(--primary-blue-dark);
        }

        .btn-status {
            background: white;
            color: var(--success);
            border: 2px solid var(--success);
        }

        .btn-status:hover {
            background: var(--success);
            color: white;
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

        /* Status Dropdown */
        .status-select {
            padding: 0.375rem 0.75rem;
            border: 2px solid var(--border);
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.875rem;
            cursor: pointer;
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

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal.show {
            display: flex;
        }

        .modal-content {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            max-width: 600px;
            width: 90%;
            max-height: 80vh;
            overflow-y: auto;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--border);
        }

        .modal-title {
            font-family: 'Poppins', sans-serif;
            font-size: 1.5rem;
            font-weight: 700;
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 2rem;
            cursor: pointer;
            color: var(--text-gray);
        }

        .modal-close:hover {
            color: var(--danger);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .orders-table {
                font-size: 0.875rem;
            }

            .orders-table th,
            .orders-table td {
                padding: 0.75rem 0.5rem;
            }

            .action-btns {
                flex-direction: column;
            }

            .filter-tabs {
                gap: 0.5rem;
            }

            .tab {
                padding: 0.5rem 0.875rem;
                font-size: 0.875rem;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="header-content">
                <h1>🛒 Order Management</h1>
                <a href="adminDashboard.jsp" class="back-btn">← Back to Dashboard</a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <div class="container">
        <!-- Filter Tabs -->
        <div class="filter-tabs">
            <a href="AdminOrdersServlet" class="tab ${currentFilter eq 'ALL' ? 'active' : ''}">
                All Orders
                <span class="tab-badge">
                    ${statusCounts['PENDING'] + statusCounts['CONFIRMED'] + statusCounts['PREPARING'] + statusCounts['READY'] + statusCounts['COMPLETED'] + statusCounts['CANCELLED']}
                </span>
            </a>
            <a href="AdminOrdersServlet?status=PENDING" class="tab ${currentFilter eq 'PENDING' ? 'active' : ''}">
                Pending
                <span class="tab-badge">${statusCounts['PENDING']}</span>
            </a>
            <a href="AdminOrdersServlet?status=CONFIRMED" class="tab ${currentFilter eq 'CONFIRMED' ? 'active' : ''}">
                Confirmed
                <span class="tab-badge">${statusCounts['CONFIRMED']}</span>
            </a>
            <a href="AdminOrdersServlet?status=PREPARING" class="tab ${currentFilter eq 'PREPARING' ? 'active' : ''}">
                Preparing
                <span class="tab-badge">${statusCounts['PREPARING']}</span>
            </a>
            <a href="AdminOrdersServlet?status=READY" class="tab ${currentFilter eq 'READY' ? 'active' : ''}">
                Ready
                <span class="tab-badge">${statusCounts['READY']}</span>
            </a>
            <a href="AdminOrdersServlet?status=COMPLETED" class="tab ${currentFilter eq 'COMPLETED' ? 'active' : ''}">
                Completed
                <span class="tab-badge">${statusCounts['COMPLETED']}</span>
            </a>
            <a href="AdminOrdersServlet?status=CANCELLED" class="tab ${currentFilter eq 'CANCELLED' ? 'active' : ''}">
                Cancelled
                <span class="tab-badge">${statusCounts['CANCELLED']}</span>
            </a>
        </div>

        <!-- Orders Table -->
        <div class="orders-card">
            <c:choose>
                <c:when test="${empty orders}">
                    <div class="empty-state">
                        <div class="empty-icon">📭</div>
                        <h2>No Orders Found</h2>
                        <p>There are no orders with the selected filter.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="orders-table">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Customer Email</th>
                                <th>Date & Time</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>
                                        <span class="order-id">#${order.orderId}</span>
                                    </td>
                                    <td>
                                        <span class="customer-email">${order.userEmail}</span>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy" /><br>
                                        <small style="color: var(--text-gray);">
                                            <fmt:formatDate value="${order.orderDate}" pattern="hh:mm a" />
                                        </small>
                                    </td>
                                    <td>
                                        <span class="order-amount">₹<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0" /></span>
                                    </td>
                                    <td>
                                        <span class="status-badge status-${fn:toLowerCase(order.orderStatus)}">
                                            ${order.orderStatus}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="action-btns">
                                            <button class="btn btn-view" onclick="viewOrderDetails(${order.orderId})">
                                                👁️ View
                                            </button>
                                            
                                            <c:choose>
                                                <c:when test="${order.orderStatus eq 'PENDING'}">
                                                    <button class="btn btn-status" onclick="updateStatus(${order.orderId}, 'CONFIRMED')">
                                                        ✓ Confirm
                                                    </button>
                                                </c:when>
                                                <c:when test="${order.orderStatus eq 'CONFIRMED'}">
                                                    <button class="btn btn-status" onclick="updateStatus(${order.orderId}, 'PREPARING')">
                                                        🍳 Prepare
                                                    </button>
                                                </c:when>
                                                <c:when test="${order.orderStatus eq 'PREPARING'}">
                                                    <button class="btn btn-status" onclick="updateStatus(${order.orderId}, 'READY')">
                                                        ✓ Ready
                                                    </button>
                                                </c:when>
                                                <c:when test="${order.orderStatus eq 'READY'}">
                                                    <button class="btn btn-status" onclick="updateStatus(${order.orderId}, 'COMPLETED')">
                                                        ✓ Complete
                                                    </button>
                                                </c:when>
                                            </c:choose>
                                            
                                            <c:if test="${order.orderStatus ne 'COMPLETED' && order.orderStatus ne 'CANCELLED'}">
                                                <button class="btn btn-cancel" onclick="cancelOrder(${order.orderId})">
                                                    ✕ Cancel
                                                </button>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Order Details Modal -->
    <div class="modal" id="orderModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">Order Details</h2>
                <button class="modal-close" onclick="closeModal()">×</button>
            </div>
            <div id="modalBody">
                <!-- Content loaded by JS -->
            </div>
        </div>
    </div>

    <script>
    // ============================================================
    // UPDATE ORDER STATUS
    // ============================================================
    function updateStatus(orderId, newStatus) {
        if (confirm('Change order status to ' + newStatus + '?')) {
            fetch('AdminOrdersServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'action=updateStatus&orderId=' + orderId + '&newStatus=' + newStatus
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('✅ ' + data.message);
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

    // ============================================================
    // CANCEL ORDER
    // ============================================================
    function cancelOrder(orderId) {
        const reason = prompt('Please provide a reason for cancellation:');
        
        if (reason === null) {
            return; // User clicked cancel
        }
        
        if (confirm('Are you sure you want to cancel this order?')) {
            fetch('AdminOrdersServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'action=cancelOrder&orderId=' + orderId + '&reason=' + encodeURIComponent(reason || 'Cancelled by admin')
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('✅ Order cancelled successfully!');
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

    // ============================================================
    // VIEW ORDER DETAILS (MODAL)
    // ============================================================
    function viewOrderDetails(orderId) {
        fetch('AdminOrdersServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'action=getOrderDetails&orderId=' + orderId
        })
        .then(response => response.json())
        .then(data => {
            if (data.order) {
                displayOrderDetails(data.order, data.items);
            } else {
                alert('Failed to load order details');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Failed to load order details');
        });
    }

    // ============================================================
    // DISPLAY ORDER DETAILS IN MODAL
    // ============================================================
   function displayOrderDetails(order, items) {
    const modalBody = document.getElementById('modalBody');
    
    let itemsHtml = '';
    items.forEach(item => {
        itemsHtml += 
            '<tr>' +
                '<td>' + item.itemName + '</td>' +
                '<td>× ' + item.quantity + '</td>' +
                '<td>₹' + item.unitPrice.toFixed(2) + '</td>' +
                '<td><strong>₹' + item.totalPrice.toFixed(2) + '</strong></td>' +
            '</tr>';
    });
    
    // Format date
    const orderDate = new Date(order.orderDate);
    const formattedDate = orderDate.toLocaleString('en-IN', {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    });
    
    modalBody.innerHTML = 
        '<div style="margin-bottom: 1.5rem;">' +
            '<p><strong>Order ID:</strong> #' + order.orderId + '</p>' +
            '<p><strong>Customer:</strong> ' + order.userEmail + '</p>' +
            '<p><strong>Date:</strong> ' + formattedDate + '</p>' +
            '<p><strong>Status:</strong> <span class="status-badge status-' + order.orderStatus.toLowerCase() + '">' + order.orderStatus + '</span></p>' +
            '<p><strong>Payment:</strong> ' + order.paymentStatus + '</p>' +
        '</div>' +
        
        '<h3 style="margin-bottom: 1rem;">Order Items</h3>' +
        '<table style="width: 100%; border-collapse: collapse; margin-bottom: 1.5rem;">' +
            '<thead style="background: var(--bg-light);">' +
                '<tr>' +
                    '<th style="padding: 0.75rem; text-align: left;">Item</th>' +
                    '<th style="padding: 0.75rem; text-align: left;">Qty</th>' +
                    '<th style="padding: 0.75rem; text-align: left;">Price</th>' +
                    '<th style="padding: 0.75rem; text-align: left;">Total</th>' +
                '</tr>' +
            '</thead>' +
            '<tbody>' +
                itemsHtml +
            '</tbody>' +
        '</table>' +
        
        '<div style="border-top: 2px solid var(--border); padding-top: 1rem;">' +
            '<p><strong>Subtotal:</strong> ₹' + order.subtotal.toFixed(2) + '</p>' +
            '<p><strong>Tax (5%):</strong> ₹' + order.taxAmount.toFixed(2) + '</p>' +
            '<p style="font-size: 1.25rem; font-weight: 700; color: var(--primary-blue); margin-top: 0.5rem;">' +
                '<strong>Total:</strong> ₹' + Math.round(order.totalAmount) +
            '</p>' +
        '</div>';
    
    document.getElementById('orderModal').classList.add('show');
}

    // ============================================================
    // CLOSE MODAL
    // ============================================================
    function closeModal() {
        document.getElementById('orderModal').classList.remove('show');
    }

    // Close modal when clicking outside
    document.addEventListener('DOMContentLoaded', function() {
        const modal = document.getElementById('orderModal');
        if (modal) {
            modal.addEventListener('click', function(e) {
                if (e.target === modal) {
                    closeModal();
                }
            });
        }
    });
</script>
</body>
</html>