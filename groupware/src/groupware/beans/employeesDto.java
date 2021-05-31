package groupware.beans;

public class employeesDto {

	private String empNo;
	private String empPw;
	private int poNo;
	private String empName;
	private String joinDate;
	private String empPhone;
	private String email;
	private String address;
	private String department;
	private String poSi;
	public employeesDto(String empNo, String empPw, int poNo, String empName, String joinDate, String empPhone,
			String email, String address, String department) {
		super();
		this.empNo = empNo;
		this.empPw = empPw;
		this.poNo = poNo;
		this.empName = empName;
		this.joinDate = joinDate;
		this.empPhone = empPhone;
		this.email = email;
		this.address = address;
		this.department = department;
	}

	
	
	

	public employeesDto() {
		super();
	}
	
	public employeesDto(String empNo, String empPw) {
		super();
		this.empNo = empNo;
		this.empPw = empPw;
	}
	
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getEmpPw() {
		return empPw;
	}
	public void setEmpPw(String empPw) {
		this.empPw = empPw;
	}
	
	public int getPono() {
		return poNo;
	}

	public void setPono(int poNo) {
		this.poNo = poNo;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}

	public String getEmpPhone() {
		return empPhone;
	}

	public void setEmpPhone(String empPhone) {
		this.empPhone = empPhone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getPoSi() {
		return poSi;
	}

	public void setPoSi(String poSi) {
		this.poSi = poSi;
	}
	
}
