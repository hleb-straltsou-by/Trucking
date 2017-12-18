package com.itechart.trucking.util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Utils {

    public static LocalDate jsonToLocalDate(String date) {
        if (date == null || date.isEmpty()) {
            return  null;
        }
//        return LocalDate.parse(date.substring(0, date.indexOf('T')), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        return LocalDate.parse(date, DateTimeFormatter.ofPattern("dd.MM.yyyy"));
    }
}