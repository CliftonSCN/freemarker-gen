package com.freemarker.hello;

import com.freemarker.hello.enums.FileInfo;
import com.freemarker.hello.enums.ShowType;
import com.freemarker.hello.templates.TableMeta;
import com.sun.xml.internal.bind.v2.TODO;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.apache.commons.lang3.StringUtils;

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

    private static final String URL = "jdbc:mysql://127.0.0.1:3306/dmc";
    private static final String USER = "root";
    private static final String PASSWORD = "123qwe";

    private static final String PROJECT_PATH = "F:\\WorkSpace\\DMC";
    private static final String BOSS_PATH = "F:\\WorkSpace\\DMC\\dmc-boss";
    private static final String API_PATH = "F:\\WorkSpace\\DMC\\dmc-api";
    private static final String DB_PATH = "F:\\WorkSpace\\DMC\\dmc-db";
    private static final String PACKAGE = "com.zbensoft.dmc.api";
    private static final String CONTROLLER_PATH = "src\\main\\java\\com\\zbensoft\\dmc\\api\\control";
    private static final String SERVICE_PATH = "src\\main\\java\\com\\zbensoft\\dmc\\api\\service\\api";
    private static final String SERVICE_IMPL_PATH = "src\\main\\java\\com\\zbensoft\\dmc\\api\\service\\impl";
    private static final String STATIC_PATH = "src\\main\\resources\\static";
    private static final String DB_MAPPER_PATH = "src\\main\\java\\com\\zbensoft\\dmc\\db\\mapper";
    private static final String DB_MAPPER_XML_PATH = "src\\main\\resources\\mapper";
    private static final String TEMP_FILE_PATH = "src\\main\\java\\com\\freemarker\\hello\\temp";


    private static final String ABSOLUTE_I18N_PATH = BOSS_PATH + "\\" + STATIC_PATH + "\\i18n";
    private static final String ABSOLUTE_API_CONTROLLER_PATH = API_PATH + "\\" + CONTROLLER_PATH;
    private static final String ABSOLUTE_API_SERVICE_PATH = API_PATH + "\\" + SERVICE_PATH;
    private static final String ABSOLUTE_API_SERVICE_IMPL_PATH = API_PATH + "\\" + SERVICE_IMPL_PATH;
    private static final String ABSOLUTE_STATIC_CONTROLLER_PATH = BOSS_PATH + "\\" + STATIC_PATH + "\\js\\controller";
    private static final String ABSOLUTE_STATIC_SERVICE_PATH = BOSS_PATH + "\\" + STATIC_PATH + "\\js\\service";
    private static final String ABSOLUTE_STATIC_HTML_PATH = BOSS_PATH + "\\" + STATIC_PATH;
    private static final String ABSOLUTE_DB_MAPPER_PATH = DB_PATH + "\\" + DB_MAPPER_PATH;
    private static final String ABSOLUTE_DB_MAPPER_XML_PATH = DB_PATH + "\\" + DB_MAPPER_XML_PATH;

    private static final String TEMPLATE_PATH = "src\\main\\java\\com\\freemarker\\hello\\templates";
    private static final String CLASS_PATH = "src\\main\\java\\com\\freemarker\\hello";
    private static final String I18N_FILE = "src\\main\\java\\com\\freemarker\\hello\\zh.json";
    private static final String TABLE_NAME = "tone_config";

    private static Map<String, Object> dataMap = new HashMap<String, Object>();

    public static void main(String[] args) {
        // step1 创建freeMarker配置实例
        Configuration configuration = new Configuration();
        try {
            // step2 获取模版路径
            configuration.setDirectoryForTemplateLoading(new File(TEMPLATE_PATH));
            // step3 创建数据模型

            //设置通用项
            commonConfig();

            //解析表所有列，并设置相关属性
            List<TableMeta> camelList = getCamelColumns();
            dataMap.put("camelColumns", camelList);

//            createFile(configuration, dataMap, "TemplateController.ftl", FileInfo.JAVA_CONTROLLER, true);
//            createFile(configuration, dataMap, "TemplateService.ftl", FileInfo.JAVA_SERVICE, true);
//            createFile(configuration, dataMap, "TemplateServiceImpl.ftl", FileInfo.JAVA_SERVICE_IMPL, true);
//            createFile(configuration, dataMap, "TemplateControllerJs.ftl", FileInfo.JS_CONTROLLER, false);
//            createFile(configuration, dataMap, "TemplateHtml.ftl", FileInfo.HTML, false);
//            createFile(configuration, dataMap, "TemplateServiceJs.ftl", FileInfo.JS_SERVICE, false);
            createFile(configuration, dataMap, "TemplateMapper.ftl", FileInfo.DB_MAPPER, true);
            createFile(configuration, dataMap, "TemplateMapperXml.ftl", FileInfo.DB_MAPPER_XML, true);
//            createFile(configuration, dataMap, "zhTemplate.ftl", FileInfo.I18N, false);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void commonConfig() {
        String[] split = TABLE_NAME.split("_");
        String camelStr = lineToHump(TABLE_NAME);
        String upperCamelStr = upperFirstChar(camelStr);
        dataMap.put("tableName", TABLE_NAME);
        dataMap.put("bean", upperCamelStr);
        dataMap.put("lowerBean", camelStr);
        dataMap.put("authorize", TABLE_NAME.toUpperCase());
        dataMap.put("package", PACKAGE);
    }

    /**
     * @param configuration
     * @param dataMap
     * @param templateName  模板文件名
     * @param fileInfo    生成文件后缀名
     * @param upper         生成文件首字母是否大写
     */
    public static void createFile(Configuration configuration, Map<String, Object> dataMap, String templateName, FileInfo fileInfo, boolean upper) {
        Writer out = null;
        File docFile = null;
        try {
            // step4 加载模版文件
            Template templateController = configuration.getTemplate(templateName);
            StringBuilder fileName = new StringBuilder();
            //文件名定义
            if (upper) {
                fileName.append(dataMap.get("bean")).append(fileInfo.getSuffix());
            } else {
                fileName.append(dataMap.get("lowerBean")).append(fileInfo.getSuffix());
            }

            //计算路径
            StringBuilder path = new StringBuilder();

            switch (fileInfo) {
                case JAVA_CONTROLLER:
                    path.append(ABSOLUTE_API_CONTROLLER_PATH);
                    break;
                case JAVA_SERVICE:
                    path.append(ABSOLUTE_API_SERVICE_PATH);
                    break;
                case JAVA_SERVICE_IMPL:
                    path.append(ABSOLUTE_API_SERVICE_IMPL_PATH);
                    break;
                case JS_CONTROLLER:
                    path.append(ABSOLUTE_STATIC_CONTROLLER_PATH);
                    break;
                case JS_SERVICE:
                    path.append(ABSOLUTE_STATIC_SERVICE_PATH);
                    break;
                case HTML:
                    path.append(ABSOLUTE_STATIC_HTML_PATH);
                    break;
                case DB_MAPPER:
                case DB_MAPPER_XML:
                case I18N:
                    path.append(TEMP_FILE_PATH);
                    break;
                default:
                    System.out.println("找不到该文件对应的后缀名");
                    break;
            }

            String filePath = path.toString() + "\\" + fileName.toString();

            // step5 生成数据
            docFile = new File(filePath);
            //判断目标文件所在的目录是否存在
            if (!docFile.getParentFile().exists()) {
                //如果目标文件所在的目录不存在，则创建父目录
                if (!docFile.getParentFile().mkdirs()) {
                    System.out.println("创建目标文件所在目录失败！");
                }
            }

            out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(docFile)));
            // step6 输出文件
            templateController.process(dataMap, out);
            System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^" + filePath + "\\" + fileName + " 文件创建成功 !");

            //关闭流，以便删除临时文件
            out.close();

            //追加文件
            switch (fileInfo) {
                case DB_MAPPER:
                    appendToFile(docFile.getAbsolutePath(), ABSOLUTE_DB_MAPPER_PATH + "\\" + docFile.getName(), fileInfo);
                    break;
                case DB_MAPPER_XML:
                    appendToFile(docFile.getAbsolutePath(), ABSOLUTE_DB_MAPPER_XML_PATH + "\\" + docFile.getName(), fileInfo);
                    break;
                case I18N:
                    appendToFile(docFile.getAbsolutePath(), ABSOLUTE_I18N_PATH + "\\zh.json", fileInfo);
                    appendToFile(docFile.getAbsolutePath(), ABSOLUTE_I18N_PATH + "\\en.json", fileInfo);
                    appendToFile(docFile.getAbsolutePath(), ABSOLUTE_I18N_PATH + "\\es.json", fileInfo);
                    break;
                default:
                    break;
            }

        } catch (IOException | TemplateException e) {
            e.printStackTrace();
        } finally {
            try {
                if (null != out) {
                    out.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }


    /**
     * 追加文件
     * @param fromFile 目标文件
     * @param toFile    追加到哪个文件
     * @param fileInfo    文件信息
     */
    public static void appendToFile(String fromFile, String toFile, FileInfo fileInfo) {

        //搜索次数
        int foundTimes = fileInfo.getTimes();

        File tf = new File(toFile);

        RandomAccessFile toRandomAccessFile = null;
        RandomAccessFile fromRandomAccessFile = null;
        File ff = null;
        try {
            //TODO 文件为空时的处理

            //找到要追加的位置
            toRandomAccessFile = new RandomAccessFile(tf, "rw");
            long fileLength = toRandomAccessFile.length();

            byte[] bytes = new byte[1024];
            //第几次搜索
            int loopTime = 1;
            //文件指针
            long pos = fileLength;
            //从末尾开始，每次搜索1024个字节
            while (fileLength - 1024 * loopTime >= 0) {

                toRandomAccessFile.seek(fileLength - 1024 * loopTime > 0 ? fileLength - 1024 * loopTime : 0);

                toRandomAccessFile.read(bytes);

                for (int i = bytes.length - 1; i >= 0; i--) {
                    //搜索到标识，则搜索次数减一，直到0，计算出追加位置
                    if (fileInfo.getFlag() == (char) bytes[i]) {
                        foundTimes--;
                        if (foundTimes == 0) {
                            pos -= (bytes.length - i + 1024 * (loopTime - 1));
                            break;
                        }
                    }
                }

                loopTime++;

                if (pos != fileLength) {
                    break;
                }

            }

            //指针定位到追加位置
            toRandomAccessFile.seek(pos + 1);

            //减1是为了，去掉生成文件末尾的空白char
            byte[] bytesSuffix = new byte[(int) (fileLength - pos - 1)];

            //将之后的内容读出
            toRandomAccessFile.read(bytesSuffix);

            toRandomAccessFile.seek(pos + 1);

            //插入分隔符
            if (fileInfo.getSplit() != 0) {
                toRandomAccessFile.writeByte(fileInfo.getSplit());
            }
            //插入回车
            toRandomAccessFile.writeByte(10);
            toRandomAccessFile.writeByte(10);

            //读取生成的临时文件
            ff = new File(fromFile);

            fromRandomAccessFile = new RandomAccessFile(ff, "r");

            bytes = new byte[(int) fromRandomAccessFile.length()];

            fromRandomAccessFile.read(bytes);

            //写入生成代码
            toRandomAccessFile.write(bytes);

            //写入末尾内容
            toRandomAccessFile.write(bytesSuffix);

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (toRandomAccessFile != null) {
                    toRandomAccessFile.close();
                }
                if (fromRandomAccessFile != null) {
                    fromRandomAccessFile.close();
                }
                if (ff != null) {
                    if (ff.delete()) {
                        System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^" + ff.getAbsolutePath() + "\\" + ff.getName() + " 文件已删除");
                    } else {
                        System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^" + ff.getAbsolutePath() + "\\" + ff.getName() + " 文件删除失败");
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }

    /**
     * 抽离成通用方法
     *
     * {@link FreeMarkerDemo#appendToFile}
     *
     * 将生成的i18n文件，追加到json括号内
     *
     * @param fromFile 目标文件
     * @param toFile   追加文件
     */
    @Deprecated
    public static void appendToI18nFile(String fromFile, String toFile) {

        File file = new File(toFile);

        RandomAccessFile randomAccessFile = null;
        try {
            //TODO json文件为空时

            //找到要追加的位置
            randomAccessFile = new RandomAccessFile(file, "rw");
            long fileLength = randomAccessFile.length();

            byte[] bytes = new byte[1024];
            int time = 1;
            long pos = fileLength;
            while (fileLength - 1024 * time >= 0) {

                randomAccessFile.seek(fileLength - 1024 * time > 0 ? fileLength - 1024 * time : 0);

                randomAccessFile.read(bytes);

                //最后一个”是要追加的位置
                for (int i = bytes.length - 1; i >= 0; i--) {
                    if ('"' == (char) bytes[i]) {
                        pos -= (bytes.length - i + 1024 * (time - 1));
                        break;
                    }
                }

                if (pos != fileLength) {
                    break;
                }

            }

            randomAccessFile.seek(pos + 1);

            byte[] bytesSuffix = new byte[(int) (fileLength - pos)];

            int read1 = randomAccessFile.read(bytesSuffix);

            System.out.println(new String(bytesSuffix));

            File file1 = new File(fromFile);

            RandomAccessFile r2 = new RandomAccessFile(file1, "r");

            randomAccessFile.seek(pos + 1);

            //插入逗号与回车
            randomAccessFile.writeByte(',');
            randomAccessFile.writeByte(10);
            randomAccessFile.writeByte(10);

            bytes = new byte[(int) r2.length()];

            r2.read(bytes);
            randomAccessFile.write(bytes);

            randomAccessFile.write(bytesSuffix);

            bytes = null;
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (randomAccessFile != null) {
                    randomAccessFile.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }


    }

    public static List<TableMeta> getCamelColumns() {
        //1.加载驱动程序
        Connection con = null;
        ArrayList<TableMeta> list = new ArrayList<TableMeta>();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            //2.获得数据库链接
            con = DriverManager.getConnection(URL, USER, PASSWORD);

            String catalog = con.getCatalog();

            DatabaseMetaData metaData = con.getMetaData();
            //获取表信息
//            ResultSet tableRet = metaData.getTables(null, "%","%",new String[]{"TABLE"});

            //获取主键
            ResultSet primaryKeys = metaData.getPrimaryKeys(catalog, null, TABLE_NAME);
            String camelPk = null;
            String upperCamelPk = null;
            if (primaryKeys.next()) {
                String pk = primaryKeys.getString("COLUMN_NAME");
                camelPk = lineToHump(pk);
                upperCamelPk = upperFirstChar(camelPk);
            }

            dataMap.put("pk", upperCamelPk);
            dataMap.put("lowerPk", camelPk);
            primaryKeys.close();


            //获取所有列
            ResultSet columns = metaData.getColumns(null, "%", TABLE_NAME, "%");
            while (columns.next()) {
                TableMeta tableMeta = new TableMeta();
                String columnName = columns.getString("COLUMN_NAME");

                String sqlType = columns.getString("TYPE_NAME");

                tableMeta.setColumnName(columnName);
                tableMeta.setCamelName(lineToHump(columnName));
                tableMeta.setUpperName(upperFirstChar(tableMeta.getCamelName()));
                tableMeta.setType(toSqlToJava(sqlType).getShowType());
                //修改时是否只读
                tableMeta.setReadOnly(0);
                //表格是否显示
                tableMeta.setInVisible(0);
                tableMeta.setPrimaryKey(0);

                //如果但列为主键，设标识属性为1
                if (StringUtils.isNotEmpty(camelPk) && tableMeta.getCamelName().equals(camelPk)) {
                    tableMeta.setPrimaryKey(1);
                    tableMeta.setReadOnly(1);
                    tableMeta.setInVisible(1);
                }

                //先按默认情况判断是否为外键
                if (tableMeta.getPrimaryKey() != 1 && tableMeta.getCamelName().endsWith("Id")) {
                    tableMeta.setForeignTable(columnName.substring(0, columnName.length() - 3));
                    tableMeta.setForeignKey(tableMeta.getCamelName());
                    tableMeta.setForeignName("name");
                }

                list.add(tableMeta);
            }

            //主键不存在时设置第一列为查询列
            if (dataMap.get("pk") == null) {
                dataMap.put("pk", list.get(0).getUpperName());
                dataMap.put("lowerPk", list.get(0).getCamelName());
            }

            columns.close();
            return list;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
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

    /**
     * 将首字母大写
     * @param str
     * @return
     */
    public static String upperFirstChar(String str) {
        char[] chars = str.toCharArray();
        chars[0] -= 32;
        return String.valueOf(chars);
    }

    /**
     * sql数据类型转化JAVA类型
     *
     * @param sqlType：类型名称
     * @return
     */
    public static ShowType toSqlToJava(String sqlType) {
        if (sqlType == null || sqlType.trim().length() == 0) return ShowType.STRING;
        sqlType = sqlType.toLowerCase();
        switch (sqlType) {
            case "nvarchar":
            case "char":
            case "varchar":
            case "text":
            case "nchar":
                return ShowType.STRING;
            case "integer":
            case "int":
            case "tinyint":
            case "smallint":
            case "mediumint":
            case "bigint":
            case "float":
            case "double":
            case "numeric":
            case "real":
            case "decimal":
                return ShowType.NUMBER;
/*            case "boolean":
            case "bit":
                return ShowType.BOOLEAN;*/
            case "date":
            case "datetime":
            case "year":
            case "time":
                return ShowType.DATE;
            case "timestamp":
                return ShowType.TIMESTAMP;
            default:
                System.out.println("-----------------》转化失败：未发现的类型" + sqlType + ", 使用String类型");
                break;
        }
        return ShowType.STRING;
    }

    /**
     * 集合中元素转为驼峰命名
     * @param list
     * @return
     */
    public static List<String> listCamel(List<String> list) {
        ArrayList<String> camelList = new ArrayList<String>();
        for (String s : list) {
            camelList.add(lineToHump(s));
        }
        return camelList;
    }

    /**
     * 下划线转驼峰
     */
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

    /**
     * 驼峰转下划线
     */
    public static String humpToLine(String str) {
        Pattern humpPattern = Pattern.compile("[A-Z]");
        Matcher matcher = humpPattern.matcher(str);
        StringBuffer sb = new StringBuffer();
        while (matcher.find()) {
            matcher.appendReplacement(sb, "_" + matcher.group(0).toLowerCase());
        }
        matcher.appendTail(sb);
        return sb.toString();
    }


}
