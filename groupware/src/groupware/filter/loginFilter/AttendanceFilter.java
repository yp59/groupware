package groupware.filter.loginFilter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebFilter(urlPatterns = {"/attendance/attendanceAuthorityMain.jsp","/attendance/attendanceAuthorityDetail.jsp","/attendance/attendanceEdit.jsp",
		"/attendance/attendanceDelete.gw","/attendance/attendanceEdit.gw"
})

public class AttendanceFilter implements Filter{
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest req =(HttpServletRequest)request;
		HttpServletResponse resp =(HttpServletResponse)response;
		
		try {
			req.setCharacterEncoding("UTF-8");
		
			int authorityLevel = (int)req.getSession().getAttribute("authorityLevel");
					
			boolean pass = authorityLevel==1;
			if(pass) { // 관리자
				chain.doFilter(request, response);
				
			}
			else {
				resp.sendError(403);
			}		
			
		}catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
			
			
		}
	}

}
