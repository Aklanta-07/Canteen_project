package in.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import in.dbconnection.DatabaseConnection;
import in.dto.MenuDTO;
import in.dto.OrderDTO;
import in.dto.OrderItemDTO;

public class OrderDAO {
	
	public List<MenuDTO> fetchTodayMenu() {
		
		String sql =
				"SELECT * FROM menus WHERE availability = 'available' AND TRUNC(menu_date) = TRUNC(SYSDATE) ORDER BY MEAL_TYPE";
		List<MenuDTO> menuItems = new ArrayList<>();

		try(Connection con = DatabaseConnection.getConnection();
				   Statement stmt = con.createStatement();
				   ResultSet rs = stmt.executeQuery(sql)) {
			
			
			while(rs.next()) {
				 MenuDTO dto = new MenuDTO();
		         dto.setMenuId(rs.getInt("MENU_ID"));
		         dto.setCategory(rs.getString("MEAL_TYPE"));
		         dto.setItemName(rs.getString("DISH_NAME"));
		         dto.setPrice(rs.getDouble("PRICE"));
		         dto.setAvailability(rs.getString("AVAILABILITY"));
		         dto.setTimeSlot(rs.getString("TIME_SLOT"));
		         dto.setStockQuantity(rs.getInt("STOCK_QUANTITY"));
				
		         menuItems.add(dto);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return menuItems;
	}
	
	public int createOrder(OrderDTO order) {
		String sql =
				"INSERT INTO orders (user_email, total_amount, subtotal, tax_amount, order_status, payment_status) "
		                   + "VALUES (?, ?, ?, ?, ?, ?)";
		
		int generratedOrderId = 0;
		
		try(Connection con = DatabaseConnection.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql, new String[]{"ORDER_ID"})) {
			
			  pstmt.setString(1, order.getUserEmail());
	          pstmt.setDouble(2, order.getTotalAmount());
	          pstmt.setDouble(3, order.getSubtotal());
	          pstmt.setDouble(4, order.getTaxAmount());
	          pstmt.setString(5, "PENDING");
	          pstmt.setString(6, "UNPAID");
	          
	          int rowsInserted = pstmt.executeUpdate();
	          
	          if(rowsInserted > 0) {
	        	  ResultSet rs = pstmt.getGeneratedKeys();
	        	  if(rs.next()) {
	        		  generratedOrderId = rs.getInt(1);
	        	  }
	          }
	            
			
		}catch(Exception e) {
			e.printStackTrace();		
		}
		
		return generratedOrderId;
	}
	
	public boolean addOrderItems(int orderId, List<OrderItemDTO> items) {
		String sql = "INSERT INTO order_items (order_id, menu_id, item_name, quantity, unit_price, total_price) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
		
		 try (Connection con = DatabaseConnection.getConnection();
	             PreparedStatement pstmt = con.prepareStatement(sql)) {
			 
			 for(OrderItemDTO item : items) {
				  pstmt.setInt(1, orderId);
	              pstmt.setInt(2, item.getMenuId());
	              pstmt.setString(3, item.getItemName());
	              pstmt.setInt(4, item.getQuantity());
	              pstmt.setDouble(5, item.getUnitPrice());
	              pstmt.setDouble(6, item.getTotalPrice());
	              
	              pstmt.addBatch();
			 }
			 
			 int[] results = pstmt.executeBatch();
			 
			 for(int result : results) {
				 if(result <= 0 ) {
					 return false;
				 }
			 }
			 
			 return true;
			 
		 } catch(Exception e) {
			 e.printStackTrace();
			 return false;
		 }
	}
	
	public boolean updateMenuStock(int menuId, int quantityOrdered) {
		
		String sql = "UPDATE menus SET stock_quantity = stock_quantity - ? WHERE menu_id = ?";
		
		 try (Connection con = DatabaseConnection.getConnection();
	             PreparedStatement pstmt = con.prepareStatement(sql)) {
			 
			 pstmt.setInt(1, quantityOrdered);
			 pstmt.setInt(2, menuId);
			 
			 int rowsAffected = pstmt.executeUpdate();
			 return rowsAffected > 0;
			 
		 }catch(Exception e) {
			 e.printStackTrace();
			 return false;
		 }
		 
	}
	
	public boolean checkStockAvailability(int menuId, int requestedQuantity) {
		String sql = "SELECT stock_quantity FROM menus WHERE menu_id = ?";
		
		  try (Connection con = DatabaseConnection.getConnection();
			         PreparedStatement pstmt = con.prepareStatement(sql)) {
			  
			  pstmt.setInt(1, menuId);
			  ResultSet rs = pstmt.executeQuery();
			  
			  if(rs.next()) {
				  int availableStock = rs.getInt("STOCK_QUANTITY");
				  return availableStock >= requestedQuantity;
			  }
			  
		  }catch(Exception e) {
			  e.printStackTrace();
			
		  }
			        
		  return false;  
	}
	
    public List<OrderDTO> getOrdersByUser(String userEmail) {
		
		String sql = "SELECT * FROM orders WHERE user_email = ? ORDER BY order_date DESC";
		List<OrderDTO> orders = new ArrayList<>();
		
		  try (Connection con = DatabaseConnection.getConnection();
		             PreparedStatement pstmt = con.prepareStatement(sql)) {
			  
			  pstmt.setString(1,userEmail);
			  ResultSet rs = pstmt.executeQuery();
			  
			  while(rs.next()) {
				  OrderDTO order = new OrderDTO();
				  order.setOrderId(rs.getInt("order_id"));
	              order.setUserEmail(rs.getString("user_email"));
	              order.setOrderDate(rs.getTimestamp("order_date"));
	              order.setTotalAmount(rs.getDouble("total_amount"));
	              order.setSubtotal(rs.getDouble("subtotal"));
	              order.setTaxAmount(rs.getDouble("tax_amount"));
	              order.setOrderStatus(rs.getString("order_status"));
	              order.setPaymentStatus(rs.getString("payment_status"));
                  order.setCancellationReason(rs.getString("cancellation_reason"));
                  order.setCancelledAt(rs.getTimestamp("cancelled_at"));
	                
	              orders.add(order);  
			  }
			  
		  }catch(Exception e) {
			  e.printStackTrace();
		  }
		  
		  return orders;
	}
    
    public OrderDTO getOrderById(int orderId) {
    	String sql = "SELECT * FROM orders WHERE order_id = ?";
    	OrderDTO order = null;
    	
    	 
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
        	
        	pstmt.setInt(1, orderId);
        	ResultSet rs = pstmt.executeQuery();	
        	
        	if(rs.next()) {
        		order = new OrderDTO();
        		order.setOrderId(rs.getInt("order_id"));
                order.setUserEmail(rs.getString("user_email"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setSubtotal(rs.getDouble("subtotal"));
                order.setTaxAmount(rs.getDouble("tax_amount"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setCancellationReason(rs.getString("cancellation_reason"));
                order.setCancelledAt(rs.getTimestamp("cancelled_at"));
        	}
        	
        }catch(Exception e) {
        	e.printStackTrace();
        }
        
        return order;
    }
    
    public List<OrderItemDTO> getOrderItems(int orderId) {
    	String sql = "SELECT * FROM order_items WHERE order_id = ?";
    	List<OrderItemDTO> items = new ArrayList<>();
    	
    	 
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
        	
        	pstmt.setInt(1, orderId);
        	ResultSet rs = pstmt.executeQuery();
        	
        	while(rs.next()) {
        		OrderItemDTO item = new OrderItemDTO();
        		 item.setOrderItemId(rs.getInt("order_item_id"));
                 item.setOrderId(rs.getInt("order_id"));
                 item.setMenuId(rs.getInt("menu_id"));
                 item.setItemName(rs.getString("item_name"));
                 item.setQuantity(rs.getInt("quantity"));
                 item.setUnitPrice(rs.getDouble("unit_price"));
                 item.setTotalPrice(rs.getDouble("total_price"));
                 
                 items.add(item);
        	}
        	
        }catch(Exception e) {
        	e.printStackTrace();
        }
         
        return items;
    }
	
	public boolean cancelOrder(int orderId, String cancellationReason) {
		
		Connection con = null;
		
		try {
			con = DatabaseConnection.getConnection();
			con.setAutoCommit(false);
			
			//get all itemms from this order_id
			String getItemSql = "SELECT menu_id, quantity FROM order_items WHERE order_id = ?";
			PreparedStatement getItemStmt = con.prepareStatement(getItemSql);
			getItemStmt.setInt(1, orderId);
			ResultSet rs = getItemStmt.executeQuery();
			
			//restore stock for each item;
			String restoreStockSql =
					"UPDATE menus SET stock_quantity = stock_quantity + ?, availability = 'available' WHERE menu_id = ?"; 
			PreparedStatement restoreStockStmt = con.prepareStatement(restoreStockSql);
			
			while(rs.next()) {
				int menuId = rs.getInt("MENU_ID");
				int quantity = rs.getInt("QUANTITY");
				
				restoreStockStmt.setInt(1, quantity);
				restoreStockStmt.setInt(2, menuId);
				restoreStockStmt.addBatch();
			}
			
			restoreStockStmt.executeBatch();
			
			//update order status to cancelled
			  String cancelOrderSql = "UPDATE orders SET order_status = 'CANCELLED', "
                      + "cancellation_reason = ?, cancelled_at = CURRENT_TIMESTAMP "
                      + "WHERE order_id = ?";
			  PreparedStatement cancelOrderStmt = con.prepareStatement(cancelOrderSql);
			  cancelOrderStmt.setString(1, cancellationReason);
			  cancelOrderStmt.setInt(2, orderId	);
			  cancelOrderStmt.executeUpdate();
			  
			  con.commit();
			  return true;
			
		}catch(Exception e) {
			e.printStackTrace();
			
			if(con != null) {
				try {
					con.rollback();  //Rollback if error occurred
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}
			
			return false;
			
		}finally {
			if(con != null) {
				try {
					con.setAutoCommit(true);
					con.close();
					
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	//For admin-dashboard 
	public boolean updateOrderStatus(int orderId, String newStatus) {
		
		String sql = "UPDATE orders SET order_status = ? WHERE order_id = ?";
		
		 try (Connection con = DatabaseConnection.getConnection();
		         PreparedStatement pstmt = con.prepareStatement(sql)) {
			 
			 pstmt.setString(1, newStatus);
			 pstmt.setInt(2, orderId);
			 
			int rowsAffected =  pstmt.executeUpdate();
			
			return rowsAffected > 0;
			 
		 }catch(Exception e) {
			 e.printStackTrace();
			 return false;
		 }
	}
	
	public List<OrderDTO> getAllOrders() {
		
		String sql = "SELECT * FROM orders ORDER BY order_date DESC";
		List<OrderDTO> orders = new ArrayList<>();
		
		 try (Connection con = DatabaseConnection.getConnection();
		         PreparedStatement pstmt = con.prepareStatement(sql)) {
			 
			 ResultSet rs = pstmt.executeQuery();	
			 
			 while(rs.next()) {
				 OrderDTO order = new OrderDTO();
				 order.setOrderId(rs.getInt("order_id"));
		         order.setUserEmail(rs.getString("user_email"));
		         order.setOrderDate(rs.getTimestamp("order_date"));
	             order.setTotalAmount(rs.getDouble("total_amount"));
	             order.setSubtotal(rs.getDouble("subtotal"));
    	         order.setTaxAmount(rs.getDouble("tax_amount"));
		         order.setOrderStatus(rs.getString("order_status"));
		         order.setPaymentStatus(rs.getString("payment_status"));
	             order.setCancellationReason(rs.getString("cancellation_reason"));
		         order.setCancelledAt(rs.getTimestamp("cancelled_at"));
		         
		         orders.add(order);
			 }
			 
		 }catch(Exception e) {
			 e.printStackTrace();
		 }
		 
		 return orders;
	}
	
	public List<OrderDTO> getOrderByStatus(String status) {
		
		String sql = "SELECT * FROM orders WHERE order_status = ? ORDER BY order_date DESC";
		List<OrderDTO> orders = new ArrayList<>();
		
		try (Connection con = DatabaseConnection.getConnection();
		         PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, status);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				OrderDTO order = new OrderDTO();
				 order.setOrderId(rs.getInt("order_id"));
		         order.setUserEmail(rs.getString("user_email"));
		         order.setOrderDate(rs.getTimestamp("order_date"));
		         order.setTotalAmount(rs.getDouble("total_amount"));
	             order.setSubtotal(rs.getDouble("subtotal"));
	             order.setTaxAmount(rs.getDouble("tax_amount"));
 	             order.setOrderStatus(rs.getString("order_status"));
 	             order.setPaymentStatus(rs.getString("payment_status"));
		         order.setCancellationReason(rs.getString("cancellation_reason"));
		         order.setCancelledAt(rs.getTimestamp("cancelled_at"));
		         
		         orders.add(order);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return orders;
	}
	
	public int getOrderCountByStatus(String status) {
		
		String sql = "SELECT COUNT(*) FROM orders WHERE order_status = ?";
		
		try (Connection con = DatabaseConnection.getConnection();
		         PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, status);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

