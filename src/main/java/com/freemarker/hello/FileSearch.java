package com.freemarker.hello;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.sql.PseudoColumnUsage;
import java.util.Arrays;

/**
 * @author Clifton
 * @create 2020/7/23 - 13:21
 */
public class FileSearch {

    public static void main(String[] args){

        String fromFile = "src\\main\\java\\com\\freemarker\\hello\\test\\TeacherMapper.java";
        String toFile = "src\\main\\java\\com\\freemarker\\hello\\result\\StudentMapper.java";

        char flag = ';';
        char split = 0;
        int num = 1;

        File file = new File(toFile);

        RandomAccessFile randomAccessFile = null;
        try {
            //TODO json文件为空时

            //找到要追加的位置
            randomAccessFile = new RandomAccessFile(file,"rw");
            long fileLength = randomAccessFile.length();

            byte[] bytes = new byte[1024];
            int time = 1;
            long pos = fileLength;
            while(fileLength - 1024*time >=0) {

                randomAccessFile.seek(fileLength - 1024 * time > 0 ? fileLength - 1024 * time : 0);

                randomAccessFile.read(bytes);

                //最后一个”是要追加的位置
                for (int i = bytes.length - 1; i >= 0; i--) {
                    if (flag == (char) bytes[i]) {
                        num--;
                        if (num == 0) {
                            pos -= (bytes.length - i + 1024 * (time - 1));
                            break;
                        }
                    }
                }

                System.out.println(pos);
                if (pos != fileLength){
                    break;
                }

            }

            randomAccessFile.seek(pos + 1);

            byte[] bytesSuffix = new byte[(int) (fileLength - pos)];

            int read1 = randomAccessFile.read(bytesSuffix);

            System.out.println(new String(bytesSuffix));

            File file1 = new File(fromFile);

            RandomAccessFile r2 = new RandomAccessFile(file1,"r");

            randomAccessFile.seek(pos+1);

            //插入逗号与回车
            randomAccessFile.writeByte(split);
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
                if (randomAccessFile != null){
                    randomAccessFile.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }


    }

}
