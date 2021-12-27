package com.bjpowernode.crm.services;

import com.bjpowernode.crm.pojo.Type;

import java.util.List;

public interface TypeService {
    List getAll();

    Object getRepeat(String id);

    void save(Type type);

    Type get(String id);

    void edit(Type type);

    List getRelValue(String[] id);

    void delete(String[] id);

    void delForce(String[] id);
}
