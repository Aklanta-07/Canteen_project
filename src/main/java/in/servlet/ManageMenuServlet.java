package in.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import in.dao.ManageMenuDAO;
import in.dto.MenuDTO;

@WebServlet("/manage-menu")
public class ManageMenuServlet extends HttpServlet{
    
	private ManageMenuDAO menuDAO;
	private MenuDTO menuDTO;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String action = req.getParameter("action");
		
		if("edit".equals(action)) {
			handleEdit(req, resp);
		} else if("delete".equals(action)) {
			handleDelete(req, resp);
		}
	}
	
	private void handleEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		
		int menuId = getMenuId(req, resp);
		if(menuId == -1) return;
		
		menuDAO = new ManageMenuDAO();
	    MenuDTO menu = menuDAO.getMenuById(menuId);
	    
	    if(menu != null) {
	    	req.setAttribute("menu", menu);
	    	RequestDispatcher dispatcher = req.getRequestDispatcher("editMenu.jsp");
	    	dispatcher.forward(req, resp);
	    } else {
	    	resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Menu not found");
	    }
	}
	
    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		
    	int menuId = getMenuId(req, resp);
    	if(menuId == -1) return;
    	
    	menuDTO = new MenuDTO();
    	menuDTO.setMenuId(menuId);
    	
    	menuDAO = new ManageMenuDAO();
    	boolean isDeleted = menuDAO.deleteMenu(menuDTO);
    	
    	 if (isDeleted) {
             resp.sendRedirect("menulist?message=deleted");
         } else {
             resp.sendRedirect("menulist?error=deleteFailed");
         }
    	
	}
    
    private int getMenuId(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String menuIdStr = req.getParameter("menuId");
		
		if(menuIdStr == null || menuIdStr.isEmpty()) {
			 resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Menu ID is required");
	         return -1;
		}
		
		try {
			return Integer.parseInt(menuIdStr);
		}catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Menu ID format");
            return -1;
        }
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 String action = req.getParameter("action");
		    
		 if ("update".equals(action)) {
		        updateMenu(req, resp);
		 }
	}
	
	private void updateMenu(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		
		int menuId = Integer.parseInt(req.getParameter("menuId"));
	    String menuDate = req.getParameter("menuDate");
	    String category = req.getParameter("category");
	    String itemName = req.getParameter("itemName");
	    double price = Double.parseDouble(req.getParameter("price"));
	    String availability = req.getParameter("availability");
	    
	    MenuDTO menu = new MenuDTO();
	    menu.setMenuId(menuId);
	    menu.setMenuDate(menuDate);
	    menu.setCategory(category);
	    menu.setItemName(itemName);
	    menu.setPrice(price);
	    menu.setAvailability(availability);
	    
	    boolean isUpdated = menuDAO.updateMenu(menu);
	    
	    if (isUpdated) {
	        resp.sendRedirect("menulist?message=updated");
	    } else {
	        resp.sendRedirect("editMenu.jsp?menuId=" + menuId + "&error=updateFailed");
	    }
		
	}
    
    
    
    

}
