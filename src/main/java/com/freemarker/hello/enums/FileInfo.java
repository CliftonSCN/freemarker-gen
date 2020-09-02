package com.freemarker.hello.enums;

import com.freemarker.hello.FilePath;

/**
 *  生成文件信息，与被追加文件信息
 *  web项目，存入数据库
 * @author Clifton
 * @create 2020/7/24 - 9:53
 */
public enum FileInfo {

    JAVA_CONTROLLER("Controller.java", true),
    JAVA_SERVICE("Service.java", true),
    JAVA_SERVICE_IMPL("ServiceImpl.java", true),
    JS_CONTROLLER("_controller_server.js", false),
    HTML(".html", false),
    JS_SERVICE("_service.js", false),
    DB_MAPPER("Mapper.java", true),
    DB_MAPPER_XML("Mapper.xml", true, FilePath.ABSOLUTE_DB_MAPPER_XML_PATH, null, '>',(char) 0,2),
    DB_BEAN(".java", true, FilePath.ABSOLUTE_DB_BEAN_PATH, null, '}',(char) 0,2),
    I18N("i18n.json", false, FilePath.ABSOLUTE_I18N_PATH, "zh.json/en.json/es.json",'"',',',1);

    //文件后缀
    private String suffix;
    //被追加文件
    private String toFile;
    //被追加文件名，'/'分隔。值为null时，表示使用追加文件名
    private String toFileName;
    //插入位置标识
    private char flag;
    //分隔符
    private char split;
    //需要找到几次标识
    private int times;
    //文件名首字母是否大写
    private boolean firstCharUpper;


    FileInfo(String suffix, boolean firstCharUpper, String toFile, String toFileName, char flag, char split, int times) {
        this.suffix = suffix;
        this.firstCharUpper = firstCharUpper;
        this.toFile =toFile;
        this.toFileName = toFileName;
        this.split = split;
        this.flag = flag;
        this.times = times;
    }

    FileInfo(String suffix, boolean firstCharUpper){
        this.suffix = suffix;
        this.firstCharUpper = firstCharUpper;
    }


    public char getSplit() {
        return split;
    }

    public void setSplit(char split) {
        this.split = split;
    }

    public char getFlag() {
        return flag;
    }

    public void setFlag(char flag) {
        this.flag = flag;
    }

    public int getTimes() {
        return times;
    }

    public void setTimes(int times) {
        this.times = times;
    }

    public String getSuffix() {
        return suffix;
    }

    public void setSuffix(String suffix) {
        this.suffix = suffix;
    }

    public String getToFile() {
        return toFile;
    }

    public void setToFile(String toFile) {
        this.toFile = toFile;
    }

    public String getToFileName() {
        return toFileName;
    }

    public void setToFileName(String toFileName) {
        this.toFileName = toFileName;
    }

    public boolean getFirstCharUpper() {
        return firstCharUpper;
    }

    public void setFirstCharUpper(boolean firstCharUpper) {
        this.firstCharUpper = firstCharUpper;
    }
}
