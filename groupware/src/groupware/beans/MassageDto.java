package groupware.beans;

import java.sql.Date;

public class MassageDto {
	private int m_no;
	private String empNo;
	private String m_name;
	private Date m_date;
	private String m_content;

	
	private String receiver_no;
	
	
	
	public MassageDto() {
		super();
	}
	public int getM_no() {
		return m_no;
	}
	public void setM_no(int m_no) {
		this.m_no = m_no;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public Date getM_date() {
		return m_date;
	}
	public void setM_date(Date m_date) {
		this.m_date = m_date;
	}
	public String getM_content() {
		return m_content;
	}
	public void setM_content(String m_content) {
		this.m_content = m_content;
	}
	public String getReceiver_no() {
		return receiver_no;
	}
	public void setReceiver_no(String receiver_no) {
		this.receiver_no = receiver_no;
	}

	
	
}
