package groupware.board.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.BoardCommentsDao;
import groupware.beans.BoardCommentsDto;

@WebServlet(urlPatterns = "/board/comDelete.gw")
public class BoardCommentsDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : 파라미터(댓글번호, 원본글번호), 세션(회원번호)
			req.setCharacterEncoding("UTF-8");
			BoardCommentsDto boardCommentsDto = new BoardCommentsDto();
			boardCommentsDto.setComNo(Integer.parseInt(req.getParameter("comNo")));
			boardCommentsDto.setBoardNo(Integer.parseInt(req.getParameter("boardNo")));
			
			String empNo = (String)req.getSession().getAttribute("id");
			boardCommentsDto.setEmpNo(empNo);
			
			//댓글 삭제
			BoardCommentsDao boardCommentsDao = new BoardCommentsDao();
			boardCommentsDao.delete(boardCommentsDto);
			//댓글 개수 갱신
//			BoardDao boardDao = new BoardDao();
//			boardDao.refreshBoardReply(replyDto.getReplyOrigin());
			
			//출력
			resp.sendRedirect("boardDetail.jsp?boardNo="+boardCommentsDto.getBoardNo());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
