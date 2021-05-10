package groupware.beans;

public class boardDto {

	private int boardNo;
	private String empNo;
	private String boTitle;
	private String boType;
	private String boContent;
	private int boCount;
	private String boDate;
	private String empName;
	
	
	public boardDto() {
		super();
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getBoTitle() {
		return boTitle;
	}
	public void setBoTitle(String boTitle) {
		this.boTitle = boTitle;
	}
	public String getBoType() {
		return boType;
	}
	public void setBoType(String boType) {
		this.boType = boType;
	}
	public String getBoContent() {
		return boContent;
	}
	public void setBoContent(String boContent) {
		this.boContent = boContent;
	}
	public int getBoCount() {
		return boCount;
	}
	public void setBoCount(int boCount) {
		this.boCount = boCount;
	}
	public String getBoDate() {
		return boDate;
	}
	public void setBoDate(String boDate) {
		this.boDate = boDate;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	
	
}
