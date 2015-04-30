package com.cn.ant;


import com.cn.ant.utils.BeanFactoryUtil;
import com.cn.ant.utils.SystemDetails;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.rmi.server.RMISocketFactory;

public class Launcher {
    private static Logger logger = LoggerFactory.getLogger(Launcher.class);

    /**
     * @param args
     */
    public static void main(String[] args) {
        System.out.println("=======================");
        System.out.println("        Core包启动          ");
        SystemDetails.outputDetails();
        System.out.println("=======================");

        try {
            RMISocketFactory.setSocketFactory(new HermRMISocket());
        } catch (IOException ex) {
            logger.error(ex.getMessage(), ex);
        }
        getLocalip();
        // 初始化spring
        System.out.println("开始初始化spring容器");
        BeanFactoryUtil.init();
        System.out.println("结束初始化spring容器");
        try {
            System.out.println("core启动成功");
            System.in.read();
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
    }

    /**
     * 取得本机ip地址 注意：Spring RmiServiceExporter取得本机ip的方法：InetAddress.getLocalHost()
     */
    private static void getLocalip() {
        try {
            System.out.println("服务暴露的ip: "
                    + java.net.InetAddress.getLocalHost().getHostAddress());
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
    }
}
