package mail;

import java.util.Calendar;

public class GetCalendar {

	Calendar cal = Calendar.getInstance();
	 String[][] calDate = new String[6][7];
	
     int startDay;   // 월 시작 요일
    int lastDay;    // 월 마지막 날짜
     int inputDate=1;  // 입력 날짜
    
    public GetCalendar(int year, int month){
    	// Calendar에 년,월,일 셋팅
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month-1);
        cal.set(Calendar.DATE, 1);
        
        startDay = cal.get(Calendar.DAY_OF_WEEK); // 월 시작 요일 
        lastDay = cal.getActualMaximum(Calendar.DATE); // 월 마지막 날짜
        
        // 2차 배열에 날짜 입력
        int row = 0;
        for(int i=1; inputDate<=lastDay; i++){
            
            // 시작 요일이 오기전에는 공백 대입
            if(i<startDay) calDate[row][i-1]="";
            else{
                // 날짜 배열에 입력
                calDate[row][(i-1)%7]=Integer.toString(inputDate);
                inputDate++;
                
                // 가로 마지막 열에 오면 행 바꿈
                if(i%7==0) row++;
            } 
        }
    }
 public int getLastday(){
	 return lastDay;
 }

public String[][] printCal(){
        
          
 
        return calDate;
    }
//static public void main(String[] args){
//	GetCalendar gc =  new GetCalendar(2020, 2);
//	System.out.println(gc.lastDay);
//}

	 
}
