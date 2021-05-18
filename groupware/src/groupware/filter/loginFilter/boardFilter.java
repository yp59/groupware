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
import javax.servlet.http.HttpSession;

import groupware.beans.boardDao;
import groupware.beans.boardDto;
@WebFilter(urlPatterns = {
"/board/boardEdit.jsp","/board/boardDelete.gw","/board/boardEdit.gw"
})
public class boardFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		
	HttpServletRequest req = (HttpServletRequest)request;
	HttpServletResponse resp = (HttpServletResponse)response;
		try {
			req.setCharacterEncoding("UTF-8");
		
			int boardNo = Integer.parseInt(req.getParameter("boardNo"));//수정 삭제 시 해당 게시판 번호를 불러오는 명령어
			
			boardDao boarddao = new boardDao();
			boardDto boarddto = boarddao.detail(boardNo);//불러온 게시판 번호로 어떤 아이디가 게시판을 썼는지 알아낸다.
			
			String empNo = boarddto.getEmpNo(); //아이디 저장
			
		HttpSession session  = req.getSession();
		int authoritylevel = ((Integer)(session.getAttribute("authorityLevel"))).intValue();
		//관리자 권한으로 들어온 경우 작성자가 아니라도 수정 삭제 가능
			
		
		if(session.getAttribute("id").equals(empNo)){//게시글 작성자인 경우 필터링 제외
			chain.doFilter(request, response);
			
		}	
		else if(authoritylevel==1) {//관리자일 경우 필터링 제외
			chain.doFilter(request, response);
		}
		else {//둘다 아닐경우 필터링 적용
			resp.sendError(403);
		}
		}catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
			}
			
		
		
	}
	
}
