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

import in.dao.OrderDAO;
import in.dto.OrderDTO;

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
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
