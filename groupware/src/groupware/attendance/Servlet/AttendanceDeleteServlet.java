package groupware.attendance.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.AttendanceDao;

@WebServlet(urlPatterns = "/attendance/attendanceDelete.gw")
public class AttendanceDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			String empNo = req.getParameter("empNo");
			String attDate = req.getParameter("attDate");
			
			AttendanceDao attendanceDao = new AttendanceDao();
			attendanceDao.delete(empNo, attDate);
			
			resp.sendRedirect("attendanceAuthorityMain.jsp");
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
