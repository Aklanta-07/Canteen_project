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

@WebServlet("/MyOrdersServlet")
public class MyOrderServlet extends HttpServlet{
	
	private OrderDAO order = new OrderDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		String userEmail = (String)session.getAttribute("userEmail");
		
		 
        if (userEmail == null || userEmail.isEmpty()) {
            resp.sendRedirect("login.jsp");
            return;
        }
        
        List<OrderDTO> orders = order.getOrdersByUser(userEmail);
        
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("orderHistory.jsp").forward(req, resp);
	}

}
