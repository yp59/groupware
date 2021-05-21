package groupware.beans;

import java.sql.Date;

public class HolidayDto {
	private int holNo;
	private String empNo;
	private String holType;
	private String holContent;
	private Date holStart;
	private Date holEnd;
	private Date holWriteDate;
	
	
	public HolidayDto() {
		super();
	}
	public int getHolNo() {
		return holNo;
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
	public Date getHolStart() {
		return holStart;
	}
	public void setHolStart(Date holStart) {
		this.holStart = holStart;
	}
	public Date getHolEnd() {
		return holEnd;
	}
	public void setHolEnd(Date holEnd) {
		this.holEnd = holEnd;
	}
	public Date getHolWriteDate() {
		return holWriteDate;
	}
	public void setHolWriteDate(Date holWriteDate) {
		this.holWriteDate = holWriteDate;
	}
	
}
