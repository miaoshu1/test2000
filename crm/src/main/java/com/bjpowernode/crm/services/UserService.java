package com.bjpowernode.crm.services;

import com.bjpowernode.crm.pojo.User;

public interface UserService {
    User getUser(String username, String password, String ip);

    int update(String oldPwd,String newPwd);
}
