package groupware.beans;

public class directAppDto {
	private int rowNo;
	private int approvalNo;
	private int appNo;
	private String approval;
	private String type;
	private String consesus;
	private String appDate;
	private int poNo;
	private String empName;
	
	public directAppDto() {
		super();
	}
	public int getApprovalNo() {
		return approvalNo;
	}
	public void setApprovalNo(int approvalNo) {
		this.approvalNo = approvalNo;
	}
	
	public int getAppNo() {
		return appNo;
	}
	public void setAppNo(int appNo) {
		this.appNo = appNo;
	}
	public String getApproval() {
		return approval;
	}
	public void setApproval(String approval) {
		this.approval = approval;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getConsesus() {
		return consesus;
	}
	public void setConsesus(String consesus) {
		this.consesus = consesus;
	}
	
	public String getAppDate() {
		return appDate;
	}
	public void setAppDate(String appDate) {
		this.appDate = appDate;
	}
	public int getRowNo() {
		return rowNo;
	}
	public void setRowNo(int rowNo) {
		this.rowNo = rowNo;
	}
	public int getPoNo() {
		return poNo;
	}
	public void setPoNo(int poNo) {
		this.poNo = poNo;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	
}
