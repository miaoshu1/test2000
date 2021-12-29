package com.bjpowernode.crm.mapper;

import com.bjpowernode.crm.pojo.Dept;

import java.util.List;

public interface DeptMapper {
    List getAll();

    void save(Dept dept);

    void edit(Dept dept);

    Dept get(String id);

    void del(String[] ids);

    boolean getRepeat(String no);
}
