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

import groupware.beans.SalaryDao;
import groupware.beans.ScheduleDao;

@WebFilter(urlPatterns = {"/salary/salaryAuthority.jsp","/salary/salaryAuthorityDetail.jsp","/salary/salaryAuthorityEdit.jsp",
		"/salary/salaryAuthorityInsert.jsp","/salary/salaryDelete.gw","/salary/salaryEdit.gw","/salary/salaryInsert.gw"	
})

public class SalaryFilter implements Filter {
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest req =(HttpServletRequest)request;
		HttpServletResponse resp =(HttpServletResponse)response;
		
		try {
			req.setCharacterEncoding("UTF-8");
		
			int authorityLevel = (int)req.getSession().getAttribute("authorityLevel");
					
			boolean pass = authorityLevel==1;
			if(pass) { // 관리자만 가능
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
