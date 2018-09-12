package mail;

import java.io.IOException;
import java.net.InetAddress;
import java.sql.Date;
import org.apache.commons.net.ntp.NTPUDPClient; 
import org.apache.commons.net.ntp.TimeInfo;

public class Current_Date {
	
	public String GetDate(){
		String date="";
		try{
		 String TIME_SERVER = "time.bora.net";   
	     NTPUDPClient timeClient = new NTPUDPClient();
	     InetAddress inetAddress = InetAddress.getByName(TIME_SERVER);
	     TimeInfo timeInfo = timeClient.getTime(inetAddress);
	     long returnTime = timeInfo.getReturnTime();
	     Date time = new Date(returnTime);
	     System.out.println("Time from " + TIME_SERVER + ": " + time);
	     date= time.toString();
	     return date;
		}catch (IOException e) {
		e.printStackTrace();
		}
		return date;
	}
	
}
