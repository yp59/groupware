package groupware.salary.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.SalaryAuthorityDao;
import groupware.beans.SalaryDto;

@WebServlet(urlPatterns = "/salary/salaryUpdate.gw")
public class SalaryUpdateServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
		
			req.setCharacterEncoding("UTF-8"); 
			
			SalaryDto salaryDto = new SalaryDto();
			
			salaryDto.setSalaryPay(Integer.parseInt(req.getParameter("salaryPay")));
			salaryDto.setSalaryOvertime(Integer.parseInt(req.getParameter("salaryOvertime")));
			salaryDto.setSalaryMeal(Integer.parseInt(req.getParameter("salaryMeal")));
			salaryDto.setSalaryTransportation(Integer.parseInt(req.getParameter("salaryTransportation")));
			
			
			SalaryAuthorityDao salaryauthorityDao =new SalaryAuthorityDao();
			salaryauthorityDao.edit(salaryDto);
			
			//출력
			resp.sendRedirect("salaryAuthority.jsp");
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
