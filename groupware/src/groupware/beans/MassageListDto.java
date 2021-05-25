package groupware.beans;

import java.sql.Date;

public class MassageListDto  {
	private int m_no;
//	private String empNo; //발신자 사원번호
	private String m_name;
	private Date m_date;
	private String m_content;
	private String emp_name; //발신자

	
//	private String e2_no;	//수신자 사원번호
	private String e2_name;	//수신자
	public MassageListDto() {
		super();
	}
	public int getM_no() {
		return m_no;
	}
	public void setM_no(int m_no) {
		this.m_no = m_no;
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

	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public String getE2_no() {
		return e2_no;
	}
	public void setE2_no(String e2_no) {
		this.e2_no = e2_no;
	}
	public String getE2_name() {
		return e2_name;
	}
	public void setE2_name(String e2_name) {
		this.e2_name = e2_name;
	}
	
	
	
	
}
