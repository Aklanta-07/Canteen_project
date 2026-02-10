package in.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NotificationDTO {
	private int notificationId;
	private String userEmail;
	private int orderId;
	private String message;
	private String notificationType;
	private String isRead;
	private Timestamp createdAt;
}
