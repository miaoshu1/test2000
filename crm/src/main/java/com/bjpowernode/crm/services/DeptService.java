package com.bjpowernode.crm.services;

import com.bjpowernode.crm.pojo.Dept;

import java.util.List;

public interface DeptService {
    List getAll();

    void save(Dept dept);

    void edit(Dept dept);

    Dept get(String id);

    void del(String[] ids);
}
