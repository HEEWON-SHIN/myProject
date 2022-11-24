
<%@page import="board.boardPage"%>
<%@page import="board.boardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <%-- JSTL라이브러리의 Formatting태그들을 사용하기 위해 taglib 지시자를 선언 --%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> 
<html class="no-js"> <!--<![endif]-->

	<%request.setCharacterEncoding("utf-8");	 %>

	<jsp:useBean id="bDao" class="board.boardDAO"/>
	<jsp:useBean id="bDto" class="board.boardDTO"/>
	
	
	<%
		
		/*사용자가 입력한 검색조건을 저장하기 위한 map 변수 선언
		Map<String, Object> map = new HashMap<String, Object>();//업캐스팅
		
		if(request.getParameter("searchWord") != null)map.put("searchWord", request.getParameter("searchWord"));
		
		if(request.getParameter("status") != null)map.put("status", request.getParameter("status"));
		
		if(request.getParameter("city") != null)map.put("city", request.getParameter("city"));
		
		if(request.getParameterValues("checkbox") != null){
			//선택한 체크박스들을 하나의 문자열로 저장
			String[] checkbox = request.getParameterValues("checkbox");
			String textcheckbox = new String();
			for(int i=0; i<checkbox.length; i++){
				textcheckbox += checkbox[i] + " ";
			}
			if(textcheckbox != null) map.put("checkbox", textcheckbox);
		}*/
		
		
		//사용자가 입력한 검색조건을 저장하기 위한 map 변수 선언
		Map<String, Object> map = new HashMap<String, Object>();//업캐스팅
		
		String searchWord = request.getParameter("searchWord");
		
		
		
		if(searchWord != null){//검색어를 입력했다면?
			map.put("searchWord", searchWord);//해시맵에 키, 값 형태로 저장
		}
		
		//board테이블에 지정한 검색 조건에 맞는 글이 몇 개 저장되어 있는지 조회 하기
		int totalCount = bDao.selectCount(map);
		
		
		/*****************************페이징 처리**********************************************/
		
		
		
		//한 페이지에 출력할 게시물 수
		int pageSize = 9; //우선은 9로 초기화 해놓고 페이지를 로딩하고 옵션태그에서 선택한 수로 초기화
		
			/* if(request.getParameter("per_page") != null || !request.getParameter("per_page").equals("")){
				pageSize = Integer.parseInt(request.getParameter("per_page")) ;
				
				System.out.print(request.getParameter("per_page"));
			} */
		/* try{
			if(request.getParameter("selected_option") == null || request.getParameter("selected_option").equals("")){
				pageSize = 9;
				
				System.out.print(request.getParameter("selected_option"));
				}else if(request.getParameter("selected_option") != null || !request.getParameter("selected_option").equals("")){
					pageSize = Integer.parseInt(request.getParameter("selected_option")) ;
					
					System.out.print(request.getParameter("selected_option"));
				}
			 
		}catch(Exception e){ 
			System.out.println("pageSize 초기화 실패 : " + e);
			e.printStackTrace();
		} */
		
		try{
			
			/* if(request.getParameter("per_page") == null || request.getParameter("per_page").equals("")){
				pageSize = 9;
				
				System.out.print(request.getParameter("per_page"));
				}else */ if(request.getParameter("per_page") != null || !request.getParameter("per_page").equals("")){
					pageSize = Integer.parseInt(request.getParameter("per_page")) ;
					
					System.out.print(request.getParameter("per_page"));
				}
			 
		}catch(Exception e){ 
			System.out.println("pageSize 초기화 실패 : " + e);
			e.printStackTrace();
		}
			
			 
			//pageSize변수 request객체에 저장
			request.setAttribute("pageSize", pageSize);
		
		//한 블록에 출력할 페이지 번호 갯수 4
		int blockPage = 4;
		
		//전체 페이지 수 구하기,,계산 결과는 무조건 올림 처리
		int totalPage = (int)Math.ceil((double)(totalCount / pageSize));
		
		//현재 보이는 화면의 페이지 번호 구하기,,처음에는 무조건 1페이지로 초기화 하고 사용자가 페이지 번호를 누르면 바뀐다.
		int pageNum = 1;
		
		//한 블록의 첫번째 번호를 나타내는 pageTemp변수
		String pageTemp = request.getParameter("pageNum");//boardPage쿼리스트링에 적은 값 넘겨줌
		
		if(pageTemp != null && !pageTemp.equals("")){//pageTemp로 넘어온 값이 있다면?=> 페이지 번호를 의미하는 <a>태그를 눌러서 그 페이지로 이동하면?
			
			pageNum = Integer.parseInt(pageTemp);//pageNum변수값을 클릭한(요청한) 페이지 번호로 초기화해주기
			
		}
		
		/*각 페이지에 출력할 게시물의 범위를 출력한다.*/
		//목록에 출력할 게시물의 범위를 계산해서 Map배열에 저장한다,,예를 들어 2번 페이지를 누르면 나올 첫글번호~마지막 글번호
		
		int start = (pageNum -1) * pageSize +1;//첫 게시물 번호
		
		int end = pageNum * pageSize;//마지막 게시물 번호
		
		//boardDao객체의 selectList메소드의 매개변수로 전달해서 SELECT문장을 완성시키기 위해서 범위의 시작값과 종료값을 HashMap배열에 저장
		map.put("start", start);
		map.put("end", end);
		
		/*s_board테이블에 저장된 글의 정보를 조회해오자(범위에 해당하는 게시물을 조회해서 가져옴)*/
		List<boardDTO> boardLists = bDao.selectList(map);
	  	
		pageContext.setAttribute("boardLists", boardLists);//page내장객체 영역에 boardLists 저장
	%>

    <jsp:include page="./inc/header.jsp"></jsp:include>
   
        <!-- End page header -->

	<body>

        <!-- property area -->
        <div class="properties-area recent-property" style="background-color: #FFF;">
            <div class="container">  
                <div class="row">
                     
                <div class="col-md-3 p0 padding-top-40">
                    <div class="blog-asside-right pr0">
                        <div class="panel panel-default sidebar-menu wow fadeInRight animated" >
                            <div class="panel-heading">
                                <h3 class="panel-title">Smart search</h3>
                            </div>
                            <div class="panel-body search-widget">
                                <form action="properties.jsp?per_page=${pageSize}" method="post" class=" form-inline"> 
                                    <fieldset>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <input type="text" class="form-control" placeholder="Key word" name="searchWord">
                                            </div>
                                        </div>
                                    </fieldset>

                    
									
									<fieldset >
                                        <div class="row">
                                            <div class="col-xs-12">  
                                                <input class="button btn largesearch-btn" value="Search" type="submit">
                                            </div>  
                                        </div>
                                    </fieldset>                                
                                                                    
                                </form>
                            </div>
                        </div>
                        <!-- 검색버튼 끝 -->

                        <div class="panel panel-default sidebar-menu wow fadeInRight animated">
                            <div class="panel-heading">
                                <h3 class="panel-title">Recommended</h3>
                            </div>
                            <div class="panel-body recent-property-widget">
                                        <ul>
                                        <li>
                                            <div class="col-md-3 col-sm-3 col-xs-3 blg-thumb p0">
                                                <a href="single.jsp"><img src="assets/img/demo/small-property-2.jpg"></a>
                                                <span class="property-seeker">
                                                    <b class="b-1">A</b>
                                                    <b class="b-2">S</b>
                                                </span>
                                            </div>
                                            <div class="col-md-8 col-sm-8 col-xs-8 blg-entry">
                                                <h6> <a href="single.jsp">Super nice villa </a></h6>
                                                <span class="property-price">3000000$</span>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="col-md-3 col-sm-3  col-xs-3 blg-thumb p0">
                                                <a href="single.jsp"><img src="assets/img/demo/small-property-1.jpg"></a>
                                                <span class="property-seeker">
                                                    <b class="b-1">A</b>
                                                    <b class="b-2">S</b>
                                                </span>
                                            </div>
                                            <div class="col-md-8 col-sm-8 col-xs-8 blg-entry">
                                                <h6> <a href="single.jsp">Super nice villa </a></h6>
                                                <span class="property-price">3000000$</span>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="col-md-3 col-sm-3 col-xs-3 blg-thumb p0">
                                                <a href="single.jsp"><img src="assets/img/demo/small-property-3.jpg"></a>
                                                <span class="property-seeker">
                                                    <b class="b-1">A</b>
                                                    <b class="b-2">S</b>
                                                </span>
                                            </div>
                                            <div class="col-md-8 col-sm-8 col-xs-8 blg-entry">
                                                <h6> <a href="single.jsp">Super nice villa </a></h6>
                                                <span class="property-price">3000000$</span>
                                            </div>
                                        </li>

                                        <li>
                                            <div class="col-md-3 col-sm-3 col-xs-3 blg-thumb p0">
                                                <a href="single.jsp"><img src="assets/img/demo/small-property-2.jpg"></a>
                                                <span class="property-seeker">
                                                    <b class="b-1">A</b>
                                                    <b class="b-2">S</b>
                                                </span>
                                            </div>
                                            <div class="col-md-8 col-sm-8 col-xs-8 blg-entry">
                                                <h6> <a href="single.jsp">Super nice villa </a></h6>
                                                <span class="property-price">3000000$</span>
                                            </div>
                                        </li>

                                    </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-9  pr0 padding-top-40 properties-page">
                    <div class="col-md-12 clear"> 
                        <div class="col-xs-10 page-subheader sorting pl0">
                            <ul class="sort-by-list">
                                <li class="active">
                                    <a href="javascript:void(0);" class="order_by_date" data-orderby="property_date" data-order="ASC">
                                        Property Date <i class="fa fa-sort-amount-asc"></i>					
                                    </a>
                                </li>
                                <li class="">
                                    <a href="javascript:void(0);" class="order_by_price" data-orderby="property_price" data-order="DESC">
                                        Property Price <i class="fa fa-sort-numeric-desc"></i>						
                                    </a>
                                </li>
                            </ul><!--/ .sort-by-list-->
							
							<!-- <script src="http://code.jquery.com/jquery-latest.min.js"></script>
							<script >
							function select_option() {
								
								var selected_ = $("#items_per_page").val();
								
								$.ajax({
										url:"select_option.jsp",
										type:"post",
										data:{selected_option:selected_},
										dataType:"text",
										success:function(res){
											location.href="properties.jsp";
										}
								});
							}
							
							</script>
 -->

                            <div class="items-per-page">
                                <label for="items_per_page"><b>Property per page :</b></label>
                                <div class="sel">
                                    <!-- <select id="items_per_page" name="per_page" onchange='location.href="properties.jsp"'> --> 
                                    <select id="items_per_page" name="per_page" onchange='location.href="properties.jsp?per_page="+this.value'>
                                    <!-- <select id="items_per_page" name="per_page" onchange="select_option()"> -->  
                                        <option >-Property per page-</option>
                                        <option value="6">6</option>
                                        <option value="9">9</option>
                                        <option value="10">10</option>
                                        <option value="12">12</option>
                                        <option value="15">15</option>
                                       
                                    </select>
                                </div><!--/ .sel-->
                            </div><!--/ .items-per-page-->
                        </div>

                        <div class="col-xs-2 layout-switcher">
                            <a class="layout-list" href="javascript:void(0);"> <i class="fa fa-th-list"></i>  </a>
                            <a class="layout-grid active" href="javascript:void(0);"> <i class="fa fa-th"></i> </a>                          
                        </div><!--/ .layout-switcher-->
                    </div>

					


					<!-- 게시물 목록 -->
                    <div class="col-md-12 clear"> 
                        <div id="list-type" class="proerty-th">
                        
                        	
                        
                        	<c:set var="virtualNum" value="0"/><%--화면상에서의 게시물 글번호 --%>
                        	<%--<c:set var="countNum" value="0"/> 글 번호를 의미하는 가상으로 증가시킬 변수 --%>
                        	<%	int countNum = 0; %>
                        	
                        	<c:forEach var="bDto" items="${boardLists}">
                        	
                        	<c:set var="virtualNum" value="<%=totalCount - (((pageNum-1) * pageSize) + countNum++) %>" scope="page"/>
                        	
                            <div class="col-sm-6 col-md-4 p0">
                                    <div class="box-two proerty-item">
                                    
                                    	<div hidden>${virtualNum}</div><!-- 화면에서 보이는 글번호,, 글번호란이 없으므로 일단 hidden으로 감춤 -->
                                    	
                                        <div class="item-thumb">
                                            <a href="property.jsp?number=${bDto.getNum()}" ><img src="upload/${bDto.getPic1()}"></a>
                                            <!-- 글제목,,클릭했을 때 내용 보여주는 페이지(property.jsp)로 이동하기 위해 <a>태그로 감싸준다
												 글번호를 기준으로 조회해오기 위해서  ?뒤에 키=값 형태로 넣어줌 -->			
                                        </div>

                                        <div class="item-entry overflow">
                                            <h5><a href="property.jsp?number=${bDto.getNum()}">${bDto.propertyname}</a></h5>
                                            <div class="dot-hr"></div>
                                            <span class="pull-left"><b> 면적(평) :</b> ${bDto.getArea()} </span>
                                            
                                            <%-- 가격 앞에 원화 기호 표시해 주기 --%>
                                            <fmt:formatNumber value="${bDto.getPrice()}" type="currency" var="price__"/>
                                            <span class="proerty-price pull-right">${price__}</span>
                                            
                                            
                                            <p style="display: none;">${bDto.getDescription()}</p>
                                            <div class="property-icon">
                                                <img src="assets/img/icon/bed.png">${bDto.getBedroom()}|
                                                <img src="assets/img/icon/shawer.png">${bDto.getBathroom()}|
                                                <img src="assets/img/icon/cars.png"> 
                                                									<c:if test = "${fn:contains(bDto.getCheckbox(), 'garage')}">
       																					  1
     																				 </c:if>
     																				 <%-- 'garage' 문자열 포함하면 1 출력 --%>
                                                									
                                                
                                            </div>
                                        </div>
                                    </div>
                                </div> 
                                
                                </c:forEach>

                               
                        </div>
                    </div>
                    
                    <div class="col-md-12"> 
                        <div class="pull-right">
                            <div class="pagination">
                                <ul>
                                    <!-- <li><a href="#">Prev</a></li>
                                    <li><a href="#">1</a></li>
                                    <li><a href="#">2</a></li>
                                    <li><a href="#">3</a></li>
                                    <li><a href="#">4</a></li>
                                    <li><a href="#">Next</a></li> -->
                                    
                                    <!-- 페이지 번호 -->
                                    <%= boardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI(), searchWord)
                                    																////포트넘버를 제외한 클라이언트가 요청한 context주소(ee/properties.jsp)
                                    %>
                                    
                                </ul>
                            </div>
                        </div>                
                    </div>
                </div>  
                </div>              
            </div>
        </div>

          <!-- Footer area-->
        <jsp:include page="./inc/footer.jsp"></jsp:include>
        
    </body>
</html>