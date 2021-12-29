package com.bjpowernode.crm.services;

import com.bjpowernode.crm.pojo.Value;

import java.util.List;

public interface ValueService {
    List getAll();


    void changeOrderNo(String id, String orderNo);

    void changeOrderNos(String[] ids);

    void save(Value value);

    Value get(String id);

    void edit(Value value);

    void del(String[] id);
}
