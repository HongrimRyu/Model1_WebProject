package com.ithong.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO implements iBoardDAO{

	Connection con = null;
	String sql = "";
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	private Connection getConnection() throws Exception {

		/* 커넥션 풀을 사용방법 */
		// Context 객체 생성
		Context init = new InitialContext();
		// DataSource >> 디비연결 이름정보 가져오기
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/BSDB");
		// DataSource가져온 정보를 Connection 객체에 저장
		con = ds.getConnection();

		return con;
	}

	public void DBClose() {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}
	@Override
	public int maxIdx(int board) {
		int max=-1;
		try {
			con=getConnection();
			sql="select max(idx) from boards where board_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board);
			rs=pstmt.executeQuery();
			if(rs.next()){
				max=rs.getInt(1);
				return max;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return max;
	}

	@Override
	public boolean writeBoard(int board, BoardDTO bdto) {

		try {
			con = getConnection();
			sql="insert into boards (idx, id, subject, content,"+
			"create_ip,create_date,re_ref,re_lev,re_seq,board_id,file)"+
			"values (?,?,?,?,?,now(),?,?,?,?,?)";
			pstmt= con.prepareStatement(sql);
			pstmt.setInt(1, bdto.getIdx());
			pstmt.setString(2, bdto.getId());
			pstmt.setString(3, bdto.getSubject());
			pstmt.setString(4, bdto.getContent());
			pstmt.setString(5, bdto.getCreate_ip());
			pstmt.setInt(6, bdto.getRe_ref());
			pstmt.setInt(7, bdto.getRe_lev());
			pstmt.setInt(8, bdto.getRe_seq());
			pstmt.setInt(9, board);
			pstmt.setString(10, bdto.getFile());
			pstmt.executeUpdate();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		
		return false;
	}

	@Override
	public List<BoardDTO> getBoardList(int board, int startPage, int pageSize) {

		ArrayList<BoardDTO> al = new ArrayList<BoardDTO>();
		try {
			con=getConnection();
			sql= "select * "
				+" from boards where board_id=? order by re_ref desc,re_seq asc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, board);
			pstmt.setInt(2, startPage-1);
			pstmt.setInt(3, pageSize);
			rs=pstmt.executeQuery();
			while(rs.next()){
				BoardDTO bdto = new BoardDTO();
				bdto.setIdx(rs.getInt("idx"));
				bdto.setId(rs.getString("id"));
				bdto.setSubject(rs.getString("subject"));
				bdto.setContent(rs.getString("content"));
				bdto.setCreate_ip(rs.getString("create_ip"));
				bdto.setCreate_date(rs.getTimestamp("create_date"));
				bdto.setRe_ref(rs.getInt("re_ref"));
				bdto.setRe_lev(rs.getInt("re_lev"));
				bdto.setRe_seq(rs.getInt("re_seq"));
				bdto.setRead_count(rs.getInt("read_count"));
				bdto.setDel_state(rs.getBoolean("del_state"));
				bdto.setFile(rs.getString("file"));
				
				al.add(bdto);
			}
			return al;
			
		} catch (Exception e) {

			e.printStackTrace();
		}finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		
		return al;
	}
	@Override
	public List<BoardDTO> getBoardList(int board, int startPage, int pageSize,int main) {

		ArrayList<BoardDTO> al = new ArrayList<BoardDTO>();
		try {
			con=getConnection();
			sql= "select * "
				+" from boards where board_id=? and del_state=1 order by re_ref desc,re_seq asc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, board);
			pstmt.setInt(2, startPage-1);
			pstmt.setInt(3, pageSize);
			rs=pstmt.executeQuery();
			while(rs.next()){
				BoardDTO bdto = new BoardDTO();
				bdto.setIdx(rs.getInt("idx"));
				bdto.setId(rs.getString("id"));
				bdto.setSubject(rs.getString("subject"));
				bdto.setContent(rs.getString("content"));
				bdto.setCreate_ip(rs.getString("create_ip"));
				bdto.setCreate_date(rs.getTimestamp("create_date"));
				bdto.setRe_ref(rs.getInt("re_ref"));
				bdto.setRe_lev(rs.getInt("re_lev"));
				bdto.setRe_seq(rs.getInt("re_seq"));
				bdto.setRead_count(rs.getInt("read_count"));
				bdto.setDel_state(rs.getBoolean("del_state"));
				bdto.setFile(rs.getString("file"));
				
				al.add(bdto);
			}
			return al;
			
		} catch (Exception e) {

			e.printStackTrace();
		}finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		
		return al;
	}
	@Override
	public BoardDTO getBoard(int board,int num) {
		BoardDTO bdto = new BoardDTO();
		try {
			con=getConnection();
			sql= "select * from boards where board_id=?&&idx=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, board);
			pstmt.setInt(2, num);
			rs=pstmt.executeQuery();
			if(rs.next()){
				
				bdto.setIdx(rs.getInt("idx"));
				bdto.setId(rs.getString("id"));
				bdto.setSubject(rs.getString("subject"));
				bdto.setContent(rs.getString("content"));
				bdto.setCreate_ip(rs.getString("create_ip"));
				bdto.setCreate_date(rs.getTimestamp("create_date"));
				bdto.setRead_count(rs.getInt("read_count"));
				bdto.setFile(rs.getString("file"));
				bdto.setDel_state(rs.getBoolean("del_state"));
				bdto.setRe_lev(rs.getInt("re_lev"));
				bdto.setRe_ref(rs.getInt("re_ref"));
				bdto.setRe_seq(rs.getInt("re_seq"));
		
			}
			return bdto;
			
		} catch (Exception e) {

			e.printStackTrace();
		}finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		
		return bdto;
	}

	@Override
	public String getNick(String id) {
		String nick="";
		try {
			con=getConnection();
			sql= "select nick from members where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()){
				nick=rs.getString(1);

			}else nick=null;
			return nick;
			
		} catch (Exception e) {

			e.printStackTrace();
		}finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		
		return nick;
	}

	@Override
	public void updateCount(int board,int num) {
		try {
			con=getConnection();
			sql= "UPDATE boards SET read_count=read_count+1 where board_id=?&&idx=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, board);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
		
			
		} catch (Exception e) {

			e.printStackTrace();
		}finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
							
	}

	@Override
	public boolean updateBoard(int board,BoardDTO bdto) {
		try {
			con=getConnection();
			sql="update boards set subject=?, content=?, modify_id=?, modify_ip=?, modify_date=now(), file=? where board_id=?&&idx=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, bdto.getSubject());
			pstmt.setString(2, bdto.getContent());
			pstmt.setString(3, bdto.getModify_id());
			pstmt.setString(4, bdto.getModify_ip());
			pstmt.setString(5, bdto.getFile());
			pstmt.setInt(6, board);
			pstmt.setInt(7, bdto.getIdx());
			pstmt.executeUpdate();
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return false;
	}


	@Override
	public boolean deleteBoard(int board,BoardDTO bdto) {
		try {
			con=getConnection();
			sql="update boards set subject=?, content=?, id=?,modify_id=?, modify_ip=?, modify_date=now(), del_state=? where board_id=?&&idx=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, bdto.getSubject());
			pstmt.setString(2, bdto.getContent());
			pstmt.setString(3, bdto.getId());
			pstmt.setString(4, bdto.getModify_id());
			pstmt.setString(5, bdto.getModify_ip());
			pstmt.setBoolean(6, bdto.isDel_state());
			pstmt.setInt(7, board);
			pstmt.setInt(8, bdto.getIdx());
			pstmt.executeUpdate();
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return false;
	}

	
	
	public boolean reInsertBoard(int board, BoardDTO bdto){
		int num=0;
		
		try {
			// 1,2
			con = getConnection();
			// 3, select  최대 글번호 가져오기
			sql="select max(idx) from boards where board_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board);
			// 4 실행 및 저장
			rs = pstmt.executeQuery();
			// 5
			if(rs.next()){
				num =rs.getInt(1)+1;
			}
			
			// 답글 순서 재배치
			// 3  update  re_ref(같은그룹),re_seq(글 순서)
			//    글 순서의 값이 기존값보다 클경우
			//    순서를 변경 re_seq 1증가
			sql="update boards set re_seq=re_seq+1 where board_id=? and re_ref=? and re_seq>?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board);
			pstmt.setInt(2, bdto.getRe_ref());
			pstmt.setInt(3, bdto.getRe_seq());
			// 4 
			pstmt.executeUpdate();
			
			// 답글쓰기
			// 3  insert
			sql="insert into boards (idx, id, subject, content,"+
					"create_ip,create_date,re_ref,re_lev,re_seq,board_id,file)"+
					"values (?,?,?,?,?,now(),?,?,?,?,?)";
					pstmt= con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.setString(2, bdto.getId());
					pstmt.setString(3, bdto.getSubject());
					pstmt.setString(4, bdto.getContent());
					pstmt.setString(5, bdto.getCreate_ip());
					pstmt.setInt(6, bdto.getRe_ref());
					pstmt.setInt(7, bdto.getRe_lev()+1);
					pstmt.setInt(8, bdto.getRe_seq()+1);
					pstmt.setInt(9, board);
					pstmt.setString(10, bdto.getFile());
					
	
			// 4
			pstmt.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBClose();
		}
		
		
		return false;
	}

	@Override
	public List<BoardDTO> getBoardList(int board, int startPage, int pageSize, String search) {

		ArrayList<BoardDTO> al = new ArrayList<BoardDTO>();
		try {
			con=getConnection();
			sql= "select * "
				+"from boards where board_id=? and subject like ? and del_state=1 order by re_ref desc,re_seq asc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, board);
			System.out.println("%"+search+"%");
			pstmt.setString(2, "%"+search+"%");	
			pstmt.setInt(3, startPage-1);
			pstmt.setInt(4, pageSize);
			rs=pstmt.executeQuery();
			while(rs.next()){
				BoardDTO bdto = new BoardDTO();
				bdto.setIdx(rs.getInt("idx"));
				bdto.setId(rs.getString("id"));
				bdto.setSubject(rs.getString("subject"));
				bdto.setContent(rs.getString("content"));
				bdto.setCreate_ip(rs.getString("create_ip"));
				bdto.setCreate_date(rs.getTimestamp("create_date"));
				bdto.setRe_ref(rs.getInt("re_ref"));
				bdto.setRe_lev(rs.getInt("re_lev"));
				bdto.setRe_seq(rs.getInt("re_seq"));
				bdto.setRead_count(rs.getInt("read_count"));
				bdto.setDel_state(rs.getBoolean("del_state"));
				bdto.setFile(rs.getString("file"));
				
				al.add(bdto);
			}
			return al;
			
		} catch (Exception e) {

			e.printStackTrace();
		}finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		
		return al;
	}

	@Override
	public int maxIdx(int board, String search) {
		int max=-1;
		try {
			con=getConnection();
			sql="select max(idx) from boards where board_id=? and subject like and del_state=1 ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board);
			pstmt.setString(2, "%"+search+"%");	
			rs=pstmt.executeQuery();
			if(rs.next()){
				max=rs.getInt(1);
				return max;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return max;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}



















