package groupware.salary.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.SalaryAuthorityDao;
import groupware.beans.SalaryDto;

@WebServlet(urlPatterns = "/salary/salaryEdit.gw")
public class SalaryEditServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
		
			req.setCharacterEncoding("UTF-8"); 
			
			SalaryDto salaryDto = new SalaryDto();
			
			int sumOvertime = (Integer.parseInt(req.getParameter("sumOvertime")));
			
			salaryDto.setEmpNo(req.getParameter("empNo"));
			salaryDto.setSalaryDate(req.getParameter("salaryDate"));
			salaryDto.setSalaryPay(Integer.parseInt(req.getParameter("salaryPay")));
			salaryDto.setSalaryOvertime(Integer.parseInt(req.getParameter("salaryOvertime"))*sumOvertime);
			salaryDto.setSalaryMeal(Integer.parseInt(req.getParameter("salaryMeal")));
			salaryDto.setSalaryTransportation(Integer.parseInt(req.getParameter("salaryTransportation")));
			
			
			SalaryAuthorityDao salaryauthorityDao =new SalaryAuthorityDao();
			salaryauthorityDao.edit(salaryDto);
			
			resp.sendRedirect("salaryAuthorityDetail.jsp?empNo="+salaryDto.getEmpNo()+"&salaryDate="+salaryDto.getSalaryDate());
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
