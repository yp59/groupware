package groupware.beans;

import java.sql.Date;

public class SalaryDto {
	private String emp_no;
	private int po_no;
	private int salary_pay;
	private int salary_overtime;
	private int salary_meal;
	private int salary_transportation;
	private Date salary_date;
	
	public SalaryDto() {
		super();
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	
	public int getPo_no() {
		return po_no;
	}
	public void setPo_no(int po_no) {
		this.po_no = po_no;
	}
	public int getSalary_pay() {
		return salary_pay;
	}
	public void setSalary_pay(int salary_pay) {
		this.salary_pay = salary_pay;
	}
	public int getSalary_overtime() {
		return salary_overtime;
	}
	public void setSalary_overtime(int salary_overtime) {
		this.salary_overtime = salary_overtime;
	}
	public int getSalary_meal() {
		return salary_meal;
	}
	public void setSalary_meal(int salary_meal) {
		this.salary_meal = salary_meal;
	}
	public int getSalary_transportation() {
		return salary_transportation;
	}
	public void setSalary_transportation(int salary_transportation) {
		this.salary_transportation = salary_transportation;
	}
	
}
