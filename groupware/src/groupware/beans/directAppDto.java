package groupware.beans;

public class directAppDto {

	private int approvalNo;
	private String approval;
	private String type;
	private String consesus;
	
	
	public directAppDto() {
		super();
	}
	public int getApprovalNo() {
		return approvalNo;
	}
	public void setApprovalNo(int approvalNo) {
		this.approvalNo = approvalNo;
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
}
