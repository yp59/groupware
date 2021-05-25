package groupware.attendance.Servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.AttendanceDao;
import groupware.beans.AttendanceDto;

@WebServlet(urlPatterns = "/attendance/leave.gw")
public class LeaveServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			AttendanceDto attendanceDto = new AttendanceDto();
			
			String empNo = (String)req.getSession().getAttribute("id");
			attendanceDto.setEmpNo(empNo);
			
			
			AttendanceDao attendanceDao = new AttendanceDao();
			attendanceDao.leave(attendanceDto);
			
			resp.sendRedirect("attendanceMain.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
