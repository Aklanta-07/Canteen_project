package in.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import in.dbconnection.DatabaseConnection;
import in.dto.FieldsDTO;

public class LoginDAO {
	boolean isPresent;

	public boolean fetchField(FieldsDTO field) throws NullPointerException{
		
		String sql = "SELECT * FROM users WHERE EMAIL = ? AND user_password = ? ";
		
		 try(Connection con = DatabaseConnection.getConnection();
				   PreparedStatement pstmt = con.prepareStatement(sql)) {
				
				pstmt.setString(1, field.getEmail());
				pstmt.setString(2, field.getPassword());
				
				ResultSet rs = pstmt.executeQuery();
		        while(rs.next()) {
					  isPresent = true;
				}
		        
		        return isPresent;
		
			} catch (SQLException e) {
				
				e.printStackTrace();
				return false;
			}
		
		
	}
}
