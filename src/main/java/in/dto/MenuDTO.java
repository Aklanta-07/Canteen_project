package in.dto;

public class MenuDTO {
 
	private String itemName;
	private String category;
	private double price;
	private String availability;
	private String timeSlot;
	private String menuDate;
	
	public String getMenuDate() {
		return menuDate;
	}
	public void setMenuDate(String menuDate) {
		this.menuDate = menuDate;
	}
	public String getTimeSlot() {
		return timeSlot;
	}
	public void setTimeSlot(String timeSlot) {
		this.timeSlot = timeSlot;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getAvailability() {
		return availability;
	}
	public void setAvailability(String availability) {
		this.availability = availability;
	}
}
