package com.bjpowernode.crm.utils;

import com.bjpowernode.crm.constants.Constants;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTimeUtil {
	
	public static String getSysTime(){
		

		
		Date date = new Date();
		String dateStr =Constants.DateFormat.SDF19.format(date);
		
		return dateStr;
		
	}
	public static String getSysTimeForUpload(){

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");

		Date date = new Date();
		String dateStr = sdf.format(date);

		return dateStr;

	}
}
