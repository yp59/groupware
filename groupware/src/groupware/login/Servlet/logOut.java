package groupware.login.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = "/login/logOut.gw")
public class logOut extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			HttpSession session = req.getSession();
			
			session.setAttribute("id", null);
			
			resp.sendRedirect(req.getContextPath());
		}catch(Exception e) {
			
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
