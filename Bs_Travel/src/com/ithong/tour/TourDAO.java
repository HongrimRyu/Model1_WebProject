package com.ithong.tour;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.ithong.member.MemberDTO;

public class TourDAO implements iTourDAO{

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
	public int maxIdx() {
		int max=-1;
		try {
			con=getConnection();
			sql="select max(idx) from reserv_tour";
			pstmt = con.prepareStatement(sql);
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
	public boolean insertTourInfo(TourDTO tdto) {
		try {
			con = getConnection();
			sql="insert into reserv_tour (idx, id, name, email, course,"
					+ "purpose, member, memo, tour_date,submit_date,phone)"
					+ "values (?,?,?,?,?,?,?,?,?,now(),?)";
			pstmt= con.prepareStatement(sql);
			pstmt.setInt(1, tdto.getIdx());
			pstmt.setString(2, tdto.getId());
			pstmt.setString(3, tdto.getName());
			pstmt.setString(4, tdto.getEmail());
			pstmt.setString(5, tdto.getCourse());
			pstmt.setString(6, tdto.getPurpose());
			pstmt.setString(7, tdto.getMember());
			pstmt.setString(8, tdto.getMemo());
			pstmt.setString(9, tdto.getTour_date());
			pstmt.setString(10, tdto.getPhone());
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
	public ArrayList<TourDTO> getTourList(int num) {
		ArrayList<TourDTO> al = new ArrayList<TourDTO>();
		try {
			con =getConnection();
			sql="select * from reserv_tour limit 0,?";
			pstmt= con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			while(rs.next()){
				TourDTO tdto = new TourDTO();
				tdto.setId(rs.getString("id"));
				tdto.setName(rs.getString("name"));
				tdto.setEmail(rs.getString("email"));
				tdto.setCourse(rs.getString("course"));
				tdto.setPurpose(rs.getString("purpose"));
				tdto.setMember(rs.getString("member"));
				tdto.setMemo(rs.getString("memo"));
				tdto.setTour_date(rs.getString("tour_date"));
				tdto.setSubmit_date(rs.getTimestamp("submit_date"));
				tdto.setPhone(rs.getString("phone"));
				al.add(tdto);
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
	public ArrayList<TourDTO> getTourList(int num, String search) {
		ArrayList<TourDTO> al = new ArrayList<TourDTO>();
		try {
			con =getConnection();
			sql="select * from reserv_tour where name like ? limit 0,?";
			pstmt= con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, num);
			rs=pstmt.executeQuery();
			while(rs.next()){
				TourDTO tdto = new TourDTO();
				tdto.setId(rs.getString("id"));
				tdto.setName(rs.getString("name"));
				tdto.setEmail(rs.getString("email"));
				tdto.setCourse(rs.getString("course"));
				tdto.setPurpose(rs.getString("purpose"));
				tdto.setMember(rs.getString("member"));
				tdto.setMemo(rs.getString("memo"));
				tdto.setTour_date(rs.getString("tour_date"));
				tdto.setSubmit_date(rs.getTimestamp("submit_date"));
				tdto.setPhone(rs.getString("phone"));
				al.add(tdto);
			}
			return al;
		} catch (Exception e) {
			e.printStackTrace();
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
	public  ArrayList<String> getDateList(String mm) {
		ArrayList<String> tour_date= new ArrayList<String>();
		mm="%-"+mm+"-%";
		try {
			con=getConnection();
			sql="select tour_date from reserv_tour where tour_date like ? order by tour_date";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mm);
			rs=pstmt.executeQuery();
			while(rs.next()){
				String date[]=rs.getString("tour_date").split("-");
				if(date[2].charAt(0)=='0') tour_date.add(date[2].substring(1));
				else tour_date.add(date[2]);
			}
			return tour_date;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				DBClose();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return tour_date;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
