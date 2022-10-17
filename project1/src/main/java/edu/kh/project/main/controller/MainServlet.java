package edu.kh.project.main.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.kh.project.main.model.service.MainService;

@WebServlet("/main")
public class MainServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		MainService service = new MainService();  //try 안으로 들어가도 무방
		
		try {
			// MAP 사용
			// 게시판 종류(BOARD-TYPE) 조회 서비스 호출 후 결과 반환 받기
			
			Map<Integer,String> boardTypeMap =  service.selectBoardType();
			
			// application scope로
			// key = "boardTypeMap"   //문자열
			// value = boardTypeMap이 참조하는 객체를 세팅  //변수명
			ServletContext application = req.getServletContext(); // applicaion scope 얻어오는 코드
			application.setAttribute("boardTypeMap", boardTypeMap);
			
			// main.jsp로 요청 위임
			RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/common/main.jsp");
			
			dispatcher.forward(req, resp);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
	
	}
	
}
