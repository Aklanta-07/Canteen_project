package in.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderDTO {
	private int orderId;
    private String userEmail;
    private Timestamp orderDate;
    private double totalAmount;
    private double subtotal;
    private double taxAmount;
    private String orderStatus;
    private String paymentStatus;
    private String cancellationReason;
    private Timestamp cancelledAt;
    
	
}
