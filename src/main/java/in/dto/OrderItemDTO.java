package in.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderItemDTO {
	 private int orderItemId;
	    private int orderId;
	    private int menuId;
	    private String itemName;
	    private int quantity;
	    private double unitPrice;
	    private double totalPrice;
		
}
