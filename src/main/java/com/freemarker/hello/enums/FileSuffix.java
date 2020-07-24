package com.freemarker.hello.enums;

/**
 * @author Clifton
 * @create 2020/7/24 - 9:53
 */
public enum FileSuffix {
    JAVA_CONTROLLER("Controller.java"),
    JS_CONTROLLER("_controller_server.js"),
    HTML(".html"),
    JS_SERVICE("_service.js"),
    I18N("i18n.json");

    private String suffix;

    FileSuffix(String suffix){
        this.suffix = suffix;
    }

    public String getSuffix() {
        return suffix;
    }

    public void setSuffix(String suffix) {
        this.suffix = suffix;
    }
}
