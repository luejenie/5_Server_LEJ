package edu.kh.project.common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebFilter(filterName="logoutFilter", urlPatterns = {"/member/signUp"})
public class LogoutFilter extends HttpFilter implements Filter {
       
	public void init(FilterConfig fConfig) throws ServletException {
		System.out.println("로그아웃 상태인지 검사하는 필터 초기화");
	}

	
    public void destroy() {
    	System.out.println("로그아웃 상태인지 검사하는 필터 파괴");
    }
    
    
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// place your code here
		
		// 로그인 상태를 검사하는 방법
		// == session에 loginMember가 null이 아닌지 검사
		
		// Session 객체는 HttpServletRequest에서만 얻어올 수 있다.
		// -> 다운캐스팅 필요    (부모객체에서 얻어오기 위해서는 다운캐스팅 필요)
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response; // 리다이렉트용
		
		HttpSession session = req.getSession();
		
		// 로그인 상태인 경우
		if(session.getAttribute("loginMember") != null){
			
			session.setAttribute("message", "로그인 상태로는 이용할 수 없습니다.");
			resp.sendRedirect("/");  //메인페이지 재요청(날려버리자)
		
		} else {  // 로그아웃 상태인 경우
			// pass the request along the filter chain
			chain.doFilter(request, response);
		}
		
	}

}
