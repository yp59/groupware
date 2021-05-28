package groupware.approval.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/approval/directIndirectAppInsert.gw")
public class approvalInsertD extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		try {
			req.setCharacterEncoding("UTF-8");
			
			String mid = req.getParameter("midApprovalNo");
			String fin = req.getParameter("finalApprovalNo");
			String con = req.getParameter("consesusNo");
			String ref = req.getParameter("refferNo");
			String imp = req.getParameter("implemneterNo");

			mid = mid.substring(mid.length()-5,mid.length()-1);
			fin = fin.substring(fin.length()-5,fin.length()-1);
			con = con.substring(con.length()-5,con.length()-1);
			ref = ref.substring(ref.length()-5,ref.length()-1);
			imp = imp.substring(imp.length()-5,imp.length()-1);//파라미터의 empNo을 서브스트링으로 추출
			
			
			
		}catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
		
	
	}
}
