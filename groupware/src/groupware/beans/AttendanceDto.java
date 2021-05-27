package groupware.beans;

import java.sql.Date;

public class AttendanceDto {
	
	private String attDate;
	private String empNo;
	private String attAttend;
	private String attLeave;
	private float attOvertime;
	private float attTotaltime;
	private String empName;

	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
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
	public float getAttOvertime() {
		return attOvertime;
	}
	public void setAttOvertime(float attOvertime) {
		this.attOvertime = attOvertime;
	}
	public float getAttTotaltime() {
		return attTotaltime;
	}
	public void setAttTotaltime(float attTotaltime) {
		this.attTotaltime = attTotaltime;
	}
	

}
