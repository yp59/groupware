package groupware.beans;

public class approvalDto {

	
	private int appNo;
	private int attNo;
	private String drafter;
	private int approvalNo;
	private int referrerNo;
	private String appTitle;
	private String appContent;
	private String appDateStart;
	private String appDate;
	private String appDateEnd;
	private String appState;
	
	public approvalDto() {
		super();
	}
	
	public int getAppNo() {
		return appNo;
	}
	public void setAppNo(int appNo) {
		this.appNo = appNo;
	}
	public int getAttNo() {
		return attNo;
	}
	public void setAttNo(int attNo) {
		this.attNo = attNo;
	}
	public String getDrafter() {
		return drafter;
	}
	public void setDrafter(String drafter) {
		this.drafter = drafter;
	}
	public int getApprovalNo() {
		return approvalNo;
	}
	public void setApprovalNo(int approvalNo) {
		this.approvalNo = approvalNo;
	}
	public int getReferrerNo() {
		return referrerNo;
	}
	public void setReferrerNo(int referrerNo) {
		this.referrerNo = referrerNo;
	}
	public String getAppTitle() {
		return appTitle;
	}
	public void setAppTitle(String appTitle) {
		this.appTitle = appTitle;
	}
	public String getAppContent() {
		return appContent;
	}
	public void setAppContent(String appContent) {
		this.appContent = appContent;
	}
	public String getAppDateStart() {
		return appDateStart;
	}
	public void setAppDateStart(String appDateStart) {
		this.appDateStart = appDateStart;
	}
	public String getAppDate() {
		return appDate;
	}
	public void setAppDate(String appDate) {
		this.appDate = appDate;
	}
	public String getAppDateEnd() {
		return appDateEnd;
	}
	public void setAppDateEnd(String appDateEnd) {
		this.appDateEnd = appDateEnd;
	}
	public String getAppState() {
		return appState;
	}
	public void setAppState(String appState) {
		this.appState = appState;
	}
	
}
