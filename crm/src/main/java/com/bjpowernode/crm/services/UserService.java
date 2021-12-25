package com.bjpowernode.crm.services;

import com.bjpowernode.crm.pojo.User;

public interface UserService {
    User getUser(String username, String password, String ip);

    User getUserForAuto(String username,String password,String ip);

    void changePwd(String oldPwd, String newPwd, User user);
}
