package groupware.schedule.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.ScheduleDao;
import groupware.beans.ScheduleDto;

@WebServlet(urlPatterns = "/schedule/scheduleComplete.kh")
public class ScheduleCompleteServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			ScheduleDto scheduleDto = new ScheduleDto();
//			scheduleDto.setSc_state(req.getParameter("sc_state"));
			String sc_state =req.getParameter("sc_state");
			
			scheduleDto.setSc_no(Integer.parseInt(req.getParameter("sc_no")));
			
//			String empNo =(String)req.getSession().getAttribute("id");
//			scheduleDto.setEmpNo(empNo); 
			
			ScheduleDao scheduleDao =new ScheduleDao();
			
			
			if(sc_state.equals("진행중")) {
				scheduleDao.complete(scheduleDto);
				resp.sendRedirect("scheduleSuccess.jsp");
			}else {
				scheduleDao.cancel(scheduleDto);
				resp.sendRedirect("scheduleSuccessCancel.jsp");
			}
			
		}catch(Exception e) {
			
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
