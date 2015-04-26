package com.cn.ant.redis.transcoder;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * 序列化List
 * Created by huanggenhua on 2015/4/26.
 */
public class ListTranscoder<M extends Serializable> extends SerializeTranscoder {
    protected static Logger logger = LoggerFactory.getLogger(ListTranscoder.class);
    @SuppressWarnings("unchecked")
    public List<M> deserialize(byte[] in) {
        List<M> list = new ArrayList<M>();
        ByteArrayInputStream bis = null;
        ObjectInputStream is = null;
        try {
            if (in != null) {
                bis = new ByteArrayInputStream(in);
                is = new ObjectInputStream(bis);
                while (true) {
                    M m = (M) is.readObject();
                    if (m == null) {
                        break;
                    }

                    list.add(m);

                }
                is.close();
                bis.close();
            }
        } catch (IOException e) {
            logger.error("Caught IOException decoding %d bytes of data");
        } catch (ClassNotFoundException e) {
            logger.error("Caught CNFE decoding %d bytes of data");
        } finally {
            close(is);
            close(bis);
        }
        return list;
    }


    @SuppressWarnings("unchecked")
    @Override
    public byte[] serialize(Object value) {
        if (value == null)
            throw new NullPointerException("Can't serialize null");
        List<M> values = (List<M>) value;
        byte[] results = null;
        ByteArrayOutputStream bos = null;
        ObjectOutputStream os = null;
        try {
            bos = new ByteArrayOutputStream();
            os = new ObjectOutputStream(bos);
            for (M m : values) {
                os.writeObject(m);
            }
            os.close();
            bos.close();
            results = bos.toByteArray();
        } catch (IOException e) {
            throw new IllegalArgumentException("Non-serializable object", e);
        } finally {
            close(os);
            close(bos);
        }
        return results;
    }
}