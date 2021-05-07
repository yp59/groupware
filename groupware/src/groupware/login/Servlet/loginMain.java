package groupware.login.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import groupware.beans.employeesDao;
import groupware.beans.employeesDto;

@WebServlet(urlPatterns = "/login/confirm.gw")
public class loginMain extends HttpServlet{

	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
	
	
		req.setCharacterEncoding("UTF-8");
		
		employeesDao employeesdao = new employeesDao();
		
		employeesDto employeesdto = new employeesDto(req.getParameter("empNo"),req.getParameter("empPw"));
		
		HttpSession session = req.getSession();
		
		
		
		boolean confirm = employeesdao.login(employeesdto);
		
		if(confirm) {
			
			session.setAttribute("id", req.getParameter("empNo") );
			
			resp.sendRedirect(req.getContextPath());
		}
		else {
			resp.sendRedirect("http://localhost:8080/groupware/login/loginMain.jsp?error");
		}
	}catch(Exception e) {
		
			e.printStackTrace();
			resp.sendError(500);
		}

	}
}
