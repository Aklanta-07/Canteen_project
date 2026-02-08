package in.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MenuDTO {
 
	private String itemName;
	private String category;
	private double price;
	private String availability;
	private String timeSlot;
	private String menuDate;
	private Integer menuId;
	private int stockQuantity;
	private String isActive;
	
	
}
