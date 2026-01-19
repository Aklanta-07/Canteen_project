package in.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import in.dbconnection.DatabaseConnection;
import in.dto.FieldsDTO;

public class RegisterDAO {
	
	public boolean insertField(FieldsDTO field) {
		   String query = "INSERT INTO users (fullname, username, email, phone, usertype, user_password) VALUES (?, ?, ?, ?, ?, ?)";
		   
		   try(Connection con = DatabaseConnection.getConnection();
			   PreparedStatement pstmt = con.prepareStatement(query)) {
			
			pstmt.setString(1, field.getFullName());
			pstmt.setString(2, field.getUserName());
			pstmt.setString(3, field.getEmail());
			pstmt.setInt(4, field.getPhoneNo());
			pstmt.setString(5, field.getUserType());
			pstmt.setString(6, field.getPassword());
			
			int rowsInserted = pstmt.executeUpdate();
			
			return rowsInserted > 0;
			
		} catch (SQLException e) {
			
			e.printStackTrace();
			return false;
		}
		   
	   }
}
