package groupware.schedule.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.DepartmentDao;
import groupware.beans.ScheduleDao;
import groupware.beans.ScheduleDto;

@WebServlet(urlPatterns = "/schedule/scheduleInsert.kh")
public class ScheduleInsertSertvlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			//준비: sc_no, sc_name, sc_content, sc_made, sc_deadline,dep_name
			
			//dep_name -> dep_no
			String dep_name =req.getParameter("dep_name");
			DepartmentDao departmentDao = new DepartmentDao();
			int dep_no =departmentDao.getDep_no(dep_name);
			
			
			
			//시퀀스 가져오기
			ScheduleDao scheduleDao = new ScheduleDao();
			int sequence = scheduleDao.getSequence();
			
			
			
			ScheduleDto scheduleDto =new ScheduleDto();
			scheduleDto.setSc_no(sequence); //시퀀스 뺴와서 해야한다.
			scheduleDto.setSc_name(req.getParameter("sc_name")); 
			scheduleDto.setSc_content(req.getParameter("sc_content"));
			scheduleDto.setSc_deadline(req.getParameter("sc_deadline"));
			
			String writer = (String)req.getSession().getAttribute("id");
			scheduleDto.setEmpNo(writer);
			scheduleDto.setDep_no(dep_no);
			
			scheduleDao.insert(scheduleDto);
			
			resp.sendRedirect("scheduleDetail.jsp?sc_no="+scheduleDto.getSc_no());
			
		}catch(Exception e) {
			
			e.printStackTrace();
			resp.sendError(500);
		}
		
		
		
	}
}
