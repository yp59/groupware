package groupware.beans;

public class approvalDto {

	
	private int appNo;
	private String drafter;
	private int midApprovalNo;
	private int finalApprovalNo;
	private int consesusNo;
	private int referrerNo;
	private int implementerNo;
	private String appTitle;
	private String appContent;
	private String appDateStart;
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

	public String getDrafter() {
		return drafter;
	}

	public void setDrafter(String drafter) {
		this.drafter = drafter;
	}

	public int getMidApprovalNo() {
		return midApprovalNo;
	}

	public void setMidApprovalNo(int midApprovalNo) {
		this.midApprovalNo = midApprovalNo;
	}

	public int getFinalApprovalNo() {
		return finalApprovalNo;
	}

	public void setFinalApprovalNo(int finalApprovalNo) {
		this.finalApprovalNo = finalApprovalNo;
	}

	public int getConsesusNo() {
		return consesusNo;
	}

	public void setConsesusNo(int consesusNo) {
		this.consesusNo = consesusNo;
	}

	public int getReferrerNo() {
		return referrerNo;
	}

	public void setReferrerNo(int referrerNo) {
		this.referrerNo = referrerNo;
	}

	public int getImplementerNo() {
		return implementerNo;
	}

	public void setImplementerNo(int implementerNo) {
		this.implementerNo = implementerNo;
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