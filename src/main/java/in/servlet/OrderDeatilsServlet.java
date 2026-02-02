package in.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import in.dao.OrderDAO;
import in.dto.OrderDTO;
import in.dto.OrderItemDTO;

@WebServlet("/OrderDetails")
public class OrderDeatilsServlet extends HttpServlet{

	 private OrderDAO orderDAO = new OrderDAO();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			HttpSession session = req.getSession();
			String userEmail = (String)session.getAttribute("userEmail");
			 
	        if (userEmail == null || userEmail.isEmpty()) {
	            resp.sendRedirect("login.jsp");
	            return;
	        }
			
			int orderId = Integer.parseInt(req.getParameter("orderId"));
			
			OrderDTO order = orderDAO.getOrderById(orderId);
			if(order == null || !order.getUserEmail().equals(userEmail)) {
				   req.setAttribute("order", null);
	               req.getRequestDispatcher("orderDetails.jsp").forward(req, resp);
	               return;
			}
					
			List<OrderItemDTO> items = orderDAO.getOrderItems(orderId);
			
			req.setAttribute("order", order);
			req.setAttribute("items", items);
			req.getRequestDispatcher("orderDetails.jsp").forward(req, resp);
			
		}catch(Exception e) {
			e.printStackTrace();
			resp.sendRedirect("MyOrdersServlet");
		}
	}

}
