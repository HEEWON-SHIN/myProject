<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    
    trimDirectiveWhitespaces="true"
    %>
    
    <%
    
    	request.setCharacterEncoding("utf-8");
    
   		String selected_option = request.getParameter("selected_option");
   		
   		request.setAttribute("selected_option", selected_option);
    
    
    %>
