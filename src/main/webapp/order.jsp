<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Place Order - Canteen Management</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&family=Inter:wght@400;500;600&display=swap"
	rel="stylesheet">
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

:root {
	--primary-blue: #2563EB;
	--primary-blue-dark: #1E40AF;
	--accent-orange: #FB923C;
	--bg-light: #F8FAFC;
	--bg-white: #FFFFFF;
	--text-dark: #0F172A;
	--text-gray: #64748B;
	--text-light: #94A3B8;
	--border: #E2E8F0;
	--shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.05);
	--shadow-md: 0 4px 6px rgba(0, 0, 0, 0.07);
	--shadow-lg: 0 10px 25px rgba(0, 0, 0, 0.1);
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
	background: linear-gradient(135deg, var(--primary-blue) 0%,
		var(--primary-blue-dark) 100%);
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

.header-info {
	display: flex;
	align-items: center;
	gap: 1.5rem;
}

.date-badge {
	background: rgba(255, 255, 255, 0.15);
	backdrop-filter: blur(10px);
	padding: 0.5rem 1.25rem;
	border-radius: 25px;
	font-size: 0.875rem;
	font-weight: 500;
}

/* Main Layout */
.main-layout {
	display: grid;
	grid-template-columns: 1fr 380px;
	gap: 2rem;
	margin-top: 2rem;
}

/* Menu Grid */
.menu-section h2 {
	font-family: 'Poppins', sans-serif;
	font-size: 1.5rem;
	font-weight: 600;
	color: var(--text-dark);
	margin-bottom: 1.5rem;
}

.menu-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
	gap: 1.5rem;
}

/* Menu Card */
.menu-card {
	background: var(--bg-white);
	border-radius: 16px;
	padding: 1.75rem;
	box-shadow: var(--shadow-sm);
	border: 1px solid var(--border);
	transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
	display: flex;
	flex-direction: column;
	position: relative;
	overflow: hidden;
}

.menu-card::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	height: 4px;
	background: linear-gradient(90deg, var(--primary-blue) 0%,
		var(--accent-orange) 100%);
	transform: scaleX(0);
	transition: transform 0.3s ease;
}

.menu-card:hover {
	transform: translateY(-4px);
	box-shadow: var(--shadow-lg);
	border-color: var(--primary-blue);
}

.menu-card:hover::before {
	transform: scaleX(1);
}

.card-icon {
	width: 64px;
	height: 64px;
	border-radius: 12px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 2rem;
	margin-bottom: 1rem;
	align-self: center;
}

.icon-breakfast {
	background: linear-gradient(135deg, #FEF3C7 0%, #FDE68A 100%);
}

.icon-lunch {
	background: linear-gradient(135deg, #DBEAFE 0%, #BFDBFE 100%);
}

.icon-dinner {
	background: linear-gradient(135deg, #FECACA 0%, #FCA5A5 100%);
}

.icon-snacks {
	background: linear-gradient(135deg, #D1FAE5 0%, #A7F3D0 100%);
}

.card-title {
	font-family: 'Poppins', sans-serif;
	font-size: 1.25rem;
	font-weight: 600;
	color: var(--text-dark);
	margin-bottom: 0.5rem;
	text-align: center;
}

.card-description {
	color: var(--text-gray);
	font-size: 0.875rem;
	text-align: center;
	margin-bottom: 1rem;
	flex-grow: 1;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
}

.card-price {
	font-family: 'Poppins', sans-serif;
	font-size: 1.75rem;
	font-weight: 700;
	color: var(--primary-blue);
	text-align: center;
	margin-bottom: 0.75rem;
}

.card-time-badge {
	display: inline-block;
	padding: 0.375rem 1rem;
	border-radius: 20px;
	font-size: 0.75rem;
	font-weight: 600;
	text-align: center;
	margin-bottom: 1rem;
	align-self: center;
}

.time-breakfast {
	background: #FEF3C7;
	color: #92400E;
}

.time-lunch {
	background: #DBEAFE;
	color: #1E40AF;
}

.time-dinner {
	background: #FECACA;
	color: #991B1B;
}

.time-snacks {
	background: #D1FAE5;
	color: #065F46;
}

.availability-info {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 0.5rem;
	margin-bottom: 1rem;
	font-size: 0.875rem;
	color: var(--text-gray);
}

.availability-dot {
	width: 8px;
	height: 8px;
	border-radius: 50%;
	background: var(--success);
	animation: pulse 2s ease-in-out infinite;
}

@
keyframes pulse { 0%, 100% {
	opacity: 1;
	transform: scale(1);
}

50




%
{
opacity




:




0


.6


;
transform




:




scale


(




1


.1




)


;
}
}

/* Quantity Control */
.quantity-control {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 1rem;
	margin-top: auto;
}

.qty-btn {
	width: 36px;
	height: 36px;
	border: 2px solid var(--primary-blue);
	background: var(--bg-white);
	color: var(--primary-blue);
	border-radius: 8px;
	font-size: 1.25rem;
	font-weight: 700;
	cursor: pointer;
	transition: all 0.2s ease;
	display: flex;
	align-items: center;
	justify-content: center;
	user-select: none;
}

.qty-btn:hover:not(:disabled) {
	background: var(--primary-blue);
	color: white;
	transform: scale(1.1);
}

.qty-btn:active:not(:disabled) {
	transform: scale(0.95);
}

.qty-btn:disabled {
	opacity: 0.3;
	cursor: not-allowed;
}

.qty-display {
	min-width: 45px;
	text-align: center;
	font-size: 1.125rem;
	font-weight: 700;
	color: var(--text-dark);
	background: var(--bg-light);
	padding: 0.5rem;
	border-radius: 8px;
}

/* Order Summary Sidebar */
.order-summary {
	position: sticky;
	top: calc(100px + 2rem);
	height: fit-content;
}

.summary-card {
	background: var(--bg-white);
	border-radius: 16px;
	padding: 2rem;
	box-shadow: var(--shadow-md);
	border: 1px solid var(--border);
}

.summary-header {
	font-family: 'Poppins', sans-serif;
	font-size: 1.25rem;
	font-weight: 600;
	color: var(--text-dark);
	margin-bottom: 1.5rem;
	padding-bottom: 1rem;
	border-bottom: 2px solid var(--border);
}

.summary-content {
	max-height: 400px;
	overflow-y: auto;
	margin-bottom: 1.5rem;
}

.summary-content::-webkit-scrollbar {
	width: 6px;
}

.summary-content::-webkit-scrollbar-track {
	background: var(--bg-light);
	border-radius: 10px;
}

.summary-content::-webkit-scrollbar-thumb {
	background: var(--primary-blue);
	border-radius: 10px;
}

.cart-item {
	padding: 1rem;
	background: var(--bg-light);
	border-radius: 10px;
	margin-bottom: 0.75rem;
}

.cart-item-header {
	display: flex;
	justify-content: space-between;
	align-items: start;
	margin-bottom: 0.5rem;
}

.cart-item-name {
	font-weight: 600;
	color: var(--text-dark);
	font-size: 0.9rem;
}

.cart-item-remove {
	background: none;
	border: none;
	color: var(--danger);
	cursor: pointer;
	font-size: 1.25rem;
	padding: 0;
	width: 24px;
	height: 24px;
	display: flex;
	align-items: center;
	justify-content: center;
	border-radius: 4px;
	transition: all 0.2s ease;
}

.cart-item-remove:hover {
	background: rgba(239, 68, 68, 0.1);
}

.cart-item-details {
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-size: 0.875rem;
}

.cart-item-qty {
	color: var(--text-gray);
}

.cart-item-price {
	font-weight: 700;
	color: var(--primary-blue);
}

.cart-empty {
	text-align: center;
	padding: 3rem 1rem;
	color: var(--text-light);
}

.cart-empty-icon {
	font-size: 4rem;
	margin-bottom: 1rem;
	opacity: 0.3;
}

.summary-totals {
	padding-top: 1rem;
	border-top: 2px solid var(--border);
}

.summary-row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 0.75rem;
	font-size: 0.95rem;
}

.summary-row.total {
	margin-top: 0.75rem;
	padding-top: 0.75rem;
	border-top: 1px solid var(--border);
	font-size: 1.25rem;
	font-weight: 700;
}

.summary-row.total .amount {
	color: var(--primary-blue);
	font-family: 'Poppins', sans-serif;
	font-size: 1.75rem;
}

/* Buttons */
.btn {
	width: 100%;
	padding: 1rem;
	border: none;
	border-radius: 10px;
	font-size: 1rem;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s ease;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	font-family: 'Poppins', sans-serif;
}

.btn-primary {
	background: linear-gradient(135deg, var(--primary-blue) 0%,
		var(--primary-blue-dark) 100%);
	color: white;
	box-shadow: 0 4px 14px rgba(37, 99, 235, 0.3);
	margin-bottom: 0.75rem;
}

.btn-primary:hover:not(:disabled) {
	transform: translateY(-2px);
	box-shadow: 0 6px 20px rgba(37, 99, 235, 0.4);
}

.btn-primary:active:not(:disabled) {
	transform: translateY(0);
}

.btn-primary:disabled {
	opacity: 0.5;
	cursor: not-allowed;
}

.btn-secondary {
	background: white;
	color: var(--primary-blue);
	border: 2px solid var(--primary-blue);
}

.btn-secondary:hover:not(:disabled) {
	background: var(--bg-light);
}

.btn-secondary:disabled {
	opacity: 0.5;
	cursor: not-allowed;
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

/* Toast Notification */
.toast {
	position: fixed;
	bottom: 2rem;
	right: 2rem;
	background: var(--success);
	color: white;
	padding: 1rem 1.5rem;
	border-radius: 10px;
	box-shadow: var(--shadow-lg);
	display: flex;
	align-items: center;
	gap: 0.75rem;
	transform: translateX(400px);
	transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
	z-index: 1000;
	font-weight: 500;
}

.toast.show {
	transform: translateX(0);
}

.toast-icon {
	font-size: 1.5rem;
}

/* Responsive */
@media ( max-width : 1200px) {
	.main-layout {
		grid-template-columns: 1fr;
	}
	.order-summary {
		position: static;
	}
	.menu-grid {
		grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
	}
}

@media ( max-width : 768px) {
	.container {
		padding: 0 1rem;
	}
	.header h1 {
		font-size: 1.25rem;
	}
	.date-badge {
		font-size: 0.75rem;
		padding: 0.375rem 0.875rem;
	}
	.menu-grid {
		grid-template-columns: 1fr;
		gap: 1rem;
	}
	.summary-card {
		padding: 1.5rem;
	}
	.toast {
		bottom: 1rem;
		right: 1rem;
		left: 1rem;
	}
}

/* Loading Animation */
@
keyframes fadeIn {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.menu-card {
	animation: fadeIn 0.5s ease-out;
}

.menu-card:nth-child(1) {
	animation-delay: 0.05s;
}

.menu-card:nth-child(2) {
	animation-delay: 0.1s;
}

.menu-card:nth-child(3) {
	animation-delay: 0.15s;
}

.menu-card:nth-child(4) {
	animation-delay: 0.2s;
}

.menu-card:nth-child(5) {
	animation-delay: 0.25s;
}

.menu-card:nth-child(6) {
	animation-delay: 0.3s;
}
</style>
</head>
<body>
	<!-- Header -->
	<header class="header">
		<div class="container">
			<div class="header-content">
				<h1>🍽️ Place Your Order</h1>
				<div class="header-info">
					<div class="date-badge">
						📅
						<jsp:useBean id="now" class="java.util.Date" />
						<fmt:formatDate value="${now}" pattern="EEEE, MMMM dd, yyyy" />
					</div>
				</div>
			</div>
		</div>
	</header>

	<!-- Main Content -->
	<div class="container">
		<div class="main-layout">
			<!-- Menu Section -->
			<div class="menu-section">
				<h2>Today's Menu</h2>

				<c:choose>
					<c:when test="${empty menuItems}">
						<!-- Empty State -->
						<div class="empty-state">
							<div class="empty-icon">😔</div>
							<h3 class="empty-title">No Items Available</h3>
							<p class="empty-text">Sorry, there are no menu items
								available today. Please check back later!</p>
						</div>
					</c:when>
					<c:otherwise>
						<!-- Menu Grid -->
						<div class="menu-grid">
							<c:forEach var="item" items="${menuItems}" varStatus="status">
								<div class="menu-card">
									<!-- Icon based on category -->
									<div
										class="card-icon 
                                        <c:choose>
                                            <c:when test="${item.category eq 'breakfast'}">icon-breakfast</c:when>
                                            <c:when test="${item.category eq 'lunch'}">icon-lunch</c:when>
                                            <c:when test="${item.category eq 'dinner'}">icon-dinner</c:when>
                                            <c:otherwise>icon-main</c:otherwise>
                                        </c:choose>">
										<c:choose>
											<c:when test="${item.category eq 'breakfast'}">☕</c:when>
											<c:when test="${item.category eq 'lunch'}">🍔</c:when>
											<c:when test="${item.category eq 'dinner'}">🍕</c:when>

											<c:otherwise>🍽️</c:otherwise>
										</c:choose>
									</div>

									<h3 class="card-title">${item.itemName}</h3>

									<p class="card-description">${item.category.toUpperCase()}</p>

									<div class="card-price">
										₹
										<fmt:formatNumber value="${item.price}" pattern="#,##0" />
									</div>

									<!-- Time Badge (You can add availableTime field to your MenuItem model) -->
									<c:if test="${not empty item.timeSlot}">
										<span
											class="card-time-badge 
                                            <c:choose>
                                                <c:when test="${item.category eq 'breakfast'}">time-breakfast</c:when>
                                                <c:when test="${item.category eq 'lunch'}">time-lunch</c:when>
                                                <c:when test="${item.category eq 'dinner'}">time-dinner</c:when>
                                                <c:otherwise>time-snacks</c:otherwise>
                                            </c:choose>">
											${item.timeSlot} </span>
									</c:if>

									<div class="availability-info">
										<span class="availability-dot"></span> <span>${item.availability}</span>
									</div>

									<!-- Quantity Control -->
									<div class="quantity-control">
										<button class="qty-btn"
											onclick="decreaseQuantity(${item.menuId})"
											id="decrease-${item.menuId}" disabled>−</button>
										<span class="qty-display" id="qty-${item.menuId}">0</span>
										<button class="qty-btn"
											onclick="increaseQuantity(${item.menuId}, ${item.stockQuantity}, ${item.price})"
											id="increase-${item.menuId}" data-name="${item.itemName}">+</button>
									</div>
								</div>
							</c:forEach>
						</div>
					</c:otherwise>
				</c:choose>
			</div>

			<!-- Order Summary Sidebar -->
			<aside class="order-summary">
				<div class="summary-card">
					<h3 class="summary-header">Order Summary</h3>

					<!-- Cart Items -->
					<div class="summary-content" id="cartItemsContainer">
						<div class="cart-empty">
							<div class="cart-empty-icon">🛒</div>
							<p>
								Your cart is empty<br>Add items to get started!
							</p>
						</div>
					</div>

					<!-- Totals -->
					<div class="summary-totals" id="summaryTotals"
						style="display: none;">
						<div class="summary-row">
							<span>Subtotal:</span> <span id="subtotal">₹0.00</span>
						</div>
						<div class="summary-row">
							<span>Tax (5%):</span> <span id="tax">₹0.00</span>
						</div>
						<div class="summary-row total">
							<span>Total Amount:</span> <span class="amount" id="total">₹0</span>
						</div>
					</div>

					<!-- Action Buttons -->
					<button class="btn btn-primary" id="confirmOrderBtn" disabled>
						✓ Confirm Order</button>
					<button class="btn btn-secondary" id="clearCartBtn" disabled>
						Clear Cart</button>
				</div>
			</aside>
		</div>
	</div>

	<!-- Toast Notification -->
	<div class="toast" id="toast">
		<span class="toast-icon">✓</span> <span id="toastMessage">Item
			added to cart!</span>
	</div>

	<script>
        // Cart state management
        let cart = [];
        const TAX_RATE = 0.05;

        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            // Event listeners for main buttons
            document.getElementById('confirmOrderBtn').addEventListener('click', confirmOrder);
            document.getElementById('clearCartBtn').addEventListener('click', clearCart);
        });

        // Increase quantity
        function increaseQuantity(itemId, maxQuantity, price) {
            const qtyDisplay = document.getElementById('qty-' + itemId);
            const decreaseBtn = document.getElementById('decrease-' + itemId);
            const increaseBtn = document.getElementById('increase-' + itemId);
            
            // Get item name from data attribute
            const name = increaseBtn.getAttribute('data-name');
            
            let currentQty = parseInt(qtyDisplay.textContent);
            
            if (currentQty < maxQuantity) {
                currentQty++;
                qtyDisplay.textContent = currentQty;
                
                // Enable decrease button
                decreaseBtn.disabled = false;
                
                // Disable increase button if max reached
                if (currentQty >= maxQuantity) {
                    increaseBtn.disabled = true;
                }
                
                // Update cart
                updateCart(itemId, name, price, currentQty);
                showToast(name + ' added to cart!');
            }
        }

        // Decrease quantity
        function decreaseQuantity(itemId) {
            const qtyDisplay = document.getElementById('qty-' + itemId);
            const decreaseBtn = document.getElementById('decrease-' + itemId);
            const increaseBtn = document.getElementById('increase-' + itemId);
            
            let currentQty = parseInt(qtyDisplay.textContent);
            
            if (currentQty > 0) {
                currentQty--;
                qtyDisplay.textContent = currentQty;
                
                // Enable increase button
                increaseBtn.disabled = false;
                
                // Disable decrease button if zero
                if (currentQty === 0) {
                    decreaseBtn.disabled = true;
                }
                
                // Update cart
                const cartItem = cart.find(item => item.id === itemId);
                if (cartItem) {
                    updateCart(itemId, cartItem.name, cartItem.price, currentQty);
                }
            }
        }

        // Update cart
        function updateCart(itemId, name, price, quantity) {
            if (quantity === 0) {
                cart = cart.filter(item => item.id !== itemId);
            } else {
                const existingItem = cart.find(item => item.id === itemId);
                if (existingItem) {
                    existingItem.quantity = quantity;
                } else {
                    cart.push({ id: itemId, name, price, quantity });
                }
            }
            
            renderCart();
        }

        // Render cart
        function renderCart() {
            const cartItemsContainer = document.getElementById('cartItemsContainer');
            const summaryTotals = document.getElementById('summaryTotals');
            const confirmBtn = document.getElementById('confirmOrderBtn');
            const clearBtn = document.getElementById('clearCartBtn');
            
            if (cart.length === 0) {
                cartItemsContainer.innerHTML = `
                    <div class="cart-empty">
                        <div class="cart-empty-icon">🛒</div>
                        <p>Your cart is empty<br>Add items to get started!</p>
                    </div>
                `;
                summaryTotals.style.display = 'none';
                confirmBtn.disabled = true;
                clearBtn.disabled = true;
                return;
            }
            
            // Render cart items
            cartItemsContainer.innerHTML = cart.map(item => `
                <div class="cart-item">
                    <div class="cart-item-header">
                        <span class="cart-item-name">\${item.name}</span>
                        <button class="cart-item-remove" onclick="removeFromCart(\${item.id})" title="Remove">×</button>
                    </div>
                    <div class="cart-item-details">
                        <span class="cart-item-qty">Qty: \${item.quantity}</span>
                        <span class="cart-item-price">₹\${(item.price * item.quantity).toFixed(2)}</span>
                    </div>
                </div>
            `).join('');
            
            // Calculate totals
            const subtotal = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
            const tax = subtotal * TAX_RATE;
            const total = subtotal + tax;
            
            // Update summary
            document.getElementById('subtotal').textContent = '₹' + subtotal.toFixed(2);
            document.getElementById('tax').textContent = '₹' + tax.toFixed(2);
            document.getElementById('total').textContent = '₹' + Math.round(total);
            
            // Show summary and enable buttons
            summaryTotals.style.display = 'block';
            confirmBtn.disabled = false;
            clearBtn.disabled = false;
        }

        // Remove from cart
        function removeFromCart(itemId) {
            cart = cart.filter(item => item.id !== itemId);
            document.getElementById('qty-' + itemId).textContent = '0';
            
            // Update buttons
            const decreaseBtn = document.getElementById('decrease-' + itemId);
            const increaseBtn = document.getElementById('increase-' + itemId);
            decreaseBtn.disabled = true;
            increaseBtn.disabled = false;
            
            renderCart();
            showToast('Item removed from cart');
        }

        // Clear cart
        function clearCart() {
            if (confirm('Are you sure you want to clear your cart?')) {
                cart.forEach(item => {
                    document.getElementById('qty-' + item.id).textContent = '0';
                    document.getElementById('decrease-' + item.id).disabled = true;
                    document.getElementById('increase-' + item.id).disabled = false;
                });
                cart = [];
                renderCart();
                showToast('Cart cleared');
            }
        }

        // Confirm order - This will be implemented when you add backend functionality
       // Confirm order - Connect to servlet
function confirmOrder() {
    if (cart.length === 0) {
        alert('Your cart is empty!');
        return;
    }
    
    // Prepare cart data
    const subtotal = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
    const tax = subtotal * TAX_RATE;
    const total = subtotal + tax;
    
    const orderData = {
        subtotal: subtotal,
        tax: tax,
        total: total,
        items: cart
    };
    
    // Show loading state
    const confirmBtn = document.getElementById('confirmOrderBtn');
    const originalText = confirmBtn.innerHTML;
    confirmBtn.innerHTML = '⏳ Processing...';
    confirmBtn.disabled = true;
    
    // Send to servlet using AJAX
    fetch('OrderServlet?action=placeOrder', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'cartData=' + encodeURIComponent(JSON.stringify(orderData))
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // Success!
            alert('✅ ' + data.message + '\n\nOrder ID: ' + data.orderId + '\n\nTotal Amount: ₹' + Math.round(total));
            
            // Clear cart
            cart.forEach(item => {
                document.getElementById('qty-' + item.id).textContent = '0';
                document.getElementById('decrease-' + item.id).disabled = true;
                document.getElementById('increase-' + item.id).disabled = false;
            });
            cart = [];
            renderCart();
            
            // Optional: Redirect to order confirmation page
            // window.location.href = 'myOrders.jsp';
        } else {
            // Error
            alert('❌ Order Failed: ' + data.message);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('❌ Network error. Please try again.');
    })
    .finally(() => {
        // Restore button
        confirmBtn.innerHTML = originalText;
        confirmBtn.disabled = false;
    });
}

        // Show toast notification
        function showToast(message) {
            const toast = document.getElementById('toast');
            const toastMessage = document.getElementById('toastMessage');
            
            toastMessage.textContent = message;
            toast.classList.add('show');
            
            setTimeout(() => {
                toast.classList.remove('show');
            }, 3000);
        }
    </script>
</body>
</html>
