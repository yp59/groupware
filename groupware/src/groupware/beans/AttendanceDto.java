package groupware.beans;

import java.sql.Date;

public class AttendanceDto {
	
	private String attDate;
	private String empNo;
	private String attAttend;
	private String attLeave;
	private int attOvertime;

	public AttendanceDto() {
		super();
	}
	public String getAttDate() {
		return attDate;
	}
	public void setAttDate(String attDate) {
		this.attDate = attDate;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getAttAttend() {
		return attAttend;
	}
	public void setAttAttend(String attAttend) {
		this.attAttend = attAttend;
	}
	public String getAttLeave() {
		return attLeave;
	}
	public void setAttLeave(String attLeave) {
		this.attLeave = attLeave;
	}
	public int getAttOvertime() {
		return attOvertime;
	}
	public void setAttOvertime(int attOvertime) {
		this.attOvertime = attOvertime;
	}
	
	
}
