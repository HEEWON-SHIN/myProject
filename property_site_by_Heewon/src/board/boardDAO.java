package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class boardDAO {
	
	/* DB작업 4총사 전역변수 선언 */
	Connection con;

	PreparedStatement pstmt;

	ResultSet rs;

	String sql;

	// 커넥션풀을 생성하고 커넥션풀 내부에 미리 연결을 맺은 Connection객체를 얻어 반환하는 메소드
	private Connection getConnection() throws Exception {

		// DB와 연결을 맺은 접속정보를 지닌 Connection객체를 저장할 변수
		Connection con = null;

		

		/*1. 커넥션풀 얻기★★★ */
		Context initCtx = new InitialContext();

		// 2. "java:comp/env"경로를 얻은 InitialContext객체를 얻는다.
		Context ctx = (Context) initCtx.lookup("java:comp/env");

		// 3. "java:comp/env" 아래에 위치한 "dacp_myoracle"자원을 얻어온다.
		DataSource source = (DataSource) ctx.lookup("dbcp_myoracle");

		// 커넥션풀 내부에 저장되어 있는 커넥션 객체 얻기(DB연결)
		con = source.getConnection();

		return con;

	}// getConnection메소드 끝

	public void close() {

		try {
			if (rs != null)// rs가 사용 중이라면..?
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();// 커넥션 풀로 Connection객체 사용 후 반납

			System.out.println("커넥션풀 공간에 Connection객체 사용 후 반납");

		} catch (Exception e) {
			e.printStackTrace();
		}

	}// close메소드 끝
	
	
	
	public int upload(boardDTO bDto) {
		
		int result = 0;
		
		try {
			
			con = getConnection();
			
			sql = "insert into s_board (video, video_real, picture1, pic1, picture2, pic2, picture3, pic3, picture4, pic4"
					+ ", num, name, email, phone, propertyname, price, status, area, bedroom, bathroom, description, pw, city, checkbox)"//22~
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?,"//비디오, 사진 업로드(?10번)
					+ "seq_board_num.nextval, ?, ?,  ?,  ?,  ?,  ?,  ?,  ?,  ? , ?,  ?,  ?,  ? )";
										//	 11	 12  13  14  15  16  17  18  19  20  21  22  23
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, bDto.getVideo());
			pstmt.setString(2, bDto.getVideo_real());
			
			pstmt.setString(3, bDto.getPicture1());
			pstmt.setString(4, bDto.getPic1());
			pstmt.setString(5, bDto.getPicture2());
			pstmt.setString(6, bDto.getPic2());
			pstmt.setString(7, bDto.getPicture3());
			pstmt.setString(8, bDto.getPic3());
			pstmt.setString(9, bDto.getPicture4());
			pstmt.setString(10, bDto.getPic4());
			
			
			pstmt.setString(11, bDto.getName());
			pstmt.setString(12, bDto.getEmail());
			pstmt.setString(13, bDto.getPhone());
			pstmt.setString(14, bDto.getPropertyname());
			pstmt.setString(15, bDto.getPrice());
			pstmt.setString(16, bDto.getStatus());
			pstmt.setString(17, bDto.getArea());
			pstmt.setString(18, bDto.getBedroom());
			pstmt.setString(19, bDto.getBathroom());
			
			pstmt.setString(20, bDto.getDescription());
	
			pstmt.setString(21, bDto.getPw());
			pstmt.setString(22, bDto.getCity());
			pstmt.setString(23, bDto.getCheckbox());
			
			result = pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			System.out.println("upload메소드 내부에서 에러 발생");
			e.printStackTrace();
		}finally {
			close();
		}
		
		
		 return result;
		
	}//upload메소드 끝
	
	
	/*조건에 맞는 글의 갯수를 조회해서 반환해주는 메소드 */
	public int selectCount(Map<String, Object> map) {
		
		int countNum = 0;
		
		try {
				con = getConnection();
				sql = "select count(*) from s_board";
			
					if(map.get("searchWord") != null && !map.get("searchWord").equals("")) {
						sql += "  where propertyname like '%" + map.get("searchWord") + "%' "
								+ " or DESCRIPTION like '%" + map.get("searchWord") + "%'"
								+ " or name like '%" + map.get("searchWord") + "%'"
								+ " or email like '%" + map.get("searchWord") + "%'"
								+ " or price like '%" + map.get("searchWord") + "%'"
								+ " or status like '%" + map.get("searchWord") + "%'"
								+ " or city like '%" + map.get("searchWord") + "%'"
								+ " or checkbox like '%" + map.get("searchWord") + "%'";
								
					}
					
					
					/*switch (key) {
					
					case "searchWord":
						sql += "propertyname like '%" + map.get("searchWord") + "%' "
								+ "or DESCRIPTION like '%" + map.get("searchWord") + "%'";
						System.out.println(map.get(key)+"aa");
						if(map.get(key)!=null && map.get(key).equals(map.get("searchWord"))) sql += "and";
						break;
						
					case "status":
						sql += "status ='" + map.get("status")+"'";
						System.out.println(map.get(key)+"bb");
						if(map.get(key)!=null && map.get(key).equals(map.get("status"))) sql += "and";
						break;
						
					case "city":
						sql += "city ='" + map.get("city")+"'";
						System.out.println(map.get(key)+"cc");
						if(map.get(key)!=null && map.get(key).equals(map.get("city"))) sql += "and";
						break;
						
					case "checkbox":
						sql += "checkbox = '" + map.get("checkbox")+"'";
						System.out.println(map.get(key)+"dd");
						if(map.get(key)!=null && map.get(key).equals(map.get("checkbox"))) sql += "and";
						break;
						
					default:
						break;
					}//switch-case문 끝		*/
								
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			rs.next();
			countNum = rs.getInt(1);//조회된 행의 갯수 저장
			
		} catch (Exception e) {
			System.out.println("count메소드 내부에서 에러 발생");
			e.printStackTrace();
		}finally {
			close();
		}
		
		return countNum;//조건에 해당하는 글의 총 갯수
		
	}//selectCount메소드 끝
	
	
	
	/*s_board테이블의 글정보(글내용, 레코드)를 조회해서 반환해주는 메소드*/
	public List<boardDTO> selectList(Map<String, Object> map){
		
		List<boardDTO> bvs = new Vector<boardDTO>();//글 정보를 하나씩(한 행씩) 저장할 가변길이 배열
		
		try {
			
			con = getConnection();
			sql = "select * from (select tb.*, rownum as rNUM "
					+ " from (select * from s_board  ";
			
			if(map.get("searchWord") != null && !map.get("searchWord").equals("")) {//검색어가 있으면 검색어 조건 추가해주기
				sql += "  where propertyname like '%" + map.get("searchWord") + "%' "
						+ " or DESCRIPTION like '%" + map.get("searchWord") + "%'"
						+ " or name like '%" + map.get("searchWord") + "%'"
						+ " or email like '%" + map.get("searchWord") + "%'"
						+ " or price like '%" + map.get("searchWord") + "%'"
						+ " or status like '%" + map.get("searchWord") + "%'"
						+ " or city like '%" + map.get("searchWord") + "%'"
						+ " or checkbox like '%" + map.get("searchWord") + "%'";
						
			}
			
			sql += "  order by num desc"
					+ ") tb"
					+ ") where rNum BETWEEN ? and ?";//글번호를 기준으로 범위 사이의 글 출력하기!
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, map.get("start").toString());//해시맵에 저장된 값은 int형이므로 String으로 캐스팅
			pstmt.setString(2, map.get("end").toString());
			
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				boardDTO bDto = new boardDTO();
				
				bDto.setNum(rs.getString(1));
				bDto.setName(rs.getString(2));
				bDto.setEmail(rs.getString(3));
				bDto.setPhone(rs.getString(4));
				bDto.setPropertyname(rs.getString(5));
				bDto.setPrice(rs.getString(6));
				bDto.setStatus(rs.getString(7));
				bDto.setArea(rs.getString(8));
				bDto.setBedroom(rs.getString(9));
				bDto.setBathroom(rs.getString(10));
				bDto.setDescription(rs.getString(11));
				bDto.setVideo_real(rs.getString(13));
				bDto.setPic1(rs.getString(15));
				bDto.setPic2(rs.getString(17));
				bDto.setPic3(rs.getString(19));
				bDto.setPic4(rs.getString(21));
				bDto.setCity(rs.getString(23));
				bDto.setCheckbox(rs.getString(24));
				
				bvs.add(bDto);
			}//while끝
			
			
		} catch (Exception e) {
			System.out.println("selectCount메소드 내부 오류 발생" + e);
			e.printStackTrace();
		}finally {
			close();
		}
		
		return bvs;
		
	}//selectList메소드 끝
	
	
	
	
	/*매개변수로 전달받은 글번호에 해당하는 글의 정보를 member테이블과 board테이블을 join하여 검색해오는 메소드*/
	public boardDTO selectView(String num) {
		
		boardDTO bDto = new boardDTO();
		
		try {
			
			con = getConnection();
			//SELECT문을 작성하는데 이 때, s_member테이블과 s_board테이블을 JOIN하여 조회해온다.
			sql = "select b.*, m.email from s_member m INNER JOIN s_board b"
					+ "  ON m.email=b.email where num = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				bDto.setNum(rs.getString(1));
				bDto.setName(rs.getString(2));
				bDto.setEmail(rs.getString(3));
				bDto.setPhone(rs.getString(4));
				bDto.setPropertyname(rs.getString(5));
				bDto.setPrice(rs.getString(6));
				bDto.setStatus(rs.getString(7));
				bDto.setArea(rs.getString(8));
				bDto.setBedroom(rs.getString(9));
				bDto.setBathroom(rs.getString(10));
				bDto.setDescription(rs.getString(11));
				bDto.setVideo_real(rs.getString(13));
				bDto.setPic1(rs.getString(15));
				bDto.setPic2(rs.getString(17));
				bDto.setPic3(rs.getString(19));
				bDto.setPic4(rs.getString(21));
				bDto.setCity(rs.getString(23));
				bDto.setCheckbox(rs.getString(24));
				
			}
			
			
		} catch (Exception e) {
			System.out.println("selectView메소드 내부 에러 발생 : " + e);
			e.printStackTrace();
		}finally {
			close();
		}
		
		return bDto;
		
	}//selectView메소드 끝
	
	
	
	/*삭제할 글번호를 매개변수로 받아서 DB의 board테이블에 저장된 글번호에 해당하는 글을 삭제하는 메소드*/
	//삭제에 성공하면 1 반환, 실패하면 0을 반환
	public int deletePost(String num) {
		
		int result = 0;//성공, 실패 여부값을 저장할 지역변수 선언
		
		try {
			
			//커넥션풀 및 커넥션 얻기
			con = getConnection();
			
			//매개변수로 전달받는 삭제할 글번호에 해당하는 글을 삭제시키는 DELETE구문 작성
			sql = "delete from s_board where num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, num);
			
			result = pstmt.executeUpdate();
			
			
			
		} catch (Exception e) {
			System.out.println("deletePost()메소드 내부에서 오류 발생" + e);
			e.printStackTrace();
			
			
			
		}finally {
			//자원해제
			close();
		}
			
		return result;
	}//deletePost메소드 끝
	
	
	public int correct(boardDTO bDto) {
		
		int result = 0;
		
		try {
				con = getConnection();
				
				sql = "select * from s_board where num=?";//혹은 "select pass from board where num=" + dto.getNum() 이렇게 적어도 됨!
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, bDto.getNum());
			
				rs = pstmt.executeQuery();
				
				
				if(rs.next()) {/*조건문 : 수정할 글번호에 해당되는 글이 조회가 된다면? true반환*/
					
						/*매개변수로 전달받은 BoardDTO객체의 num인스턴스변수에 저장된 
						  수정할 글번호에 해당하는 열의 값을 모두 수정! => UPDATE문 작성*/
						sql = "update s_board set video=?, video_real=?, picture1=?, pic1=?, picture2=?, pic2=?, picture3=?, pic3=?, picture4=?, pic4=?"
								+ ", phone=?, propertyname=?, price=?, status=?, area=?, bedroom=?, bathroom=?, description=?, city=?, checkbox=?"
								+ "   where num=?"; 						
												
						
						pstmt=con.prepareStatement(sql);
						
					
						
						pstmt.setString(1, bDto.getVideo());
						pstmt.setString(2, bDto.getVideo_real());
						pstmt.setString(3, bDto.getPicture1());
						pstmt.setString(4, bDto.getPic1());
						pstmt.setString(5, bDto.getPicture2());
						pstmt.setString(6, bDto.getPic2());
						pstmt.setString(7, bDto.getPicture3() );
						pstmt.setString(8, bDto.getPic3() );
						pstmt.setString(9, bDto.getPicture4() );
						pstmt.setString(10, bDto.getPic4());
						pstmt.setString(11, bDto.getPhone() );
						pstmt.setString(12, bDto.getPropertyname());
						pstmt.setString(13, bDto.getPrice() );
						pstmt.setString(14, bDto.getStatus() );
						pstmt.setString(15, bDto.getArea() );
						pstmt.setString(16, bDto.getBedroom() );
						pstmt.setString(17, bDto.getBathroom() );
						pstmt.setString(18, bDto.getDescription() );
						pstmt.setString(19, bDto.getCity() );
						pstmt.setString(20, bDto.getCheckbox() );
						pstmt.setString(21, bDto.getNum());
						
						result = pstmt.executeUpdate();
			
				}//if문 끝
			
		} catch (Exception e) {
			System.out.println("correct메소드 내부에서 오류 발생 : " + e);
			e.printStackTrace();
		}finally {
			close();
		}
		
		return result;
		
	}//correct메소드 끝
	
	
	/*글번호에 해당하는 비디오 파일명을 조회해오는 메소드*/
	public boardDTO videoSelect(String num){
			
		boardDTO bDto = new boardDTO();
			
		try {
			con = getConnection();
			
			
			sql = "select video, video_real from s_board where num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(num));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				
				
				bDto.setVideo(rs.getString("video"));
				bDto.setVideo_real(rs.getString("video_real"));
				
				
			}
			
		 
		} catch (Exception e) {
			System.out.println("videoSelect메소드 내부 오류 발생");
			e.printStackTrace();
		}finally {
			close();
		}
		
		return bDto;
		
	}//videoSelect메소드 끝
	
	

}
