package edu.kh.jsp.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

							//_어노테이션 : 컴파일러가 읽는 주석(?)
@WebServlet("/login")  // web.xml에 작성하던 <servlet>, <servlet-mapping> 태그 대체 어노테이션
public class LoginServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// post 방식 요청 데이터 문자 인코딩 처리
		req.setCharacterEncoding("UTF-8");
		
		//전달 받은 파라미터를 얻어와 변수에 저장
		String id = req.getParameter("inputId");
		String pw = req.getParameter("inputPw");
		
		System.out.println(id);
		System.out.println(pw);
		
		String result = null;
		
		if(id.equals("user01") && pw.equals("pass01!")) {  // 아이디가 user01, 비밀번호가 pass01!인 경우
			result = "로그인 성공";
		} else {
			result = "아이디 또는 비밀번호가 일치하지 않습니다.";
		}
		
		// 응답 형식, 문자 인코딩 지정
//		resp.setContentType("text/html; charset=UTF-8");
//
//		// 클라이언트 응답용 스트림
//		PrintWriter out = resp.getWriter();
//		
//		out.println("<!DOCTYPE html>");
//		out.println("<html>");
//		
//		out.println("<head>");
//		out.println("<title>로그인 결과 페이지</title>");
//		out.println("</head>");
//
//		out.println("<body>");
//		out.println("<h1>로그인 결과</h1>");
//		out.printf("<h3 style='color:green;'> %s </h3>", result);
//		
//		out.println("<button type='button' onclick='history.back()'> 돌아가기 </button>");
//		out.println("</body>");
//		
//		out.println("</html>");
		
		//****************************************************
		
		// ** JSP로 응답하기 **
		
		// Dispatcher : 발송자, 필요한 정보를 제공하는 자, 역할을 넘긴다
		
		// RequestDistpatcher == 요청을 위임 역할의 객체
		// -> 정확히는 요청에 대한 응답화면을 만들어 
		// 	  클라이언트에게 출력하는 역할를 위임하는 객체

		// req.getRequestDispatcher("JSP 경로")
		// - HttpServletRequest 객체가 생성될 때
		//   내부에 요청을 위임하는 객체를 생성하는 방법을 포함하고 있음.
		
		// ** JSP 경로 작성 방법 ** ★★
		// - webapp폴더를 기준으로 파일 경로 작성
		
		// ex) /WEB-INF/views/loginResult.jsp
		// webapp 폴더 내부에 존재하는 WEB-INF 폴더, 
		// WEB-INF 폴더 내부에 존재하는 views 폴더,
		// views 폴더 내부에 존재하는 loginResult.jsp 파일 선택

		
		//_목적지를 정하기만 한 상태
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/loginResult.jsp");
		
		
		//_ req : 요청 관련 정보 데이터(속성, 값) / 클라이언트 정보  -> result 값 넣기
		//_ resp : 응답하는 방법(기능 위주) / 스트림, 쿠키
		
		// req.setAttribute(String key, Object value)
		// Attribute : 속성 == 데이터(값)
		
		req.setAttribute("r", result);  
							// Object로 업캐스팅 되어있는 상태
		//_ result는 String 이지만 Object 자리에 들어갈 수 있음(다형성:하나의 객체가 여러 형태를 띌 수 있다.)
		//_ 부모타입의 참조변수로 자식 객체를 참조(업캐스팅)
		
		
		
		dispatcher.forward(req, resp);
		/* 
		 ***** forward ***** ★★★★★
		 - 보내다, 전달하다, 전송하다  (포워딩)
		 - HttpServletRequest, HttpServletResponse를 매개변수로 전달
		   왜? JSP가 요청 데이터(req)를 이용해서 화면을 만들고
			  클라이언트에게 응답(resp)하기 위해서 매개변수로 전달.
		
		 - forward는 페이지 이동이 아닌 
		   Servlet의 역할 중 응답 화면 출력 역할을 분업한 
		   JSP에게 req, resp를 전달만 하는 것.
		   -> JSP가 응답을 대신할 뿐이다.
		   결론 : 페이지 이동 X -> 주소창의 요청 주소도 변하지 않는다!
		*/
 		
		
	
	}

}