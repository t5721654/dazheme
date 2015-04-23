package com.cn.ant.modules;

import junit.framework.TestCase;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.util.*;

/**
 * 通用测试类
 * Created by AntDream on 2014/11/5.
 */
public class BaseTest extends TestCase {

    protected CloseableHttpClient httpClient = HttpClients.createDefault();

    /**
     * post方法
     *
     * @param url:请求地址
     * @param params:请求参数
     * @return 返回处理结果
     */
    public String post(String url, Map<String, String> params) {
        String res = null;
        HttpPost httpPost = new HttpPost(url);
        List<NameValuePair> paramLis = new ArrayList<NameValuePair>();
        CloseableHttpResponse response = null;
        try {
            //参数转换
            Set<Map.Entry<String, String>> entries = params.entrySet();
            if (entries != null) {
                Iterator<Map.Entry<String, String>> it = entries.iterator();
                while (it.hasNext()) {
                    Map.Entry<String, String> entry = it.next();
                    paramLis.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
                }
            }
            httpPost.setEntity(new UrlEncodedFormEntity(paramLis, "UTF-8"));
            response = httpClient.execute(httpPost);
            HttpEntity entity = response.getEntity();
            if (entity != null) {
                res = EntityUtils.toString(entity, "UTF-8");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                response.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return res;
    }

    /**
     * get发送请求
     *
     * @param url
     * @param params
     * @return
     */
    public String get(String url, Map<String, String> params) {
        String res = null;
        HttpGet httpGet = null;
        List<NameValuePair> paramLis = new ArrayList<NameValuePair>();
        CloseableHttpResponse response = null;
        try {
            //参数转换
            Set<Map.Entry<String, String>> entries = params.entrySet();
            if (entries != null) {
                Iterator<Map.Entry<String, String>> it = entries.iterator();
                while (it.hasNext()) {
                    Map.Entry<String, String> entry = it.next();
                    paramLis.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
                }
            }
            String paramStr = EntityUtils.toString(new UrlEncodedFormEntity(paramLis, "UTF-8"));
            httpGet = new HttpGet(url + "?" + paramStr);
            response = httpClient.execute(httpGet);
            HttpEntity entity = response.getEntity();
            if (entity != null) {
                res = EntityUtils.toString(entity, "UTF-8");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            try {
                response.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return res;
    }
}
