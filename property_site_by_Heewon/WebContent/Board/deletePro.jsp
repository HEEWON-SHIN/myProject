
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%request.getParameter("utf-8"); %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <%-- JSTL라이브러리의 Formatting태그들을 사용하기 위해 taglib 지시자를 선언 --%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
    
    <jsp:useBean id="bDao" class="board.boardDAO"/>
    <% String contextPath = request.getContextPath();%>
    <%-- <% String num = (String)request.getAttribute("num");
    	int check = bDao.deletePost(num);
    %> --%>
    <c:set var="check" value="${bDao.deletePost(param.num)}"/>
    
    <c:choose>
    	<c:when test="${check == 1 }">
	    	<script>	
	    		alert("글이 삭제됐습니다.");
	    		location.href="<%=contextPath%>/properties.jsp";	    		
	    	</script>	
	    </c:when>	
	    
	    <c:otherwise>
	    	<script>	
    			alert("글 삭제에 실패했습니다.");
    			history.back();
    		</script>		    
	    </c:otherwise>
    </c:choose>

