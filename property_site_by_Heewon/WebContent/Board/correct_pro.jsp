<%@page import="java.util.Enumeration"%>
<%@page import="board.boardDTO"%>
<%@page import="board.boardDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%request.setCharacterEncoding("utf-8"); %>

    <jsp:useBean id="bDto" class="board.boardDTO"/>
    <jsp:useBean id="bDao" class="board.boardDAO"/>
    
    <jsp:setProperty property="name" name="bDto" value="${param.name}"/>
	<jsp:setProperty property="email" name="bDto" value="${param.email}"/>
	
	
	<jsp:setProperty property="phone" name="bDto" value="${param.phone}"/>
	<c:if test="${empty param.phone}">
		<jsp:setProperty property="phone" name="bDto" value="${UserPhone}"/>
	</c:if>
	
	<%-- <jsp:setProperty property="propertyname" name="bDto" value="${param.propertyname}"/>
	<jsp:setProperty property="price" name="bDto" value="${param.price}"/>
	<jsp:setProperty property="city" name="bDto" value="${param.city}"/>
	<jsp:setProperty property="status" name="bDto" value="${param.status}"/>
	<jsp:setProperty property="bedroom" name="bDto" value="${param.bedroom}"/>
	<jsp:setProperty property="bathroom" name="bDto" value="${param.bathroom}"/>
	<jsp:setProperty property="area" name="bDto" value="${parma.area}"/> --%>
	
	
	<%
	
	
		//업로드한 파일이 업로드될 경로 설정
		String directory = application.getRealPath("/upload/");//웹프로젝트의 upload폴더로 바로 가게 설정
	
		//한번에 업로드할 수 있는 파일의 최대 사이즈 지정 1GB(1024MB)
		int maxSize = 1024 * 1024 *1024;
		
		//실제 파일업로드 담당하는 클래스는? cos.jar압축파일 내부에 존재하는 MultipartRequest클래스.
		MultipartRequest multipartRequest;
		
		multipartRequest = new MultipartRequest(request, directory, maxSize, "utf-8", new DefaultFileRenamePolicy());
		
		
		/****파일 업로드 변수 지정,,picture, video변수들은 다시 초기화******************************************************/				
		
		
		
		bDto.setPicture1(multipartRequest.getOriginalFileName("picture1"));
		bDto.setPic1(multipartRequest.getFilesystemName("picture1"));
		
		bDto.setPicture2(multipartRequest.getOriginalFileName("picture2"));
		bDto.setPic2(multipartRequest.getFilesystemName("picture2"));
		
		
		
		bDto.setPicture3(multipartRequest.getOriginalFileName("picture3"));
		bDto.setPic3(multipartRequest.getFilesystemName("picture3"));
		
		bDto.setPicture4(multipartRequest.getOriginalFileName("picture4"));
		bDto.setPic4(multipartRequest.getFilesystemName("picture4"));
		
			if(multipartRequest.getOriginalFileName("video") != null){
		
				bDto.setVideo(multipartRequest.getOriginalFileName("video"));
				bDto.setVideo_real(multipartRequest.getFilesystemName("video"));
			}			
	
			
			//****선택된 체크박스들 받아오기*********************************************
			String[] checkbox = multipartRequest.getParameterValues("checkbox");
			
			/* 
			for(int i=0; i<checkbox.length; i++){
				System.out.print(checkbox[i]);
			} */
			//배열에 있는 내용을 하나의 스트링으로 저장
			String textcheckbox = new String();
			
			for(int i = 0; i<checkbox.length; i++){
				textcheckbox += checkbox[i] + " ";
			}
			
			
			bDto.setCheckbox(textcheckbox); 
		
			bDto.setNum(multipartRequest.getParameter("num"));
			bDto.setPropertyname(multipartRequest.getParameter("propertyname"));
			bDto.setPrice(multipartRequest.getParameter("price"));
			bDto.setCity(multipartRequest.getParameter("city"));
			bDto.setStatus(multipartRequest.getParameter("status"));
			bDto.setBedroom(multipartRequest.getParameter("bedroom"));
			bDto.setBathroom(multipartRequest.getParameter("bathroom"));
			bDto.setArea(multipartRequest.getParameter("area"));
			
			
			
			
			String description = multipartRequest.getParameter("description");
			
			
			
			description = description.replace("\r\n","<br>");
			
			bDto.setDescription(description);
			
			
		int result = bDao.correct(bDto);//업로드 성공하면 1, 실패하면 0 반환
		
		
		
	if(result != 1){
	%>
	<script type="text/javascript">
		alert("글을 수정하지 못했습니다.");
		history.back();
	</script>
	
	<%
		}else{ 
	%>
	<script type="text/javascript">
		alert("글이 수정되었습니다.");
		location.href="../properties.jsp";
	</script>
	<%
		}
	
	%>
    