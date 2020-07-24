package com.freemarker.hello.enums;

/**
 * @author Clifton
 * @create 2020/7/24 - 9:53
 */
public enum FileSuffix {
    JAVA_CONTROLLER("Controller.java"),
    JAVA_SERVICE("Service.java"),
    JAVA_SERVICE_IMPL("ServiceImpl.java"),
    JS_CONTROLLER("_controller_server.js"),
    HTML(".html"),
    JS_SERVICE("_service.js"),
    DB_MAPPER("Mapper.java",';',(char) 0,1),
    DB_MAPPER_XML("Mapper.xml", '>',(char) 0,2),
    I18N("i18n.json",'"',',',1);

    //文件后缀
    private String suffix;
    //插入位置标识
    private char flag;
    //分隔符
    private char split;
    //需要找到几次标识
    private int times;


    FileSuffix(String suffix, char flag, char split, int times) {
        this.suffix = suffix;
        this.split = split;
        this.flag = flag;
        this.times = times;
    }

    FileSuffix(String suffix){
        this.suffix = suffix;
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
}
