//package groupware.filter.loginFilter;
//
//import java.io.IOException;
//
//import javax.servlet.Filter;
//import javax.servlet.FilterChain;
//import javax.servlet.ServletException;
//import javax.servlet.ServletRequest;
//import javax.servlet.ServletResponse;
//import javax.servlet.annotation.WebFilter;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import groupware.beans.ScheduleDao;
//
//
//
//@WebFilter(urlPatterns = {"/schedule/scheduleEdit.jsp",
//"/schedule/scheduleEdit.kh","/schedule/scheduleDelete.kh","/schedule/scheduleComplete.kh",
//"/schedule/scheduleCancel.kh"		
//})
//
//
//public class ScheduleFilter implements Filter{
//	@Override
//	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
//			throws IOException, ServletException {
//		
//		HttpServletRequest req =(HttpServletRequest)request;
//		HttpServletResponse resp =(HttpServletResponse)response;
//		
//		try {
//			req.setCharacterEncoding("UTF-8");
//			
//			String empNo =(String)req.getSession().getAttribute("id");
//			
//			int authLev = (int)req.getSession().getAttribute("authorityLevel");
//			
//			ScheduleDao scheduleDao = new ScheduleDao();
//			String maker =scheduleDao.maker(empNo);
//			
//			boolean amI=empNo.equals(maker);
//			boolean enough = authLev==1||authLev==2;
//			if(enough) {
//				chain.doFilter(request, response);
//				
//			} else if(amI) { //작성자가 나 라면
//				chain.doFilter(request, response);
//				
//			}
//			
//			
//			else {
//				resp.sendError(403);
//			}
//			
//			
//			
//			
//			
//			
//		}catch(Exception e) {
//			e.printStackTrace();
//			resp.sendError(500);
//			
//			
//		}
//		
//	}
//}
