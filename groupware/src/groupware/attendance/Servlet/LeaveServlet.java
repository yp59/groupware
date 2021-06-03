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
			attendanceDao.leave(attendanceDto); //퇴근시간 update
			
			//업데이트된 퇴근시간 이용해 총 근무시간 update
			//업데이트된 총 근무시간 이용해서 추가 근무시간 계산 후 update
			if(attendanceDao.totaltime(empNo) && attendanceDao.overtime(empNo)) { //분단위
				resp.sendRedirect("attendanceMain.jsp");
				
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
