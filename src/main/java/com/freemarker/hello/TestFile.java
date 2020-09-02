package com.freemarker.hello;

import java.io.File;
import java.time.Instant;
import java.util.HashMap;
import java.util.Map;

/**
 * @author Clifton
 * @create 2020/7/22 - 14:59
 */
public class TestFile {

    public static void main(String[] args) {
        Map<String, String> map = null;
        Map<String, String> tmpMap = new HashMap<>();
        tmpMap.put("123","123");
        ge(map, tmpMap);
        System.out.println(map);
    }

    private static void ge(Map<String, String> map, Map<String, String> tmpMap) {
        map = tmpMap;
    }

}
