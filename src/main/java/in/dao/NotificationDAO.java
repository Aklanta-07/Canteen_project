package in.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import in.dbconnection.DatabaseConnection;
import in.dto.NotificationDTO;

public class NotificationDAO {

	public boolean createNotification(String userEmail, int orderId, String message) {
		
		String sql =
			  "INSERT INTO notifications(USER_EMAIL,  ORDER_ID, MESSAGE, NOTIFICATION_TYPE) VALUES "
			  + "(?, ?, ?, 'ORDER_UPDATE')";
		
		try (Connection con = DatabaseConnection.getConnection();
	             PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, userEmail);
			pstmt.setInt(2, orderId);
			pstmt.setString(3, message);
			
			int rowsAffected = pstmt.executeUpdate();
			
			return rowsAffected > 0;
			
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
	}
	
	public List<NotificationDTO> getUnreadNotifications(String userEmail) {
		String sql = "SELECT * FROM notifications WHERE user_email = ? AND is_read = 'N' ORDER BY created_at DESC";
		List<NotificationDTO> notifications = new ArrayList<>();
		
		try (Connection con = DatabaseConnection.getConnection();
	             PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, userEmail);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NotificationDTO notification = new NotificationDTO();
                notification.setNotificationId(rs.getInt("notification_id"));
                notification.setUserEmail(rs.getString("user_email"));
                notification.setOrderId(rs.getInt("order_id"));
                notification.setMessage(rs.getString("message"));
                notification.setNotificationType(rs.getString("notification_type"));
                notification.setIsRead(rs.getString("is_read"));
                notification.setCreatedAt(rs.getTimestamp("created_at"));
                
                notifications.add(notification);
			}
			
		}catch(Exception  e) {
			e.printStackTrace();
		}
		return notifications;
	}
	
	public List<NotificationDTO> getAllNotifications(String userEmail) {
		String sql = "SELECT * FROM notifications WHERE user_email = ? ORDER BY created_at DESC";
		List<NotificationDTO> notifications = new ArrayList<>();
		
		try (Connection con = DatabaseConnection.getConnection();
	             PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, userEmail);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
                NotificationDTO notification = new NotificationDTO();
                notification.setNotificationId(rs.getInt("notification_id"));
                notification.setUserEmail(rs.getString("user_email"));
                notification.setOrderId(rs.getInt("order_id"));
                notification.setMessage(rs.getString("message"));
                notification.setNotificationType(rs.getString("notification_type"));
                notification.setIsRead(rs.getString("is_read"));
                notification.setCreatedAt(rs.getTimestamp("created_at"));
                
                notifications.add(notification);
            }
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return notifications;
	}
	
	public boolean markAsRead(int notificationId) {
		String sql = "UPDATE notifications SET is_read = 'Y' WHERE notification_id = ?";
		
		try (Connection con = DatabaseConnection.getConnection();
	             PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setInt(1, notificationId);
			int rowsAffected = pstmt.executeUpdate();
			return rowsAffected > 0 ;
			
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean markAllAsRead(String userEmail) {
		String sql = "UPDATE notifications SET is_read = 'Y' WHERE user_email = ? AND is_read = 'N'";
		
		try (Connection con = DatabaseConnection.getConnection();
	             PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, userEmail);
			int rowsAffected = pstmt.executeUpdate();
			return rowsAffected > 0;
			
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public int getUnreadCount(String userEmail) {
		String sql = "SELECT COUNT(*) FROM notifications  WHERE user_email = ? AND  is_read = 'N'";
		
		try (Connection con = DatabaseConnection.getConnection();
	             PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, userEmail);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public boolean deleteNotification(int notificationId) {
		String sql = "DELETE FROM notifications WHERE notification_id = ?";
		
		try (Connection con = DatabaseConnection.getConnection();
		         PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setInt(1, notificationId);
			int rowsAffected = pstmt.executeUpdate();
			
			return rowsAffected > 0;
			
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
