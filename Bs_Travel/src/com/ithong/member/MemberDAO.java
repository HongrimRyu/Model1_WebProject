package com.ithong.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO implements iMemberDAO {

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
	public List<String> idCheck() {
		ArrayList<String> t = new ArrayList<String>();
		try {
			con = getConnection();
			sql = "select id from members";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				t.add(rs.getString(1));
			}
			return t;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return t;
	}

	@Override
	public List<String> nickCheck() {
		ArrayList<String> t = new ArrayList<String>();
		try {
			con = getConnection();
			sql = "select nick from members";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				t.add(rs.getString(1));
			}
			return t;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return t;
	}

	@Override
	public boolean insertMembers(MemberDTO mb) {
		try {
			con = getConnection();
			sql = "insert into members (id,pass,nick,name,age,gender,email,addr,phone,creip,date,exdate)"
					+ " value (?,?,?,?,?,?,?,?,?,?,now(),now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPass());
			pstmt.setString(3, mb.getNick());
			pstmt.setString(4, mb.getName());
			pstmt.setInt(5, mb.getAge());
			pstmt.setString(6, mb.getGender());
			pstmt.setString(7, mb.getEmail());
			pstmt.setString(8, mb.getAddr());
			pstmt.setString(9, mb.getPhone());
			pstmt.setString(10, mb.getCreip());

			// 4단계 sql 객체 실행
			pstmt.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return false;
	}

	@Override
	public int[] loginCheck(String id, String pass, String ip) {
		int[] check= {0,0};//{로그인처리상태, 비밀번호만료시 안내};
		try {
			con=getConnection();
			sql="select pass from members where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()){
				if(rs.getString(1).equals(pass)){
				sql="select datediff(now(),exdate) from members where id=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs=pstmt.executeQuery();
				if(rs.next()){
				    int expired = Integer.parseInt(rs.getString(1));
				    System.out.println("expired:"+expired);
					sql="update members set clogip=?, clogdate=now() where id=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, ip);
					pstmt.setString(2, id);
					pstmt.executeUpdate();
					check[0]=1;
					if(expired >= 90){
						check[1]=1;
					}
					return check;
				}
				}else return check;
			}else return check;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		
		check[0]=-1;
		return check;
	}

	@Override
	public MemberDTO searchMember(String id) {
		MemberDTO md=null;
		try {
			con=getConnection();
			sql="select * from members where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			while(rs.next()){
				md=new MemberDTO();
				md.setId(rs.getString("id"));
				md.setPass(rs.getString("pass"));
				md.setNick(rs.getString("nick"));
				md.setName(rs.getString("name"));
				md.setAge(rs.getInt("age"));
				md.setGender(rs.getString("gender"));
				md.setEmail(rs.getString("email"));
				md.setAddr(rs.getString("addr"));
				md.setPhone(rs.getString("phone"));
				md.setExdate(rs.getTimestamp("exdate"));
			
	
			}
			return md;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return md;
	}

	@Override
	public int updateMember(MemberDTO mb, boolean pass) {
		int check=0;
		try {
			con = getConnection();
			sql="select pass from members where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			rs=pstmt.executeQuery();
			if(rs.next()){
				if(rs.getString(1).equals(mb.getPass())){
				// 3단계 sql 객체 생성
				if(pass){
				sql = "update members set pass=?,nick=?,age=?,gender=?,email=?"
						+",addr=?,phone=?, exdate=now(),modifyip=?,modifyid=?,modifydate=now(),pw_legacy=? where id=? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mb.getPass());
				pstmt.setString(2, mb.getNick());
				pstmt.setInt(3, mb.getAge());
				pstmt.setString(4, mb.getGender() );
				pstmt.setString(5, mb.getEmail());
				pstmt.setString(6, mb.getAddr());
				pstmt.setString(7, mb.getPhone());
				pstmt.setString(8, mb.getModifyip());
				pstmt.setString(9 , mb.getId());
				pstmt.setString(10, mb.getLegacy_pw());
				pstmt.setString(11, mb.getId());
				System.out.println("실행");
				}else{
				sql = "update members set nick=?,age=?,gender=?,email=?"
						+",addr=?,phone=?,modifyip=?,modifyid=?,modifydate=now() where id=? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mb.getNick());
				pstmt.setInt(2, mb.getAge());
				pstmt.setString(3, mb.getGender() );
				pstmt.setString(4, mb.getEmail());
				pstmt.setString(5, mb.getAddr());
				pstmt.setString(6, mb.getPhone());
				pstmt.setString(7, mb.getModifyip());
				pstmt.setString(8, mb.getId());
				pstmt.setString(9, mb.getId());
				System.out.println("실행2");
				}
				// 4단계 sql 객체 실행
				pstmt.executeUpdate();
				check=1;
				return check;
				}
			else{
					check=-1;
					return check;
				}
			}else{ 
				check=-1;
				return check;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return check;
	}

	@Override
	public ArrayList<MemberDTO> getMemberList(int num) {
		ArrayList<MemberDTO> al = new ArrayList<MemberDTO>();
		try {
			con =getConnection();
			sql="select * from members limit 0,?";
			pstmt= con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			while(rs.next()){
				MemberDTO mdto = new MemberDTO();
				mdto.setId(rs.getString("id")); 
				mdto.setNick(rs.getString("nick"));
				mdto.setName(rs.getString("name"));
				mdto.setAge(rs.getInt("age"));
				mdto.setEmail(rs.getString("email"));
				mdto.setAddr(rs.getString("addr"));
				mdto.setPhone(rs.getString("phone"));
				mdto.setCreip(rs.getString("creip"));
				mdto.setReg_date(rs.getTimestamp("date"));
				mdto.setExdate(rs.getTimestamp("exdate"));
				mdto.setGender(rs.getString("gender"));
				al.add(mdto);
			}
			return al;
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		
		return al;
	}

	@Override
	public ArrayList<MemberDTO> getMemberList(int num, String search) {
		ArrayList<MemberDTO> al = new ArrayList<MemberDTO>();
		try {
			con =getConnection();
			sql="select * from members where id like ? limit 0,?";
			pstmt= con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, num);
			rs=pstmt.executeQuery();
			while(rs.next()){
				MemberDTO mdto = new MemberDTO();
				mdto.setId(rs.getString("id")); 
				mdto.setNick(rs.getString("nick"));
				mdto.setName(rs.getString("name"));
				mdto.setAge(rs.getInt("age"));
				mdto.setEmail(rs.getString("email"));
				mdto.setAddr(rs.getString("addr"));
				mdto.setPhone(rs.getString("phone"));
				mdto.setCreip(rs.getString("creip"));
				mdto.setReg_date(rs.getTimestamp("date"));
				mdto.setExdate(rs.getTimestamp("exdate"));
				mdto.setGender(rs.getString("gender"));
				al.add(mdto);
			}
			return al;
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		
		return al;
	}

	@Override
	public boolean delMembers(String id) {
		try{
			con=getConnection();
			sql="delete from members where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "id");
			System.out.println("dd");
			pstmt.executeUpdate();
			return true;
			
		}catch (Exception e) {
			// TODO: handle exception
		} finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return false;
	}

	@Override
	public int warningPw(String id) {
		int day=-1;
		try{
			con=getConnection();
			sql="select datediff(now(),exdate) from members where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()){
				day=rs.getInt(1);
			}
			return day;
			
		}catch (Exception e) {
			// TODO: handle exception
		} finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return day;
		
	}


	


}
