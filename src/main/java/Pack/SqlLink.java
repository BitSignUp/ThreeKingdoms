package Pack;

import java.sql.*;
import java.util.*;

public class SqlLink  {
   static Connection conn = null;
   static Statement stat = null;
   PreparedStatement pstmt = null;
   PreparedStatement pstmt_voted = null;
   
   String url  = "jdbc:mysql://15.164.217.65:3306/world";
   String dbId = "cheetah";
   String dbPw = "1234";

   public SqlLink() {
      try {
         
         //동적 클래스 로드
         System.out.println("DB 접속 시도");
         
         Class.forName("com.mysql.cj.jdbc.Driver"); //DB연결 객체 생성
         conn = DriverManager.getConnection(url, dbId, dbPw);
         stat = conn.createStatement();
         
         System.out.println("DB 접속 완료");
         
      } catch (ClassNotFoundException e) {
         System.out.println(e.getMessage());
      } catch (Exception e) {
         System.out.println("DB 접속 실패"); 
         e.printStackTrace(System.out); 
      }

   }
   
   /**
    * DB 연결을 끊는다.
    */
   public void linkDisconnect(){
         try {
            
            if(pstmt!=null) pstmt.close();
            if(conn!=null) conn.close();
            
         } catch (SQLException e) { e.printStackTrace(); }
      
   }
   
   public Boolean isConnected() {
      return (conn != null) ? true : false; 
   }

   /**
    * 회원가입
    * - members 테이블에 새 row를 추가한다.
    */
   public int signUp(String id, String pw, String name, String birth) {
      
      if(!isConnected()) {
         System.out.println("DB 연결안됨");
         return 0;
      }
      
      // 입력 데이터 검사하기
      //
      //
      //

      String sql = "insert into members(id, pw, name, birth) values( ?,?,?,?)"; 
      int cnt = 0;
      try {
         pstmt = conn.prepareStatement(sql);

         pstmt.setString(1, id); 
         pstmt.setString(2, pw); 
         pstmt.setString(3, name); 
         pstmt.setString(4, birth);  

         cnt = pstmt.executeUpdate();
         
      } catch (SQLIntegrityConstraintViolationException e) {
         System.out.println("아이디가 중복되는 row가 존재");
         e.printStackTrace(); return -1;
      } catch (SQLException e) {
         e.printStackTrace(); 
         return -2;
      }

      return cnt;

   }
   
   public int doVote(String name, String id) {
	      System.out.println("투표완료");
	      // String sql_select = "insert into vote(id, count) values( ?, ?)";
	      String sql = "update vote set count=count+1 where name=?";  // 초선
	      String sql_date = "update members set voted=voted+1 where id=?";  // 로그인 id
	      int cnt = 0;
	      int cntt = 0;
	      try {
	    	 conn.setAutoCommit(false);
	    	 // 후보 투표수 1증가
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, name);  
	         cnt = pstmt.executeUpdate();
	         
	         // 내 투표일 업데이트
	         pstmt_voted = conn.prepareStatement(sql_date);
	         pstmt_voted.setString(1, id);
	         cntt = pstmt_voted.executeUpdate();
	         System.out.println(cnt + ", " + cntt);
	         if((cnt + cntt) == 2) {
	        	 conn.commit();
	         }
	         // sql 트랜잭션 
	      } catch (SQLException e) {
	    	  try {
	    	  conn.rollback();
	    	  }catch (SQLException ex) {}
	    	  e.printStackTrace();
	         
	    	  // 투표수 원래대로
	    	  // 실패
	         
	         return -2;
	      }

	      return cnt+cntt; // sql 쿼리 2개 모두가 성공하면 2 반환
	      
	   }

   /**
    * 입력한 아이디와 비밀번호가 일치하는지 확인한다.
    * @param   id
    * @param    pw
    * @return   입력한 아이디와 비밀번호가 일치하는 이름을 반환한다. 없다면 null이 반환된다.
    */
   public String checkLogin(String id, String pw) {
	      
	      if(!isConnected()) {
	            System.out.println("DB 연결안됨");
	            return null;
	         }
	      
	      String sql = "select name from members where id='"+ id +"' and pw='" + pw + "'";
	      String name = null;
	      try {
	         pstmt = conn.prepareStatement(sql);
	         ResultSet rs = pstmt.executeQuery();

	         while(rs.next()){

	            name = rs.getString("name");
	            System.out.println(name);
	         }
	         
	      } catch (SQLException e) { e.printStackTrace(); }
	      
//	      rs.close();

	      return name;
	      
	  }
   
   public int checkVoteCount() {
	   int count = 0;
	   if(!isConnected()) {
		   System.out.println("DB 연결안됨");
		   return -1;
	   }
	   String sql = "select count(*) from members";
	   try {
		   pstmt = conn.prepareStatement(sql);
		   ResultSet rs = pstmt.executeQuery();
		   // excute query 해주고 값을 받는다.
		   
		   while(rs.next()){

	            count = rs.getInt(1);
	            System.out.println(count);
	       }
		   //whilte(rs.next) rs/getInt()
	   } catch (SQLException e) { e.printStackTrace();}
	   return count;
   }
   
   public int getChoCount() {
	   int count = 0;
	   if(!isConnected()) {
		   System.out.println("DB 연결안됨");
		   return -1;
	   }
	   String sql = "select count from vote where name = '초선'";
	   try {
		   pstmt = conn.prepareStatement(sql);
		   ResultSet rs = pstmt.executeQuery();
		   // excute query 해주고 값을 받는다.
		   
		   while(rs.next()){

	            count = rs.getInt(1);
	            System.out.println(count);
	       }
		   //whilte(rs.next) rs/getInt()
	   } catch (SQLException e) { e.printStackTrace();}
	   return count;
   }
   public int getPoCount() {
	   int count = 0;
	   if(!isConnected()) {
		   System.out.println("DB 연결안됨");
		   return -1;
	   }
	   String sql = "select count from vote where name = '여포'";
	   try {
		   pstmt = conn.prepareStatement(sql);
		   ResultSet rs = pstmt.executeQuery();
		   // excute query 해주고 값을 받는다.
		   
		   while(rs.next()){

	            count = rs.getInt(1);
	            System.out.println(count);
	       }
		   //whilte(rs.next) rs/getInt()
	   } catch (SQLException e) { e.printStackTrace();}
	   return count;
   }
   public int getYouCount() {
	   int count = 0;
	   if(!isConnected()) {
		   System.out.println("DB 연결안됨");
		   return -1;
	   }
	   String sql = "select count from vote where name = '유비'";
	   try {
		   pstmt = conn.prepareStatement(sql);
		   ResultSet rs = pstmt.executeQuery();
		   // excute query 해주고 값을 받는다.
		   
		   while(rs.next()){

	            count = rs.getInt(1);
	            System.out.println(count);
	       }
		   //whilte(rs.next) rs/getInt()
	   } catch (SQLException e) { e.printStackTrace();}
	   return count;
   }
   
   /**
    * WOW
    * @param id
    * @param pw
    * @return
    */
   public int isvoted(String id, String pw) {
      if(!isConnected()) {
           System.out.println("DB 연결안됨");
           return 0;
        }
     
     String sql = "select voted from members where id='"+ id +"' and pw='" + pw + "'";
     int voted = 0;
     try {
        pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        while(rs.next()){

           voted = rs.getInt("voted");
           System.out.println(voted);
        }
        
     } catch (SQLException e) { e.printStackTrace(); }
     
//     rs.close();

     return voted;
   }
    /**
    * 회원가입 목록 전부 불러오기
    * @return members 전체 row
    */
   ResultSet getMembers() {
      System.out.println("getMembers 실행");
      
      String sql = "select * from members";
      ResultSet rs = null;
      try {
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
      } catch (SQLException e) {
         e.printStackTrace();
      }

//      rs.close();
      
      return rs;
      
   }
   
   
   ResultSet getMember(String id) {

      String sql = "select * from members where id=?";
      ResultSet rs = null;
      
      try {
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         rs = pstmt.executeQuery();
      } catch (SQLException e) { e.printStackTrace(); }

      return rs;
   }
   
   /**
    * Member의 row 항목을 수정한다.
    * @param    pwd
    * @param    email
    * @param    phone
    * @return   수정된 개수
    */
   int setMember(String pwd, String email, String phone, String id) {
      System.out.println("setMember 시작");

      String sql = "update members set pw=?, mail=?, phone=? where id=?";
      int cnt = 0;
      try {
         pstmt = conn.prepareStatement(sql);
         
         pstmt.setString(1, pwd);
         pstmt.setString(2, email);
         pstmt.setString(3, phone);
         pstmt.setString(4, id);

         cnt = pstmt.executeUpdate();
      } catch (SQLException e) { e.printStackTrace(); }

      return cnt;
   }
   
   /**
    * 멤버 삭제
    * @param   id
    * @return   삭제한 개수. 없다면 0.
    */
   int deleteMember(String id) {

      String sql = "delete from members where id=?";
      int cnt = 0;
      try {

         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         cnt = pstmt.executeUpdate();

      } catch (SQLException e) {
         e.printStackTrace();
      }

      return cnt;

   }
   
   
   /**
    * 방명록 불러오기
    * - guest 테이블의 모든 내용을 불러온다.
    */
   ResultSet getGuest() {

      String sql = "select * from guest";
      ResultSet rs = null;
      try {
         pstmt = conn.prepareStatement(sql);

         rs = pstmt.executeQuery();

         return rs;
//         while(rs.next()){
//
//            String name = rs.getString("name");
//            String upload_date = rs.getString("upload_date"); 
//            String contents = rs.getString("contents");
//            String id2 = rs.getString("id"); 
//            String guest_id = rs.getString("guest_id");
//
//            System.out.println(name + upload_date+ contents+id2 + guest_id); 
//         }

      } catch (SQLException e) { e.printStackTrace(); }
      
      return rs;
   }

   
   

   

   
}


