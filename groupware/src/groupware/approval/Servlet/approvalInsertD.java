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

@WebServlet(urlPatterns = "/approval/approvalInsert.gw")
public class approvalInsertD extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		try {
			req.setCharacterEncoding("UTF-8");
			
			//approval table 데이터 입력 코드//
			approvalDao approvaldao = new approvalDao();
			
			approvalDto approvaldto = new approvalDto();//approval table 데이터 입력
			approvaldto.setDrafter(req.getParameter("drafter"));
			approvaldto.setAppTitle(req.getParameter("appTitle"));
			approvaldto.setAppContent(req.getParameter("appContent"));
			approvaldto.setAppDateStart(req.getParameter("appDateStart"));
			approvaldto.setAppDateEnd(req.getParameter("appDateEnd"));

			approvaldao.approvalInsert(approvaldto);//기안자 제목 내용 기안일 마감일을 DB에 저장한다.
			
		
			
			//////////////////directapp, indirectapp table 공통 코드////////////////////////////////

			int appPK = approvaldao.pkKeyValue(approvaldto.getDrafter());//위에서 저장된approval table의 PK 키를 가져온다. 
		
	
			/////////////////////////direct table DB접속코드///////////////////////////////////
			directAppDao directappdao = new directAppDao();
			directAppDto directappdto = new directAppDto();
			
			String app = req.getParameter("approvalNo");
			String con = req.getParameter("consesusNo");
			
			String[] splitApp = app.split("&");//&구분자로 선택해서 결재자를 1명씩 배열에 넣는다.
			String[] splitCon = con.split("&");
			
			directappdto.setAppNo(appPK);//결재번호 지정
			
			for(String person : splitApp) {//결재자
				directappdto.setApproval(person.substring(person.length()-5,person.length()-1));
				//뒤에서 5번째와 1번째 사이의 문자열을 잘라내고 결재자로 저장한다. ex) 배정호[1000] --> 1000
				
				directappdto.setConsesus("0");;//결재 합의 구분 코드 0이면 결재 1이면 합의
				directappdao.directInsert(directappdto);//direct table 저장
			}
			for(String person : splitCon) {//합의자 저장 방식. 설명은 위에 코드와 같다.
				directappdto.setApproval(person.substring(person.length()-5,person.length()-1));
				directappdto.setConsesus("1");
				directappdao.directInsert(directappdto);
			}
			
			/////////////////////////indirect table DB접속코드///////////////////////////////////
			//참조 시행자는 결재 권한이 없다.
			
			indirectAppDao indirectappdao = new indirectAppDao();
			indirectAppDto indirectappdto = new indirectAppDto();
			
			String ref = req.getParameter("refferNo");
			String imp = req.getParameter("implemneterNo");
			
			
			String[] splitRef = ref.split("&");//&구분자로 선택해서 참조자를 1명씩 배열에 넣는다.
			String[] splitImp = imp.split("&");
			
			indirectappdto.setAppNo(appPK);//결재번호 지정
			
			for(String person : splitRef) {//참조자
				indirectappdto.setReferrer(person.substring(person.length()-5,person.length()-1));
				//뒤에서 5번째와 1번째 사이의 문자열을 잘라내고 참조자로 저장한다. ex) 배정호[1000] --> 1000
				
				indirectappdto.setType("참조");//참조자와 시행자는 결재권한이 없기 때문에 Type으로 구분한다.
				indirectappdao.indirectInsert(indirectappdto);//indirect table에 저장
				
			}
			for(String person : splitImp) {//시행자 위의 코드와 설명은 같다.
				indirectappdto.setReferrer(person.substring(person.length()-5,person.length()-1));
				indirectappdto.setType("시행");
				indirectappdao.indirectInsert(indirectappdto);
			}
			
			resp.sendRedirect(req.getContextPath()+"/approval/approvalInsertMain.jsp");//저장 후 main으로 보냄
			////////////////////////////////////////////////////////////////////////////////////
		
		}catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
		
	
	}
}
