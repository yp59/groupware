package groupware.salary.Servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.SalaryAuthorityDao;
import groupware.beans.employeesDao;
import groupware.beans.employeesDto;

@WebServlet(urlPatterns = "/salary/salaryAuthorityInsertAll.gw")
public class SalaryInsertAllServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			employeesDao employeesDao = new employeesDao();
			List<employeesDto> employeesList = employeesDao.list();
			
			SalaryAuthorityDao salayAuthorityDao = new SalaryAuthorityDao();
			
			String pattern = "yyyy-MM"; 
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
			String date = simpleDateFormat.format(new Date());
			
			salayAuthorityDao.insertAll(employeesList, date);
			
			resp.sendRedirect("salaryAuthority.jsp");
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
