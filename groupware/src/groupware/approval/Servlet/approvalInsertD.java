package groupware.approval.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.approvalDao;
import groupware.beans.approvalDto;
import groupware.beans.directAppDao;
import groupware.beans.directAppDto;
import groupware.beans.indirectAppDao;
import groupware.beans.indirectAppDto;

@WebServlet(urlPatterns = "/approval/directIndirectAppInsert.gw")
public class approvalInsertD extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		try {
			req.setCharacterEncoding("UTF-8");
			
			//approval table Insert 코드//
			approvalDao approvaldao = new approvalDao();
			
			approvalDto approvaldto = new approvalDto();
			approvaldto.setDrafter(req.getParameter("drafter"));
			approvaldto.setAppTitle(req.getParameter("appTitle"));
			approvaldto.setAppContent(req.getParameter("appContent"));
			approvaldto.setAppDateStart(req.getParameter("appDateStart"));
			approvaldto.setAppDateEnd(req.getParameter("appDateEnd"));

			approvaldao.approvalInsert(approvaldto);//Pk 키 없다고 오류 생기면 servlet 2개로 나눠서 해보자
			
			/////////////////////////////////////////////////////////////////
			
			//direct, indirect table 코드//
			
			//appNo를 구하는법 내가 올린 기안서 중 가장 큰 값 가져오면 되지 않을까?
			
			int appPK = approvaldao.pkKeyValue(req.getParameter("drafter"));
		
			/////////////////////////direct table DB접속코드///////////////////////////////////
			directAppDao directappdao = new directAppDao();
			directAppDto directappdto = new directAppDto();
			
			String app = req.getParameter("approvalNo");
			String con = req.getParameter("consesusNo");
			
			String[] splitApp = app.split("\n");
			String[] splitCon = con.split("\n");
			
			directappdto.setAppNo(appPK);
			
			for(String person : splitApp) {//결재자
				directappdto.setApproval(person.substring(person.length()-5,person.length()-1));
				directappdto.setConsesus("0");;//결재 합의 구분 코드
				directappdao.directInsert(directappdto);
				
			}
			for(String person : splitCon) {//합의자
				directappdto.setApproval(person.substring(person.length()-5,person.length()-1));
				directappdto.setConsesus("1");//결재 합의 구분 코드
				directappdao.directInsert(directappdto);
			}
			
			/////////////////////////indirect table DB접속코드///////////////////////////////////
			//참조 시행자는 결재 권한이 없다.
			
			indirectAppDao indirectappdao = new indirectAppDao();
			indirectAppDto indirectappdto = new indirectAppDto();
			
			
			String ref = req.getParameter("refferNo");
			String imp = req.getParameter("implemneterNo");
			
			
			String[] splitRef = ref.split("\n");
			String[] splitImp = imp.split("\n");
			
			indirectappdto.setAppNo(appPK);
			
			for(String person : splitRef) {//참조자
				indirectappdto.setReferrer(person.substring(person.length()-5,person.length()-1));
				indirectappdto.setType("참조");//결재 분류 참조
				indirectappdao.indirectInsert(indirectappdto);
				
			}
			for(String person : splitImp) {//시행자
				indirectappdto.setReferrer(person.substring(person.length()-5,person.length()-1));
				indirectappdto.setType("시행");//결재 분류 시행
				indirectappdao.indirectInsert(indirectappdto);
			}
			
			////////////////////////////////////////////////////////////////////////////////////
			
			
			/*	String test = "배정호[1001]\n"
				+ "배정로[1002]\n"
				+ "배정영[1003]\n"
				+ "배정하[1004]\n"
				+ "배정쿡[1005]\n"
				+ "배정투[1006]\n";
		String[] test2 = test.split("\n");
		
		for(String x : test2) {
			
			
			 x.substring(x.length()-5,x.length()-1);

		}*/
			
			
		}catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
		
	
	}
}
