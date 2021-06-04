package groupware.beans;

import java.sql.Date;

public class MassageFileDto {
	private int m_no;
	private String empNo;
	private String m_name;
	private Date m_date;
	private String m_content;
	private String receiver_no;
	
	private String emp_name; //발신자
	private String e2_no;	//수신자 사원번호
	private String e2_name;	//수신자
	
	private int file_no;
	private String file_upload_name;
	private String file_save_name;
	private String file_content_type;
	private long file_size;
	private int file_origin;
	public MassageFileDto() {
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
	public int getFile_no() {
		return file_no;
	}
	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}
	public String getFile_upload_name() {
		return file_upload_name;
	}
	public void setFile_upload_name(String file_upload_name) {
		this.file_upload_name = file_upload_name;
	}
	public String getFile_save_name() {
		return file_save_name;
	}
	public void setFile_save_name(String file_save_name) {
		this.file_save_name = file_save_name;
	}
	public String getFile_content_type() {
		return file_content_type;
	}
	public void setFile_content_type(String file_content_type) {
		this.file_content_type = file_content_type;
	}
	public long getFile_size() {
		return file_size;
	}
	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}
	public int getFile_origin() {
		return file_origin;
	}
	public void setFile_origin(int file_origin) {
		this.file_origin = file_origin;
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
