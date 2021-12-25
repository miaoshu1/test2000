package com.bjpowernode.crm.services;

import com.bjpowernode.crm.constants.Constants;
import com.bjpowernode.crm.mapper.UserMapper;
import com.bjpowernode.crm.pojo.User;
import com.bjpowernode.crm.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.util.Date;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    public User getUser(String username, String password, String ip) {

        // 密码加密
        password = MD5Util.getMD5(password);

        User user = userMapper.getUser(username, password);

        if (user == null) {
            throw new RuntimeException(Constants.Message.ACT_PWD_ERR);
        }

        // 判断是否过期
        // 失效时间为空表示永不失效  yyyy-MM-dd HH:mm:ss
        String expireTime = user.getExpireTime();
        if (expireTime != null && !"".equals(expireTime)) {
            // now:         2021-12-23
            // expireTime:  2021-12-20
            long now = System.currentTimeMillis();
            try {
                Date expireDate = Constants.DateFormat.SDF19.parse(expireTime);
                long expire = expireDate.getTime();
                if (now > expire) {
                    throw new RuntimeException(Constants.Message.ACT_GQ);
                }
            } catch (ParseException e) {
                throw new RuntimeException(Constants.Message.ACT_GQ2);
            }
        }

        // 判断是否锁定  0:锁定   1:启用
        if(!"1".equals(user.getLockStatus())) {
            throw new RuntimeException(Constants.Message.ACT_LOCK);
        }


        // 判断ip是否允许访问
        // 为空时表示不限制IP，多个IP地址之间使用半角逗号隔开
        String allowIps = user.getAllowIps();
        if(allowIps!=null && !"".equals(allowIps)) {
            // ip:          127.0.0.1
            // allowIps:    127.0.0.10,192.168.137.2
            String[] ips = allowIps.split(",");

            boolean allow = false;
            for (String s : ips) {
                if (ip.equals(s)) {
                    allow = true;
                }
                break;
            }
            if(!allow) {
                throw new RuntimeException(Constants.Message.IP_UN_ALLOW);
            }

        }

        return user;
    }

    @Override
    public int update(String oldPwd, String newPwd,User user) {
        return userMapper.update(oldPwd,newPwd);
    }
}
