//package com.freemarker.hello;
//
//import java.io.*;
//import java.nio.ByteBuffer;
//import java.nio.channels.FileChannel;
//import java.sql.PseudoColumnUsage;
//import java.util.Arrays;
//
///**
// * @author Clifton
// * @create 2020/7/23 - 13:21
// */
//public class FileSearch {
//
//    public static void main(String[] args) throws IOException {
//
//        File file = new File("src\\main\\java\\com\\freemarker\\hello\\zh.json");
//
//        RandomAccessFile randomAccessFile = new RandomAccessFile(file,"rw");
//
//        long fileLength = randomAccessFile.length();
//
//        byte[] bytes = new byte[1024];
//
//        randomAccessFile.seek(fileLength - 1024);
//
//        randomAccessFile.read(bytes);
//
//        long pos = fileLength;
//
//        for (int i = bytes.length - 1; i >=0 ; i--) {
//            if ('"' == (char)bytes[i]){
//                pos -= (bytes.length-i);
//                break;
//            }
//        }
//
//        System.out.println(pos);
//
//        randomAccessFile.seek(pos + 1);
//
//        byte[] bytesSuffix = new byte[(int) (fileLength - pos)];
//
//        int read1 = randomAccessFile.read(bytesSuffix);
//
//        System.out.println(new String(bytesSuffix));
//
//        File file1 = new File("src\\main\\java\\com\\freemarker\\hello\\devicegroup\\deviceGroupzh.json");
//
//        RandomAccessFile r2 = new RandomAccessFile(file1,"r");
//
//        randomAccessFile.seek(pos+1);
//
//        //插入逗号与回车
//        randomAccessFile.writeByte(',');
//        randomAccessFile.writeByte(10);
//        randomAccessFile.writeByte(10);
//
//        bytes = new byte[(int) r2.length()];
//
//        r2.read(bytes);
//        randomAccessFile.write(bytes);
//
//        randomAccessFile.write(bytesSuffix);
//
//        randomAccessFile.close();
//
//    }
//
//}
