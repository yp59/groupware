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

@WebFilter(urlPatterns = "/login/signUp.jsp")
public class SignUpFilter implements Filter {
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req =(HttpServletRequest)request;
		HttpServletResponse resp =(HttpServletResponse)response;
		
		
		try {
			req.setCharacterEncoding("UTF-8");
			
			int authLev = (int)req.getSession().getAttribute("authorityLevel");
			
			boolean enough = authLev==1;
			if(enough) {
				
				chain.doFilter(request, response);
				
			}else {
				resp.sendError(403);
			}
			
			
		}catch(Exception e) {
			
			e.printStackTrace();
			resp.sendError(500);
		}
		
		
	}
}
