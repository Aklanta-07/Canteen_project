package in.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminDTO {
	private String userName;
	private String email;
	private String password;
	private String fullName;
	private Integer phoneNo;
	private String role;
}
