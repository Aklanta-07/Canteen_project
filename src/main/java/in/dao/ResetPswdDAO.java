package in.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import in.dbconnection.DatabaseConnection;
import in.dto.FieldsDTO;

public class ResetPswdDAO {
	
	public boolean resetPassword(FieldsDTO field) {
		
		String sql = "UPDATE users SET user_password = ? WHERE email = ?";
		
		try(Connection con = DatabaseConnection.getConnection();
				   PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, field.getPassword());
			pstmt.setString(2, field.getEmail());
			
			int rowsAffected = pstmt.executeUpdate();
			
			return rowsAffected > 0;
			
		} catch(Exception e) {
			e.printStackTrace();
			return false;
					
		}
	}

}
