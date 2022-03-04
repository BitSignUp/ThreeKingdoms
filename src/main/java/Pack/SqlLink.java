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
         
         //���� Ŭ���� �ε�
         System.out.println("DB ���� �õ�");
         
         Class.forName("com.mysql.cj.jdbc.Driver"); //DB���� ��ü ����
         conn = DriverManager.getConnection(url, dbId, dbPw);
         stat = conn.createStatement();
         
         System.out.println("DB ���� �Ϸ�");
         
      } catch (ClassNotFoundException e) {
         System.out.println(e.getMessage());
      } catch (Exception e) {
         System.out.println("DB ���� ����"); 
         e.printStackTrace(System.out); 
      }

   }
   
   /**
    * DB ������ ���´�.
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
    * ȸ������
    * - members ���̺� �� row�� �߰��Ѵ�.
    */
   public int signUp(String id, String pw, String name, String birth) {
      
      if(!isConnected()) {
         System.out.println("DB ����ȵ�");
         return 0;
      }
      
      // �Է� ������ �˻��ϱ�
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
         System.out.println("���̵� �ߺ��Ǵ� row�� ����");
         e.printStackTrace(); return -1;
      } catch (SQLException e) {
         e.printStackTrace(); 
         return -2;
      }

      return cnt;

   }
   
   public int doVote(String name, String id) {
	      System.out.println("��ǥ�Ϸ�");
	      // String sql_select = "insert into vote(id, count) values( ?, ?)";
	      String sql = "update vote set count=count+1 where name=?";  // �ʼ�
	      String sql_date = "update members set voted=voted+1 where id=?";  // �α��� id
	      int cnt = 0;
	      int cntt = 0;
	      try {
	    	 conn.setAutoCommit(false);
	    	 // �ĺ� ��ǥ�� 1����
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, name);  
	         cnt = pstmt.executeUpdate();
	         
	         // �� ��ǥ�� ������Ʈ
	         pstmt_voted = conn.prepareStatement(sql_date);
	         pstmt_voted.setString(1, id);
	         cntt = pstmt_voted.executeUpdate();
	         System.out.println(cnt + ", " + cntt);
	         if((cnt + cntt) == 2) {
	        	 conn.commit();
	         }
	         // sql Ʈ����� 
	      } catch (SQLException e) {
	    	  try {
	    	  conn.rollback();
	    	  }catch (SQLException ex) {}
	    	  e.printStackTrace();
	         
	    	  // ��ǥ�� �������
	    	  // ����
	         
	         return -2;
	      }

	      return cnt+cntt; // sql ���� 2�� ��ΰ� �����ϸ� 2 ��ȯ
	      
	   }

   /**
    * �Է��� ���̵�� ��й�ȣ�� ��ġ�ϴ��� Ȯ���Ѵ�.
    * @param   id
    * @param    pw
    * @return   �Է��� ���̵�� ��й�ȣ�� ��ġ�ϴ� �̸��� ��ȯ�Ѵ�. ���ٸ� null�� ��ȯ�ȴ�.
    */
   public String checkLogin(String id, String pw) {
	      
	      if(!isConnected()) {
	            System.out.println("DB ����ȵ�");
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
		   System.out.println("DB ����ȵ�");
		   return -1;
	   }
	   String sql = "select count(*) from members";
	   try {
		   pstmt = conn.prepareStatement(sql);
		   ResultSet rs = pstmt.executeQuery();
		   // excute query ���ְ� ���� �޴´�.
		   
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
		   System.out.println("DB ����ȵ�");
		   return -1;
	   }
	   String sql = "select count from vote where name = '�ʼ�'";
	   try {
		   pstmt = conn.prepareStatement(sql);
		   ResultSet rs = pstmt.executeQuery();
		   // excute query ���ְ� ���� �޴´�.
		   
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
		   System.out.println("DB ����ȵ�");
		   return -1;
	   }
	   String sql = "select count from vote where name = '����'";
	   try {
		   pstmt = conn.prepareStatement(sql);
		   ResultSet rs = pstmt.executeQuery();
		   // excute query ���ְ� ���� �޴´�.
		   
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
		   System.out.println("DB ����ȵ�");
		   return -1;
	   }
	   String sql = "select count from vote where name = '����'";
	   try {
		   pstmt = conn.prepareStatement(sql);
		   ResultSet rs = pstmt.executeQuery();
		   // excute query ���ְ� ���� �޴´�.
		   
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
           System.out.println("DB ����ȵ�");
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
    * ȸ������ ��� ���� �ҷ�����
    * @return members ��ü row
    */
   ResultSet getMembers() {
      System.out.println("getMembers ����");
      
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
    * Member�� row �׸��� �����Ѵ�.
    * @param    pwd
    * @param    email
    * @param    phone
    * @return   ������ ����
    */
   int setMember(String pwd, String email, String phone, String id) {
      System.out.println("setMember ����");

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
    * ��� ����
    * @param   id
    * @return   ������ ����. ���ٸ� 0.
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
    * ���� �ҷ�����
    * - guest ���̺��� ��� ������ �ҷ��´�.
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


