package in.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import in.dbconnection.DatabaseConnection;
import in.dto.MenuDTO;

public class ManageMenuDAO {
	
	public boolean deleteMenu(MenuDTO menu) {
		
		String sql = "DELETE FROM menus WHERE MENU_ID = ?";
		
		 try(Connection con = DatabaseConnection.getConnection();
				   PreparedStatement pstmt = con.prepareStatement(sql)) {
				
				pstmt.setInt(1, menu.getMenuId());
				
				int rowsDeleted = pstmt.executeUpdate();
		        
		        return rowsDeleted > 0;
		
			} catch (SQLException e) {
				
				e.printStackTrace();
				return false;
			}
	}
	
	public MenuDTO getMenuById(int menuId) {
		String sql = "SELECT * FROM menus WHERE menu_id = ?";
		
		MenuDTO menus = null;
		
		try(Connection con = DatabaseConnection.getConnection();
				   PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setInt(1, menuId);
			ResultSet rs = pstmt.executeQuery();
			
		 	if(rs.next()) {
			     menus = new MenuDTO();
		         menus.setMenuId(rs.getInt("MENU_ID"));
		         Date menuDate = rs.getDate("MENU_DATE");
		         if (menuDate != null) {
		             menus.setMenuDate(menuDate.toString());  
		         }
		         menus.setCategory(rs.getString("MEAL_TYPE"));
		         menus.setItemName(rs.getString("DISH_NAME"));
                 menus.setPrice(rs.getDouble("PRICE"));
                 menus.setAvailability(rs.getString("AVAILABILITY"));
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return menus;
	}
	
	public boolean updateMenu(MenuDTO menu) {
		String sql =
		  "UPDATE menus SET MENU_DATE = ?, MEAL_TYPE = ?, DISH_NAME = ?, PRICE = ?, AVAILABILITY = ? WHERE MENU_ID = ?";
		
		 try(Connection con = DatabaseConnection.getConnection();
				   PreparedStatement pstmt = con.prepareStatement(sql)) {
				
			    pstmt.setDate(1, java.sql.Date.valueOf(menu.getMenuDate()));
			    pstmt.setString(2, menu.getCategory());
			    pstmt.setString(3, menu.getItemName());
		        pstmt.setDouble(4, menu.getPrice());
		        pstmt.setString(5, menu.getAvailability());
		        pstmt.setInt(6, menu.getMenuId());
				
				int rowsUpdated = pstmt.executeUpdate();
		        
		        return rowsUpdated > 0;
		
			} catch (SQLException e) {
				
				e.printStackTrace();
				return false;
			}
		
		
	}
	
	
}
