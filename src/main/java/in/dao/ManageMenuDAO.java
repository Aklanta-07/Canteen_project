package in.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
	
	public List<MenuDTO> filterMenu(MenuDTO menuDTO) {
		
		StringBuilder sql = new StringBuilder("SELECT * FROM menus WHERE 1 = 1");
		List<MenuDTO> menus = new ArrayList<>();
		
		try {
			if(menuDTO.getCategory() != null && !menuDTO.getCategory().equals("")) {
				sql.append("AND MEAL_TYPE = ?");
			}
			if(menuDTO.getAvailability() != null && !menuDTO.getAvailability().equals("")) {
				sql.append("AND AVAILABILITY = ?");
			}
			
			Connection con = DatabaseConnection.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql.toString());
			
			int index = 1;
			
			if(menuDTO.getCategory() != null && !menuDTO.getCategory().equals("")) {
				pstmt.setString(index, menuDTO.getCategory());
				index++;
			}
			if(menuDTO.getAvailability() != null && !menuDTO.getAvailability().equals("")) {
				pstmt.setString(index, menuDTO.getAvailability());
			}
			
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				MenuDTO dto = new MenuDTO();
				 dto.setMenuId(rs.getInt("MENU_ID"));
		         Date menuDate = rs.getDate("MENU_DATE");
		         if (menuDate != null) {
		             dto.setMenuDate(menuDate.toString());  
		         }
		         dto.setCategory(rs.getString("MEAL_TYPE"));
		         dto.setItemName(rs.getString("DISH_NAME"));
                 dto.setPrice(rs.getDouble("PRICE"));
                 dto.setAvailability(rs.getString("AVAILABILITY"));
				
				menus.add(dto);
			}	
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return menus;
	}
	
	
	
	
	
	
}
