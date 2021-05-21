package groupware.beans;

import java.sql.Date;

public class AttendanceDto {
	
	private Date attDate;
	private String empNo;
	private Date attAttend;
	private Date attLeave;
	private int attOvertime;

	public AttendanceDto() {
		super();
	}
	public Date getAttDate() {
		return attDate;
	}
	public void setAttDate(Date attDate) {
		this.attDate = attDate;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public Date getAttAttend() {
		return attAttend;
	}
	public void setAttAttend(Date attAttend) {
		this.attAttend = attAttend;
	}
	public Date getAttLeave() {
		return attLeave;
	}
	public void setAttLeave(Date attLeave) {
		this.attLeave = attLeave;
	}
	public int getAttOvertime() {
		return attOvertime;
	}
	public void setAttOvertime(int attOvertime) {
		this.attOvertime = attOvertime;
	}
	
	
}
