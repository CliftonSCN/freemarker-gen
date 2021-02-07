package com.freemarker.hello;

import java.io.IOException;
import java.util.Properties;

/**
 * @author Clifton
 * @create 2020/7/27 - 9:10
 */
public class FilePath {

    public static String PROJECT_PATH;
    public static String PROJECT_NAME;

    static {
        Properties properties = new Properties();
        try {
            properties.load(FreeMarkerDemo.class.getResourceAsStream("/config.properties"));
        } catch (IOException e) {
            e.printStackTrace();
        }

        PROJECT_PATH = (String) properties.get("projectPath");
        PROJECT_NAME = (String) properties.get("projectName");
    }

    public static final String BOSS_PATH = PROJECT_PATH+"\\"+PROJECT_NAME+"-boss";
    public static final String API_PATH = PROJECT_PATH+"\\"+PROJECT_NAME+"-api";
    public static final String DB_PATH = PROJECT_PATH+"\\"+PROJECT_NAME+"-db";
    public static final String CONTROLLER_PATH = "src\\main\\java\\com\\zbensoft\\"+PROJECT_NAME+"\\api\\control";
    public static final String SERVICE_PATH = "src\\main\\java\\com\\zbensoft\\"+PROJECT_NAME+"\\api\\service\\api";
    public static final String SERVICE_IMPL_PATH = "src\\main\\java\\com\\zbensoft\\"+PROJECT_NAME+"\\api\\service\\impl";
    public static final String HTML_PATH = "src\\main\\resources\\static";
    public static final String JS_CONTROLLER_PATH = "src\\main\\resources\\static\\js\\controller";
    public static final String JS_SERVICE_PATH = "src\\main\\resources\\static\\js\\service";
    public static final String I18N_PATH = "src\\main\\resources\\static\\il8n";
    public static final String DB_MAPPER_PATH = "src\\main\\java\\com\\zbensoft\\"+PROJECT_NAME+"\\db\\mapper";
    public static final String DB_MAPPER_XML_PATH = "src\\main\\resources\\mapper";
    public static final String DB_BEAN_PATH = "src\\main\\java\\com\\zbensoft\\"+PROJECT_NAME+"\\db\\domain";

    public static final String ABSOLUTE_I18N_PATH = FilePath.BOSS_PATH + "\\" + FilePath.I18N_PATH;
    public static final String ABSOLUTE_API_CONTROLLER_PATH = FilePath.API_PATH + "\\" + FilePath.CONTROLLER_PATH;
    public static final String ABSOLUTE_API_SERVICE_PATH = FilePath.API_PATH + "\\" + FilePath.SERVICE_PATH;
    public static final String ABSOLUTE_API_SERVICE_IMPL_PATH = FilePath.API_PATH + "\\" + FilePath.SERVICE_IMPL_PATH;
    public static final String ABSOLUTE_STATIC_CONTROLLER_PATH = FilePath.BOSS_PATH + "\\" + FilePath.JS_CONTROLLER_PATH;
    public static final String ABSOLUTE_STATIC_SERVICE_PATH = FilePath.BOSS_PATH + "\\" + FilePath.JS_SERVICE_PATH;
    public static final String ABSOLUTE_STATIC_HTML_PATH = FilePath.BOSS_PATH + "\\" + FilePath.HTML_PATH;
    public static final String ABSOLUTE_DB_MAPPER_PATH = FilePath.DB_PATH + "\\" + FilePath.DB_MAPPER_PATH;
    public static final String ABSOLUTE_DB_MAPPER_XML_PATH = FilePath.DB_PATH + "\\" + FilePath.DB_MAPPER_XML_PATH;
    public static final String ABSOLUTE_DB_BEAN_PATH = FilePath.DB_PATH + "\\" + FilePath.DB_BEAN_PATH;

}
