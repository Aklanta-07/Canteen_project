package in.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import in.dao.NotificationDAO;
import in.dto.NotificationDTO;

@WebServlet("/NotificationServlet")
public class NotificationServlet extends HttpServlet {

	private NotificationDAO notificationDAO = new NotificationDAO();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session  = req.getSession();
		String userEmail = (String)session.getAttribute("userEmail");
		
		if(userEmail != null && userEmail.isEmpty()) {
			resp.sendRedirect("login.jsp");
			return;
		}
		List<NotificationDTO> notifications = notificationDAO.getAllNotifications(userEmail);
		int unreadCount = notificationDAO.getUnreadCount(userEmail);
		
		req.setAttribute("notifications", notifications);
		req.setAttribute("unreadCount", unreadCount);
		
		req.getRequestDispatcher("notifications.jsp").forward(req, resp);
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");
		
        if ("markAsRead".equals(action)) {
            markAsRead(req, resp);
        } else if ("markAllRead".equals(action)) {
            markAllAsRead(req, resp);
        } /*else if ("deleteNotification".equals(action)) {
            deleteNotification(req, resp);
        }  */ 
	}
	
	private void  markAsRead(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	try {
    		
    		int notificationId = Integer.parseInt(req.getParameter("notificationId"));
    		boolean marked = notificationDAO.markAsRead(notificationId);
    		
    		resp.setContentType("application/json");
            if (marked) {
                resp.getWriter().write("{\"success\": true, \"message\": \"Notification marked as read\"}");
            } else {
                resp.getWriter().write("{\"success\": false, \"message\": \"Failed to mark as read\"}");
            }
    		
    	}catch (Exception e) {
			e.printStackTrace();
			resp.setContentType("application/json");
            resp.getWriter().write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
		}
    }
	
	private void markAllAsRead(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
			HttpSession session = req.getSession();
			String userEmail = (String)session.getAttribute("userEmail");
			
			if (userEmail == null || userEmail.isEmpty()) {
	            resp.setContentType("application/json");
	            resp.getWriter().write("{\"success\": false, \"message\": \"Not logged in\"}");
	            return;
	        }
			
			boolean marked = notificationDAO.markAllAsRead(userEmail);
			
			resp.setContentType("application/json");
            if (marked) {
                resp.getWriter().write("{\"success\": true, \"message\": \"All notifications marked as read\"}");
            } else {
                resp.getWriter().write("{\"success\": false, \"message\": \"Failed to mark all as read\"}");
            }
			
		}catch (Exception e) {
			e.printStackTrace();
			resp.setContentType("application/json");
            resp.getWriter().write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
		}
	}

}
