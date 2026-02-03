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

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import in.dao.OrderDAO;
import in.dto.OrderDTO;
import in.dto.OrderItemDTO;

@WebServlet("/OrderServlet")
public class ManageOrderServlet extends HttpServlet{

	private OrderDAO orderDAO = new OrderDAO();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");
		
		if("placeOrder".equals(action)) {
			placeOrder(req, resp);
		} else if("cancelOrder".equals(action)) {
			cancelOrder(req, resp);
		}
		
		//later we aill add more functionalities e.g:CncaelOrder, ConfirmOrder
	}
	
	private void placeOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		
		try {
			//get session
			HttpSession session = req.getSession();
			String userEmail = (String)session.getAttribute("userEmail");
			
			if(userEmail == null || userEmail.isEmpty()) {
				 resp.setContentType("application/json");
				 resp.getWriter().write("{\"success\": false, \"message\": \"Please login first\"}");
	             return;
			}
			
			//get cart-data
			String cartData = req.getParameter("cartData");
			 if (cartData == null || cartData.isEmpty()) {
	             resp.setContentType("application/json");
	             resp.getWriter().write("{\"success\": false, \"message\": \"Cart is empty\"}");
	             return;
	         }
			 
			 //parse cart data to java obj
			 Gson gson = new Gson();
			 JsonObject jsonCart = gson.fromJson(cartData, JsonObject.class);
			 
			 double subtotal = jsonCart.get("subtotal").getAsDouble();
			 double tax = jsonCart.get("tax").getAsDouble();	
			 double total = jsonCart.get("total").getAsDouble();
			 JsonArray itemsArray = jsonCart.getAsJsonArray("items");	
			 
			 //check stock availability
			 for(int i = 0; i < itemsArray.size(); i++) {
				 JsonObject item = itemsArray.get(i).getAsJsonObject();
				 int menuId = item.get("id").getAsInt();
				 int quantity = item.get("quantity").getAsInt();
				 String itemName = item.get("name").getAsString();
				 
				 boolean stockAvailable = orderDAO.checkStockAvailability(menuId, quantity);
				 
				 if(!stockAvailable) {
					 resp.setContentType("application/json");
		             resp.getWriter().write("{\"success\": false, \"message\": \"Insufficient stock for " + itemName + "\"}");
		             return; 
				 }
			 }
			 
			 //set Fields
			 OrderDTO order = new OrderDTO();
			 order.setUserEmail(userEmail);
			 order.setSubtotal(subtotal);
			 order.setTaxAmount(tax);
			 order.setTotalAmount(total);
			 
			 //create order in db
			 int orderId = orderDAO.createOrder(order);
			 
			 if(orderId <= 0 ) {
				 resp.setContentType("application/json");
	             resp.getWriter().write("{\"success\": false, \"message\": \"Failed to create order\"}");
	             return;
			 }
			 
			 //create list of order
			 List<OrderItemDTO> orderItems = new ArrayList<>();
			 
			 for(int i = 0; i < itemsArray.size(); i++) {
				 JsonObject item = itemsArray.get(i).getAsJsonObject();
				 
				 OrderItemDTO orderItem = new OrderItemDTO();
				 orderItem.setOrderId(orderId);
				 orderItem.setMenuId(item.get("id").getAsInt());
				 orderItem.setItemName(item.get("name").getAsString());
				 orderItem.setQuantity(item.get("quantity").getAsInt());
	             orderItem.setUnitPrice(item.get("price").getAsDouble());
	             orderItem.setTotalPrice(item.get("price").getAsDouble() * item.get("quantity").getAsInt());
	             
	             orderItems.add(orderItem);
			 }
			 
			 //add order-items in DB
			 boolean itemsAdded = orderDAO.addOrderItems(orderId, orderItems);
			 
			 if(!itemsAdded) {
				 resp.setContentType("application/json");
	             resp.getWriter().write("{\"success\": false, \"message\": \"Failed to add order items\"}");
	             return;
			 }
			 
			 //update stock for each item
			 for(OrderItemDTO item : orderItems) {
				 orderDAO.updateMenuStock(item.getMenuId(), item.getQuantity());
			 }
			 
			  resp.setContentType("application/json");
	          resp.getWriter().write("{\"success\": true, \"orderId\": " + orderId + ", \"message\": \"Order placed successfully!\"}");
			
		} catch(Exception e) {
			 e.printStackTrace();
	         resp.setContentType("application/json");
	         resp.getWriter().write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
	        
		}
	}
	
	private void cancelOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		
		try {
			int orderId = Integer.parseInt(req.getParameter("orderId"));
			String reason = req.getParameter("reason");
			
			if(reason == null || reason.isBlank()) {
				reason = "User requested cancellation";
			}
			
			boolean cancelled = orderDAO.cancelOrder(orderId, reason);
			
			if(cancelled) {
				resp.setContentType("application/json");
		        resp.getWriter().write("{\"success\": true, \"message\": \"Order cancelled successfully\"}");
			} else {
				resp.setContentType("application/json");
	            resp.getWriter().write("{\"success\": false, \"message\": \"Failed to cancel order\"}");
			}
			
		} catch (NumberFormatException e) {
			e.printStackTrace();
		    resp.setContentType("application/json");
		    resp.getWriter().write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
