package in.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import in.dao.OrderDAO;
import in.dto.OrderDTO;
import in.dto.OrderItemDTO;

@WebServlet("/AdminOrdersServlet")
public class AdminOrdersServlet extends HttpServlet{

	private OrderDAO orderDAO = new OrderDAO();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		String adminEmail =(String)session.getAttribute("adminEmail");
		
		if(adminEmail == null || adminEmail.isEmpty()) {
			resp.sendRedirect("login.jsp");
			return;
		}
		
		String statusFilter = req.getParameter("status");
		
		List<OrderDTO> orders;
		
		if(statusFilter != null && !statusFilter.isEmpty() && !"ALL".equals(statusFilter)) {
			orders = orderDAO.getOrderByStatus(statusFilter);
		} else {
			orders = orderDAO.getAllOrders();
		}
		
		//get counts for each status
		Map<String, Integer> statusCounts = new HashMap<>();
		statusCounts.put("PENDING", orderDAO.getOrderCountByStatus("PENDING"));
		statusCounts.put("CONFIRMED", orderDAO.getOrderCountByStatus("CONFIRMED"));
		statusCounts.put("CONFIRMED", orderDAO.getOrderCountByStatus("CONFIRMED"));
		statusCounts.put("PREPARING", orderDAO.getOrderCountByStatus("PREPARING"));
        statusCounts.put("READY", orderDAO.getOrderCountByStatus("READY"));
        statusCounts.put("COMPLETED", orderDAO.getOrderCountByStatus("COMPLETED"));
        statusCounts.put("CANCELLED", orderDAO.getOrderCountByStatus("CANCELLED"));
        
        req.setAttribute("orders", orders);
        req.setAttribute("statusCounts", statusCounts);
        req.setAttribute("currentFilter", statusFilter != null ? statusFilter : "ALL");
        
        req.getRequestDispatcher("adminOrders.jsp").forward(req, resp);
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String action = req.getParameter("action");
		
		if("updateStatus".equals(action)) {
			updateOrderStatus(req, resp);
			
		} else if("getOrderDetails".equals(action)) {
			getOrderDetails(req, resp);
			
		} else if("cancelOrder".equals(action)) {
			cancelOrder(req, resp);
		}
	}
	
	private void updateOrderStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		try {
			int orderId = Integer.parseInt(req.getParameter("orderId"));
			String newStatus = req.getParameter("newStatus");
			
			boolean updated = orderDAO.updateOrderStatus(orderId, newStatus);
			resp.setContentType("application/json");
			
			if(updated) {
				resp.getWriter().write("{\"success\": true, \"message\": \"Order status updated to " + newStatus + "\"}");
			} else {
				resp.getWriter().write("{\"success\": false, \"message\": \"Failed to update order status\"}");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		    resp.setContentType("application/json");
	        resp.getWriter().write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
		}
	}
	
	private void getOrderDetails(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		try {
			int orderId = Integer.parseInt(req.getParameter("orderId"));
			
			OrderDTO order = orderDAO.getOrderById(orderId);
			List<OrderItemDTO> items = orderDAO.getOrderItems(orderId);
			
			//create resp obj
			Map<String, Object> data = new HashMap<>();
			data.put("order", order);
			data.put("items", items);
			
			Gson gson = new Gson();
			String json = gson.toJson(data);
			
			resp.setContentType("application/json");
			resp.getWriter().write(json);
			
		}catch (Exception e) {
			e.printStackTrace();
			resp.setContentType("application/json");
            resp.getWriter().write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
		}
		
	}
	
	private void cancelOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		try {
			int orderId = Integer.parseInt(req.getParameter("orderId"));
			String reason = req.getParameter("reason");
			
			if(reason == null || reason.isBlank()) {
				reason = "Cancelled by admin";
			}
			
			boolean cancelled = orderDAO.cancelOrder(orderId, reason);
			resp.setContentType("application/json");
			
			if(cancelled) {
				resp.getWriter().write("{\"success\": true, \"message\": \"Order cancelled successfully\"}");
			} else {
				resp.getWriter().write("{\"success\": false, \"message\": \"Failed to cancel order\"}");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			resp.setContentType("application/json");
            resp.getWriter().write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
			
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
