package com.ithong.tour;

import java.util.ArrayList;

public interface iTourDAO {

	public int maxIdx();
	public boolean insertTourInfo(TourDTO tdto);
	public ArrayList<TourDTO> getTourList(int num);
	public ArrayList<TourDTO> getTourList(int num, String search);
	public ArrayList<String> getDateList(String mm);

}
