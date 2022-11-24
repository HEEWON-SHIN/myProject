package board;


/*페이지 바로가기 영역을 HTML문자열로 출력해주는 기능의 메소드가 작성된 클래스*/
//리턴값은 <a>태그로 각 페이지 번호에 그 페이지로 가는 링크를 출력해준다
public class boardPage {

	/*properties.jsp에서 페이징 처리를 끝낸 후에 HTML코드의 문자열로 반환시키는 메소드*/
	public static String pagingStr(int totalCount, int pageSize, int blockPage, int pageNum, String readUrl, String searchWord) {
		
		
		String pagingStr = "";//HTML코드를 나타내는 문자열이 저장될 변수
		
		/*전체 페이지의 수*/
		int totalPages = (int)(Math.ceil((double)totalCount / pageSize));
		
		
		
		int pageTemp = ( ( (pageNum-1) / blockPage )*blockPage ) + 1 ;
		
			if(pageTemp != 1) {//pageTemp변수 (페이지블록 번호)가 1일 아닐 때만 First, Prev 링크를 출력한다.
				
				pagingStr += "<li><a href='" + readUrl + "?pageNum=1'>First</a><li>";
				
				pagingStr += "&nbsp;";
				
					if(searchWord != null) {
						pagingStr += "<li><a href='" + readUrl + "?pageNum=" + (pageTemp-1) + "&per_page="+pageSize+"&searchWord="+searchWord+"'>Prev</a></li>";
					}else {
						pagingStr += "<li><a href='" + readUrl + "?pageNum=" + (pageTemp-1) + "&per_page="+pageSize+"'>Prev</a></li>";
					}
				
			}
		
			
			/*pageTemp를 1씩 증가시키면서 각 페이지 번호를 출력*/
			int blockCount = 1;
			
			while (blockCount <= blockPage && pageTemp <= totalPages) {//blockCount변수가 전체 블록 갯수와 같고, 
																		//한 페이지에 보여줄 페이지 블록의 첫번째 숫자가 전체 페이지와 같을 때까지 반복				
				
				if(pageTemp == pageNum) {//현재 보여지는 페이지에서는 링크를 걸지 않기 위해 조건식 걸어줌
					
					pagingStr += "&nbsp;<li><a>" + pageTemp + "</a></li>&nbsp;";
				}else {
					
					if(searchWord != null) {
						pagingStr += "&nbsp;<li><a href='" + readUrl + "?pageNum=" + pageTemp +"&per_page="+pageSize+ "&searchWord="+searchWord+"'>" + pageTemp +"</a></li>&nbsp;";
					}else {
						pagingStr += "&nbsp;<li><a href='" + readUrl + "?pageNum=" + pageTemp +"&per_page="+pageSize+"'>" + pageTemp +"</a></li>&nbsp;";
					}
					
				}
				
				
				pageTemp++;
				blockCount++;
				
			}//while문 끝
			
		
			if(pageTemp <= totalPages) {//클릭한 페이지 블록의 첫번째 번호가 전체 페이지의 갯수보다 작거나 같으면?
				
				if(searchWord != null) {
					pagingStr += "<li><a href='" + readUrl + "?pageNum="+ pageTemp +"&per_page="+pageSize+"&searchWord="+searchWord+"'>Next</a></li>&nbsp;";
				
					pagingStr += "<li><a href='"+ readUrl +"?pageNum="+ totalPages +"&per_page="+pageSize+"&searchWord="+searchWord+"'>Last</a></li>";
				}else {
					pagingStr += "<li><a href='" + readUrl + "?pageNum="+ pageTemp +"&per_page="+pageSize+"'>Next</a></li>&nbsp;";
					
					pagingStr += "<li><a href='"+ readUrl +"?pageNum="+ totalPages +"&per_page="+pageSize+"'>Last</a></li>";
				}
				
				
				
			}//if문 끝
			
			return pagingStr;//리턴값은 HTML문
			
			
		
	}
	
}
