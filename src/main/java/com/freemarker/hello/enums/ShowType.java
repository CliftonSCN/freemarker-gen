package com.freemarker.hello.enums;

/**
 * 字段显示类型
 * @author Clifton
 * @create 2020/7/23 - 9:17
 */
public enum ShowType {
    STRING("String"),NUMBER("Number"),DATE("Date"),TIMESTAMP("TimeStamp");

    private String showType;

    ShowType(String showType){
        this.showType = showType;
    }

    public String getShowType() {
        return showType;
    }

    public void setShowType(String showType) {
        this.showType = showType;
    }
}
