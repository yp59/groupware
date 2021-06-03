package groupware.salary.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.SalaryAuthorityDao;

@WebServlet(urlPatterns = "/salary/salaryDelete.gw")
public class SalaryDeleteSevlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			String empNo = req.getParameter("empNo");
			String salaryDate = req.getParameter("salaryDate");
			
			SalaryAuthorityDao salaryAuthorityDao = new SalaryAuthorityDao();
			salaryAuthorityDao.delete(empNo, salaryDate);
			
			resp.sendRedirect("salaryAuthority.jsp");
		}
		catch(Exception e) {
			
		}
	}
}
