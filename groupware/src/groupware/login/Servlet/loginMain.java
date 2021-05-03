package groupware.login.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.employeesDao;
import groupware.beans.employeesDto;

@WebServlet(urlPatterns = "/login/confirm")
public class loginMain extends HttpServlet{

	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

		req.setCharacterEncoding("UTF-8");
		
		employeesDao employeesdao = new employeesDao();
		
		employeesDto employeesdto = new employeesDto(req.getParameter("empNo"),req.getParameter("empPw"));
		
		boolean confirm = employeesdao.login(employeesdto);
		
		if(confirm) {
			
			resp.sendRedirect("http://localhost:8080/groupware/index.jsp");
		}
		else {
			resp.sendRedirect("http://localhost:8080/groupware/login/loginMainF.jsp");
		}
	}catch(Exception e) {
		
			e.printStackTrace();
			resp.sendError(500);
		}

	}
}
