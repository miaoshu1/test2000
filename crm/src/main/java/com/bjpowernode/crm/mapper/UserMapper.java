package com.bjpowernode.crm.mapper;

import com.bjpowernode.crm.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    User getUser(@Param("loginAct") String username,
                 @Param("loginPwd") String password);

    void changePwd(@Param("pwd") String oldPwd, @Param("id") String id);

    User get(String id);

    List getOwners();
}
