package com.itheima.utils;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Month;
import java.time.Period;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;
import java.util.Date;

/**
 * 实现密码加密的一个工具类
 */
public class PasswordEncoderUtils {
    private static BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();

    public static String encoding(String password){
        return bCryptPasswordEncoder.encode(password);
    }

    public static void main(String[] args) throws ParseException {
        LocalDate startDate = LocalDate.of(2018, Month.MARCH, 29);
        System.out.println("开始时间  : " + startDate);

        LocalDate endDate = LocalDate.of(2020, Month.DECEMBER, 20);
        System.out.println("结束时间 : " + endDate);

        long daysDiff = ChronoUnit.DAYS.between(startDate, endDate);
        System.out.println("两天之间的差在天数   : " + daysDiff);
    }
}
