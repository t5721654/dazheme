package com.cn.ant.utils;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class BeanFactoryUtil {
    private static ApplicationContext ctx_producer = null;

    public static void init() {
        if (ctx_producer == null) {
        	synchronized (BeanFactoryUtil.class) {
        		if(ctx_producer == null){
        			String[] configLocations = new String[]{CommonDef.ApplicationContextPath};
                    ctx_producer = new ClassPathXmlApplicationContext(configLocations);
        		} 
        		
			}
        }
    }

    public static ApplicationContext getContext() {
        init();
        return ctx_producer;
    }
}
