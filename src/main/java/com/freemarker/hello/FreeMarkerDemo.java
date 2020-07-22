package com.freemarker.hello;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author Clifton
 * @create 2020/7/20 - 12:31
 */
public class FreeMarkerDemo {

    private static final String TEMPLATE_PATH = "src\\main\\java\\com\\freemarker\\hello\\templates";
    private static final String CLASS_PATH = "src\\main\\java\\com\\freemarker\\hello";
    private static final String TABLE_NAME = "history_double";

    private static Map<String, Object> dataMap = new HashMap<String, Object>();

    public static void main(String[] args) {
        // step1 创建freeMarker配置实例
        Configuration configuration = new Configuration();
        try {
            // step2 获取模版路径
            configuration.setDirectoryForTemplateLoading(new File(TEMPLATE_PATH));
            // step3 创建数据模型

            commonConfig();

            List<String> columns = getColumns();
            List<String> camelList = listCamel(columns);
            dataMap.put("columns",columns);
            dataMap.put("camelColumns",camelList);

            createFile(configuration, dataMap, "TemplateController.ftl", "Controller.java", true);
            createFile(configuration, dataMap,"TemplateControllerJs.ftl", "_controller_server.js", false);
            createFile(configuration, dataMap,"TemplateHtml.ftl", ".html", false);
            createFile(configuration, dataMap,"TemplateServiceJs.ftl", "_service.js", false);
            createFile(configuration, dataMap,"zhTemplate.ftl", "zh.json", false);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void commonConfig(){
        String[] split = TABLE_NAME.split("_");
        String camelStr = lineToHump(TABLE_NAME);
        char[] chars = camelStr.toCharArray();
        chars[0] -= 32;
        String upperCamelStr = String.valueOf(chars);
        dataMap.put("bean", upperCamelStr);
        dataMap.put("lowerBean", camelStr);
        dataMap.put("authorize", TABLE_NAME.toUpperCase());
    }

    public static void createFile(Configuration configuration, Map<String, Object> dataMap, String templateName, String suffixName, boolean upper) {
        Writer out = null;;
        try {
            // step4 加载模版文件
            Template templateController = configuration.getTemplate(templateName);
            StringBuilder fileName = new StringBuilder();
            if (upper){
                fileName.append(dataMap.get("bean")).append(suffixName);
            }else {
                fileName.append(dataMap.get("lowerBean")).append(suffixName);
            }
            // step5 生成数据
            File docFile = new File(CLASS_PATH + "\\"+ dataMap.get("lowerBean").toString().toLowerCase()+ "\\" + fileName.toString());
            //判断目标文件所在的目录是否存在
            if(!docFile.getParentFile().exists()) {
                //如果目标文件所在的目录不存在，则创建父目录
                if(!docFile.getParentFile().mkdirs()) {
                    System.out.println("创建目标文件所在目录失败！");
                }
            }
            out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(docFile)));
            // step6 输出文件
            templateController.process(dataMap, out);
            System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^ 文件创建成功 !");
        } catch (IOException e) {
            e.printStackTrace();
        } catch (TemplateException e) {
            e.printStackTrace();
        } finally {
            try {
                if (null != out) {
                    out.flush();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }

    public static List<String> getColumns() {
        String Url = "jdbc:mysql://127.0.0.1:3306/dmc";
        String User = "root";
        String Password = "123qwe";
        //1.加载驱动程序
        Connection con = null;
        ArrayList<String> list = new ArrayList<String>();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            //2.获得数据库链接
            con = DriverManager.getConnection(Url, User, Password);

            String catalog = con.getCatalog();

            DatabaseMetaData metaData = con.getMetaData();
            //获取表信息
//            ResultSet tableRet = metaData.getTables(null, "%","%",new String[]{"TABLE"});

            //获取主键
            ResultSet primaryKeys = metaData.getPrimaryKeys(catalog, null, TABLE_NAME);
            primaryKeys.next();
            String pk = (String) primaryKeys.getString("COLUMN_NAME");
            String camelPk = lineToHump(pk);
            char[] chars = camelPk.toCharArray();
            chars[0] -= 32;
            String upperCamelPk = String.valueOf(chars);
            dataMap.put("pk", upperCamelPk);
            dataMap.put("lowerPk", camelPk);

            //获取列
            ResultSet columns = metaData.getColumns(null, "%", TABLE_NAME, "%");
            while (columns.next()){
                String columnName = columns.getString("COLUMN_NAME");
//              String columnType = columns.getString("TYPE_NAME");
                list.add(columnName);
            }
            return list;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
        }
        return list;
    }

    public static List<String> listCamel(List<String> list){
        ArrayList<String> camelList = new ArrayList<String>();
        for (String s : list) {
            camelList.add(lineToHump(s));
        }
        return camelList;
    }

    /** 下划线转驼峰 */
    public static String lineToHump(String str) {
        Pattern linePattern = Pattern.compile("_(\\w)");
        str = str.toLowerCase();
        Matcher matcher = linePattern.matcher(str);
        StringBuffer sb = new StringBuffer();
        while (matcher.find()) {
            matcher.appendReplacement(sb, matcher.group(1).toUpperCase());
        }
        matcher.appendTail(sb);
        return sb.toString();
    }


}
