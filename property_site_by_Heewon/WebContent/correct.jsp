<%@page import="javax.swing.text.Document"%>
<%@page import="board.boardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    
    trimDirectiveWhitespaces="true"
    %>
    
    
    <%request.setCharacterEncoding("utf-8"); %>
    <% String contextPath = request.getContextPath();%>
    
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <%-- JSTL라이브러리의 Formatting태그들을 사용하기 위해 taglib 지시자를 선언 --%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <!--  JSTL라이브러리의 Core주제 태그들을 사용하기 위해 taglib지시자를 선언 -->
    <%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> 
<html class="no-js"> <!--<![endif]-->
     <jsp:include page="./inc/header.jsp"></jsp:include>

        <!-- End page header -->

	

	
	<jsp:useBean id="bDao" class="board.boardDAO"/>
	
<%-- 	
	<%
		boardDTO bDto = bDao.selectView(request.getParameter("num"));
	
		request.setAttribute("bDto", bDto);
		
		boardDTO bDTO = (boardDTO)request.getAttribute("bDto");
	%> --%>

	<c:set var="bDto" value="${bDao.selectView(param.num)}"/>
	
	<% boardDTO bdto = (boardDTO)pageContext.getAttribute("bDto");	
	%>
	
	
	
	
	

	<body>
		
		
		
        <!-- property area -->
        <div class="content-area submit-property" style="background-color: #FCFCFC;">&nbsp;
            <div class="container">
                <div class="clearfix" > 
                    <div class="wizard-container"> 

                        <div class="wizard-card ct-wizard-orange" id="wizardProperty">
                        
                        
                            <form action="<%=contextPath%>/Board/correct_pro.jsp" method="post" enctype="multipart/form-data">                        
                                <div class="wizard-header">
                                    <h3>
                                        <b>Submit</b> YOUR PROPERTY <br>
                                        <small>Lorem ipsum dolor sit amet, consectetur adipisicing.</small>
                                    </h3>
                                </div>

                                <ul>
                                    <li><a href="#step1" data-toggle="tab">Step 1 </a></li>
                                    <li><a href="#step2" data-toggle="tab">Step 2 </a></li>
                                    <li><a href="#step3" data-toggle="tab">Step 3 </a></li>
                                    <li><a href="#step4" data-toggle="tab">Finished </a></li>
                                </ul>

                                <div class="tab-content">

                                    <div class="tab-pane" id="step1">
                                        <div class="row p-b-15  ">
                                            <h4 class="info-text"> Let's start with the basic information (with validation)</h4>
                                            <div class="col-sm-4 col-sm-offset-1">
                                                <div class="picture-container">
                                                    <div class="picture">
                                                        <img src="assets/img/default-property.jpg" class="picture-src" id="wizardPicturePreview" title=""/>
                                                                                                                	
                                                        <button id="btn1" onclick="$('.pic1').trigger('click'); return false;">파일 선택</button><input type="text" id="fileName1" value="${bDto.pic1}" readonly>
                                                        <input type="file" id="wizard-picture" class="pic1" name="picture1" value="${bDto.pic1}" style="opacity:0;" onchange="javascript:document.getElementById('fileName1').value=this.value"/>
                                                       		                                                     		
                                                       	<button id="btn2" onclick="$('.pic2').trigger('click'); return false;">파일 선택</button><input type="text" id="fileName2" value="${bDto.pic2}" readonly>
                                                        <input type="file" id="wizard-picture" class="pic2" name="picture2" value="${bDto.pic2}" style="opacity:0;" onchange="javascript:document.getElementById('fileName2').value=this.value"/>
                                                      
                                                        <button id="btn3" onclick="$('.pic3').trigger('click'); return false;">파일 선택</button><input type="text" id="fileName3" value="${bDto.pic3}" readonly>
                                                        <input type="file" id="wizard-picture" class="pic3" name="picture3" value="${bDto.pic3}" style="opacity:0;" onchange="javascript:document.getElementById('fileName3').value=this.value"/>
                                                        
                                                        <button id="btn4" onclick="$('.pic4').trigger('click'); return false;">파일 선택</button><input type="text" id="fileName4" value="${bDto.pic4}" readonly>
                                                        <input type="file" id="wizard-picture" class="pic4" name="picture4" value="${bDto.pic4}" style="opacity:0;" onchange="javascript:document.getElementById('fileName4').value=this.value"/>
                                                                                                       
                                                    </div> 
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>Property name <small>(required)</small></label>
                                                    <input name="propertyname" type="text" class="form-control" placeholder="Super villa ..." value="${bDto.propertyname}">
                                                </div>

                                                <div class="form-group">
                                                    <label>Property price <small>(required)</small></label>
                                                    <input name="price" type="text" class="form-control" placeholder="3330000" value="${bDto.price}">
                                                </div> 
                                                <div class="form-group">
                                                    <label>Telephone <small>(empty if you wanna use default phone number)</small></label>
                                                    <input name="phone" type="text" class="form-control" placeholder="+1 473 843 7436" value="${bDto.phone}">
                                                	
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--  End step 1 -->

                                    <div class="tab-pane" id="step2">
                                        <h4 class="info-text"> How much your Property is Beautiful ? </h4>
                                        <div class="row">
                                            <div class="col-sm-12"> 
                                                <div class="col-sm-12"> 
                                                    <div class="form-group">
                                                        <label>Property Description :</label>
                                                    		
                                                    		<%
                                                    			pageContext.setAttribute("br", "<br>");
                                                    			pageContext.setAttribute("n", "\r\n");
            		
                                                    		%>    
                                                        
                                                        <textarea name="description" class="form-control" >${fn:replace(bDto.description, br, n)}</textarea>
                                                    
                                                    
                                                    </div>  
                                                </div> 
                                            </div>

                                            <div class="col-sm-12">
                                                
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <label>Property City :</label>
                                                        <select id="lunchBegins" class="selectpicker" data-live-search="true" data-live-search-style="begins" title="Select your city" name="city">
                                                            <option <c:if test="${bDto.city eq 'Seoul'}">selected</c:if> >Seoul</option>
                                                            <option <c:if test="${bDto.city eq 'Busan'}">selected</c:if>>Busan</option>
                                                            <option <c:if test="${bDto.city eq 'Daegu'}">selected</c:if>>Daegu</option>
                                                            <option <c:if test="${bDto.city eq 'Daejeon'}">selected</c:if>>Daejeon</option>
                                                            <option <c:if test="${bDto.city eq 'Ulsan'}">selected</c:if>>Ulsan</option>
                                                            <option <c:if test="${bDto.city eq 'Jeju'}">selected</c:if>>Jeju</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <label>Property Statue  :</label>
                                                        <select id="basic" class="selectpicker show-tick form-control" name="status">
                                                            
                                                            <option <c:if test="${bDto.status eq 'Rent'}">selected</c:if>>Rent </option>
                                                            <option <c:if test="${bDto.status eq 'New'}">selected</c:if>>New</option>
                                                            <option <c:if test="${bDto.status eq 'Used'}">selected</c:if>>Used</option>  

                                                        </select>
                                                    </div>
                                                </div>
                                                
                                            </div>
                                            <div class="col-sm-12 padding-top-15">                                                   
                                                <div class="col-sm-4">
                                                    <div class="form-group">
                                                        <label for="property-geo">Min bed :</label>
                                                        <input type="range" data-slider-min="1" data-slider-max="10" value="${bDto.bedroom}" data-slider-step="1" id="min-bed"  name="bedroom"><br />
                                                        <b class="pull-left color">1</b> 
                                                        <b class="pull-right color">10</b>
                                                    </div>
                                                </div>
                                                <div class="col-sm-4">

                                                    <div class="form-group">
                                                        <label for="price-range">Min baths :</label>
                                                        <input type="range" data-slider-min="1" data-slider-max="5" value="${bDto.bathroom}" data-slider-step="1" id="min-baths" name="bathroom"><br />
                                                        <b class="pull-left color">1</b> 
                                                        <b class="pull-right color">5</b>
                                                    </div>
                                                </div>
                                                <div class="col-sm-4">

                                                    <div class="form-group">
                                                        <label for="property-geo">Property geo (평수) :</label>
                                                        <%-- <input type="range" class="span2" value="${bDto.area}" data-slider-min="3" 
                                                               data-slider-max="100" data-slider-step="1" 
                                                                id="property-geo" name="area"><br /> --%>
                                                        <input type="range" class="span2" data-slider-min="3" data-slider-max="100" value="${bDto.area}" data-slider-step="1" id="property-geo" name="area">
                                                        <b class="pull-left color">3</b> 
                                                        <b class="pull-right color">100</b>
                                                    </div>
                                                </div>   
                                            </div>
                                            <div class="col-sm-12 padding-top-15">
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <div class="checkbox">
                                                            <label>
                                                                <input type="checkbox" name="checkbox" value="pool" <c:if test="${fn:contains(bDto.checkbox, 'pool')}">checked</c:if>> Swimming Pool
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div> 
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <div class="checkbox">
                                                            <label>
                                                                <input type="checkbox" name="checkbox" value="laundry" <c:if test="${fn:contains(bDto.checkbox, 'laundry')}">checked</c:if>> Laundry Room
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>                                                 
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <div class="checkbox">
                                                            <label>
                                                                <input type="checkbox" name="checkbox" value="exit" <c:if test="${fn:contains(bDto.checkbox, 'exit')}">checked</c:if>> Emergency Exit
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>                                                 
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <div class="checkbox">
                                                            <label>
                                                                <input type="checkbox" name="checkbox" value="garage" <c:if test="${fn:contains(bDto.checkbox, 'garage')}">checked</c:if>> Garage 
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div> 
                                            </div> 
                                          
                                            <br>
                                        </div>
                                    </div>
                                    <!-- End step 2 -->

                                    <div class="tab-pane" id="step3">                                        
                                        <h4 class="info-text">Give us some images and videos ? </h4>
                                        <div class="row">  
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label for="property-images">Property video :</label>
                                                    <br>
                                                    <button onclick="$('.form-control').trigger('click'); return false;">파일 선택</button><input type="text" id="videoName" value="${bDto.video_real}" readonly>
                                                    <input class="form-control" type="file" id="property-images" name="video" value="${bDto.video_real}" style="opacity:0;" onchange="javascript:document.getElementById('videoName').value=this.value">
                                                    <p class="help-block">Select video for your property.</p>
                                                </div>
                                            </div>
                                            <div class="col-sm-6"> 
                                                <div class="form-group">
                                                   
                                                   <!-- 이름, pw, email, 글번호는 입력하지 않고 설정한 값을 그대로 넘겨주기 위해 hidden설정 --> 
                                                   
                                                    <input type="text" name="num" value="${bDto.num}" hidden>
                                                    <input type="text" name="name" value="${bDto.name}" hidden>
                                                    <input type="text" name="email" value="${bDto.email}" hidden>
                                                   
                                                    
                                                </div> 

                                                
                                            </div>
                                        </div>
                                    </div>
                                    <!--  End step 3 -->


                                    <div class="tab-pane" id="step4">                                        
                                        <h4 class="info-text"> Finished and submit </h4>
                                        <div class="row">  
                                            <div class="col-sm-12">
                                                <div class="">
                                                    <p>
                                                        <label><strong>Terms and Conditions</strong></label>
                                                        By accessing or using  GARO ESTATE services, such as 
                                                        posting your property advertisement with your personal 
                                                        information on our website you agree to the
                                                        collection, use and disclosure of your personal information 
                                                        in the legal proper manner
                                                    </p>

                                                    <div class="checkbox">
                                                        <label>
                                                            <input type="checkbox" /> <strong>Accept termes and conditions.</strong>
                                                        </label>
                                                    </div> 

                                                </div> 
                                            </div>
                                        </div>
                                    </div>
                                    <!--  End step 4 -->

                                </div>

                                <div class="wizard-footer">
                                    <div class="pull-right">
                                        <input type='button' class='btn btn-next btn-primary' name='next' value='Next' />
                                        <input type="submit" class='btn btn-finish btn-primary ' name='finish' value='Finish' />
                                    </div>

                                    <div class="pull-left">
                                        <input type='button' class='btn btn-previous btn-default' name='previous' value='Previous' />
                                    </div>
                                    <div class="clearfix"></div>                                            
                                </div>	
                            </form>
                        </div>
                        <!-- End submit form -->
                    </div> 
                </div>
            </div>
        </div>

          <!-- Footer area-->
       <jsp:include page="./inc/footer.jsp"></jsp:include>
        
        
  		<script src="assets/js/jquery.bootstrap.wizard.js" type="text/javascript"></script>
        <script src="assets/js/jquery.validate.min.js"></script>
        <script src="assets/js/wizard.js"></script>

    </body>
</html>