package groupware.beans;

import java.sql.Date;

public class HolidayDto {
	private int holNo;
	private String empNo;
	private String holType;
	private String holContent;
	private String holStart;
	private String holEnd;
	
	public int getHolNo() {
		return holNo;
		
	}public HolidayDto() {
		super();
	}

	public void setHolNo(int holNo) {
		this.holNo = holNo;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getHolType() {
		return holType;
	}
	public void setHolType(String holType) {
		this.holType = holType;
	}
	public String getHolContent() {
		return holContent;
	}
	public void setHolContent(String holContent) {
		this.holContent = holContent;
	}
	public String getHolStart() {
		return holStart;
	}
	public void setHolStart(String holStart) {
		this.holStart = holStart;
	}
	public String getHolEnd() {
		return holEnd;
	}
	public void setHolEnd(String holEnd) {
		this.holEnd = holEnd;
	}
	public Date getHolWriteDate() {
		return holWriteDate;
	}
	public void setHolWriteDate(Date holWriteDate) {
		this.holWriteDate = holWriteDate;
	}
	private Date holWriteDate;
	
	
	
	
}
