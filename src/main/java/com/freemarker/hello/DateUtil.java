package com.freemarker.hello;


import org.apache.commons.lang3.StringUtils;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;

/**
 * @author Clifton
 * @create 2020/7/17 - 15:17
 */
public class DateUtil {

    private final static String PATTERN_COMMON = "yyyy-MM-dd HH:mm:ss";

    public static String dateToTimeStamp(String date){

        if (StringUtils.isEmpty(date)){
            return null;
        }

        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern(PATTERN_COMMON);
        LocalDateTime localDateTime = LocalDateTime.parse(date, dateTimeFormatter);
        Instant instant = localDateTime.toInstant(ZoneOffset.ofHours(8));
        return String.valueOf(instant.toEpochMilli());

    }

    public static void main(String[] args) {

        String s = dateToTimeStamp("2020-07-17 14:40:00");
        System.out.println(s);

    }

}
