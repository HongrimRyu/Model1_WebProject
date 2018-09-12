package com.ithong.comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class CommentDAO implements iCommentDAO{

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
	public int idxCheck(int board, int num) {
		int max=-1;
		try {
			con=getConnection();
			sql="select max(c_idx) from comment where board_id=? && idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board);
			pstmt.setInt(2, num);
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
	public boolean attachComment(int board,CommentDTO cdto) {

		try {
			con = getConnection();
			sql="insert into comment (c_idx, idx, id, c_lev, c_seq, content,"+
			"ip, create_date, board_id,ref_id)"+
			"values (?,?,?,?,?,?,?,now(),?,?)";
			pstmt= con.prepareStatement(sql);
			pstmt.setInt(1, cdto.getC_idx());
			pstmt.setInt(2, cdto.getIdx());
			pstmt.setString(3, cdto.getId());
			pstmt.setInt(4, cdto.getC_lev());
			pstmt.setInt(5, cdto.getC_seq());
			pstmt.setString(6, cdto.getContent());
			pstmt.setString(7, cdto.getIp());
			pstmt.setInt(8, board);
			pstmt.setString(9, cdto.getId());
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
	public List<CommentDTO> getCommandList(int board,int num) {
		ArrayList<CommentDTO> al = new ArrayList<CommentDTO>();
		try {
			con=getConnection();
			sql= "select * "
				+" from comment where board_id=?&&idx=? order by c_idx desc, c_lev asc, c_seq desc ";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, board);
			pstmt.setInt(2, num);
			rs=pstmt.executeQuery();
			while(rs.next()){
				CommentDTO cdto = new CommentDTO();
				cdto.setIdx(rs.getInt("idx"));
				cdto.setId(rs.getString("id"));
				cdto.setC_idx(rs.getInt("c_idx"));
				cdto.setContent(rs.getString("content"));
				cdto.setIp(rs.getString("ip"));
				cdto.setCrate_date(rs.getTimestamp("create_date"));
				cdto.setDel_state(rs.getString("del_state"));
				cdto.setRef_id(rs.getString("ref_id"));
				cdto.setC_lev(rs.getInt("c_lev"));
				al.add(cdto);
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
	public CommentDTO getComment(int board,int idx,int c_idx) {
		try {
			con=getConnection();
			sql="select * from comment where board_id=? and idx=? and c_idx=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, board);
			pstmt.setInt(2, idx);
			pstmt.setInt(3, c_idx);
			rs=pstmt.executeQuery();
			if(rs.next()){
				CommentDTO cdto = new CommentDTO();
				cdto.setIdx(rs.getInt("idx"));
				cdto.setC_idx(rs.getInt("c_idx"));
				cdto.setId(rs.getString("id"));
				cdto.setContent(rs.getString("content"));
				cdto.setCrate_date(rs.getTimestamp("create_date"));
				return cdto;
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return null;
	}

	@Override
	public boolean updateComment(int board,CommentDTO cdto) {

		try{
			con = getConnection();
			sql="update comment set "
				+ "content=?, modifyIP=?, modifyID=?, modifyDate=now(), id=? where board_id=?&&idx=? && c_idx=? ";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, cdto.getContent());
			pstmt.setString(2, cdto.getIp());
			pstmt.setString(3, cdto.getId());
			pstmt.setString(4, cdto.getId());
			pstmt.setInt(5, board);
			pstmt.setInt(6, cdto.getIdx());
			pstmt.setInt(7, cdto.getC_idx());
			pstmt.executeUpdate();
			return true;
		}catch (Exception e) {
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
	public boolean replyComment(int board, CommentDTO cdto) {
		try {
			con = getConnection();
			sql="update comment set c_seq=c_seq+1 where board_id=? and idx=? and c_seq>?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board);
			pstmt.setInt(2, cdto.getIdx());
			pstmt.setInt(3, cdto.getC_seq());
			// 4 
			pstmt.executeUpdate();
			
			sql="insert into comment (c_idx, idx, id, c_lev, c_seq, content,"+
			"ip, create_date, board_id, ref_id)"+
			"values (?,?,?,?,?,?,?,now(),?,?)";
			pstmt= con.prepareStatement(sql);
			pstmt.setInt(1, cdto.getC_idx());
			pstmt.setInt(2, cdto.getIdx());
			pstmt.setString(3, cdto.getId());
			pstmt.setInt(4, cdto.getC_lev());
			pstmt.setInt(5, cdto.getC_seq()+1);
			pstmt.setString(6, cdto.getContent());
			pstmt.setString(7, cdto.getIp());
			pstmt.setInt(8, board);
			pstmt.setString(9, cdto.getRef_id());
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
   

	
	
	
	
}
