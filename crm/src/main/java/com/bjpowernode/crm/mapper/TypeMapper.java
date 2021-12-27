package com.bjpowernode.crm.mapper;

import com.bjpowernode.crm.pojo.Type;

import java.util.List;

public interface TypeMapper {
    List getAll();

    Boolean getRepeat(String id);

    void save(Type type);

    Type get(String id);

    void edit(Type type);

    void delete(String[] id);
}
