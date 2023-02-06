package com.sycompany.hsp;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class test02 {

	public static void main(String[] args) {
		
		String storedDate = "2023년 01월 02일";
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy년 mm월 dd일");
		Date date01 = null;
		
		
		String releasedDate = "2023년 01월 03일";
		SimpleDateFormat dateF = new SimpleDateFormat("yyyy년 mm월 dd일");
		Date date02 = null;
		
		
		try {
			date01 = dateFormat.parse(storedDate);
			date02 = dateFormat.parse(releasedDate);
			int result = date01.compareTo(date02);
			int result2 = date02.compareTo(date01);
			
			
				System.out.println(result);
				System.out.println(result2);
				
				if(result == 0)
				    System.out.println("동일한 날짜");
				else if (result < 0)
				    System.out.println("date1은 date2 이전 날짜");
				else
				    System.out.println("date1은 date2 이후 날짜");	
				
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		

	}

}
