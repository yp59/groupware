package groupware.salary.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.SalaryAuthorityDao;
import groupware.beans.SalaryDto;

@WebServlet(urlPatterns = "/salary/salaryInsert.gw")
public class SalaryInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			SalaryDto salaryDto = new SalaryDto();
			salaryDto.setEmpNo(req.getParameter("empNo"));
			salaryDto.setSalaryDate(req.getParameter("payDate"));
			salaryDto.setSalaryPay(Integer.parseInt(req.getParameter("payBasic")));
			salaryDto.setSalaryOvertime(Integer.parseInt(req.getParameter("payOvertime")));
			salaryDto.setSalaryMeal(Integer.parseInt(req.getParameter("payMeal")));
			salaryDto.setSalaryTransportation(Integer.parseInt(req.getParameter("payTransportation")));
			
			SalaryAuthorityDao salaryAuthorityDao = new SalaryAuthorityDao();
			salaryAuthorityDao.insert(salaryDto);
			
			resp.sendRedirect("salaryAuthority.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
			
		}
	}
}
