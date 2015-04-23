package com.cn.ant.common;

import junit.framework.TestCase;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.junit.Test;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * Created by AntDream on 2014/11/29.
 */
public class LuckyTest extends TestCase {
    CloseableHttpClient httpClient = HttpClients.createDefault();

    @Test
    public void testA() {
        String res = null;
        String url = "http://115.182.208.60//index.php?m=Index&a=prize";
        HttpPost httpPost = new HttpPost(url);
        List<NameValuePair> paramLis = new ArrayList<NameValuePair>();
        CloseableHttpResponse response = null;
        Random random = new Random();
        for (int i = 0; i < 100; i++) {
            String phone = "";
            for (int j = 0; j < 8; j++) {
                phone += random.nextInt(9);
            }
            try {
                //参数转换
                paramLis.add(new BasicNameValuePair("phone", "188" + phone));
                paramLis.add(new BasicNameValuePair("openid", "oKMVXt_ezeGNENG2a6qD1qboay98"));
                httpPost.setEntity(new UrlEncodedFormEntity(paramLis, "UTF-8"));
                response = httpClient.execute(httpPost);
                HttpEntity entity = response.getEntity();
                res = EntityUtils.toString(entity, "UTF-8");
                System.out.println(phone);
                System.out.println(res);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    response.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public void testB(){
        String res = null;
        String url = "http://115.182.208.60//index.php?m=Index&a=run";
        HttpPost httpPost = new HttpPost(url);
        List<NameValuePair> paramLis = new ArrayList<NameValuePair>();
        CloseableHttpResponse response = null;
        for (int i = 0; i < 1; i++) {
            try {
                //参数转换
                paramLis.add(new BasicNameValuePair("openid", "oKMVXt_ezeGNENG2a6qD1qboay98"));
                httpPost.setEntity(new UrlEncodedFormEntity(paramLis, "UTF-8"));
                response = httpClient.execute(httpPost);
                HttpEntity entity = response.getEntity();
                res = EntityUtils.toString(entity, "UTF-8");
                System.out.println(res);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    response.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
