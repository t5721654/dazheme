package com.cn.ant.redis.transcoder;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.Closeable;

/**
 * 序列化的公共类
 * Created by huanggenhua on 2015/4/26.
 */
public abstract class SerializeTranscoder {
    protected static Logger logger = LoggerFactory.getLogger(SerializeTranscoder.class);

    public abstract byte[] serialize(Object value);

    public abstract Object deserialize(byte[] in);

    public void close(Closeable closeable) {
        if (closeable != null) {
            try {
                closeable.close();
            } catch (Exception e) {
                logger.info("Unable to close " + closeable, e);
            }
        }
    }
}
