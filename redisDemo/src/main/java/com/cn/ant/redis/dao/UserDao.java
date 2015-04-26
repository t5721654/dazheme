package com.cn.ant.redis.dao;

import com.cn.ant.redis.entity.User;
import com.cn.ant.redis.transcoder.ListTranscoder;
import com.cn.ant.redis.transcoder.SerializeTranscoder;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.serializer.RedisSerializer;

import java.util.List;

/**
 * Created by huanggenhua on 2015/4/25.
 */
public class UserDao extends AbstractBaseRedisDao<String,User> implements IUserDao {

    /**
     * 新增
     * @param user
     * @return
     */
    public boolean add(final User user) {
        boolean result = redisTemplate.execute(new RedisCallback<Boolean>() {
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] key  = serializer.serialize(user.getId());
                byte[] name = serializer.serialize(user.getName());
                return connection.setNX(key, name);
            }
        });
        return result;
    }

    /**
     * 批量新增 使用pipeline方式
     *@param list
     *@return
     */
    public boolean add(final List<User> list) {
        boolean result = redisTemplate.execute(new RedisCallback<Boolean>() {
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
                RedisSerializer<String> serializer = getRedisSerializer();
                for (User user : list) {
                    byte[] key  = serializer.serialize(user.getId());
                    byte[] name = serializer.serialize(user.getName());
                    connection.setNX(key, name);
                }
                return true;
            }
        }, false, true);
        return result;
    }

    public boolean add(final String key, final List<User> list) {
        boolean result = redisTemplate.execute(new RedisCallback<Boolean>() {
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
                RedisSerializer<String> serializer = getRedisSerializer();
                SerializeTranscoder listTrans = new ListTranscoder<User>();
                byte[] keys = serializer.serialize(key);
                byte[] contents = listTrans.serialize(list);
                connection.setNX(keys, contents);
                return true;
            }
        });
        return result;
    }

    /**
     * 删除
     * @param key
     */
    public void delete(String key) {
        redisTemplate.delete(key);
    }

    /**
     * 删除多个
     * @param keys
     */
    public void delete(List<String> keys) {
        redisTemplate.delete(keys);
    }

    /**
     * 修改
     * @param user
     * @return
     */
    public boolean update(final User user) {
        String key = user.getId();
        if (get(key) == null) {
            throw new NullPointerException("数据行不存在, key = " + key);
        }
        boolean result = redisTemplate.execute(new RedisCallback<Boolean>() {
            public Boolean doInRedis(RedisConnection connection)
                    throws DataAccessException {
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] key  = serializer.serialize(user.getId());
                byte[] name = serializer.serialize(user.getName());
                connection.set(key, name);
                return true;
            }
        });
        return result;
    }

    /**
     * 通过key获取
     * @param keyId
     * @return
     */
    public User get(final String keyId) {
        User result = redisTemplate.execute(new RedisCallback<User>() {
            public User doInRedis(RedisConnection connection) throws DataAccessException {
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] key = serializer.serialize(keyId);
                byte[] value = connection.get(key);
                if (value == null) {
                    return null;
                }
                String name = serializer.deserialize(value);
                return new User(keyId, name, null);
            }
        });
        return result;
    }

    public List<User> getByKey(final String keyId){
        List<User> userList = redisTemplate.execute(new RedisCallback<List<User>>() {
            public List<User> doInRedis(RedisConnection connection) throws DataAccessException {
                RedisSerializer<String> serializer = getRedisSerializer();
                SerializeTranscoder listTrans = new ListTranscoder<User>();
                byte[] key = serializer.serialize(keyId);
                byte[] value = connection.get(key);
                if (value == null) {
                    return null;
                }
                return (List<User>) listTrans.deserialize(value);
            }
        });
        return userList;
    }
}
