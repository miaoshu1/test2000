package com.bjpowernode.crm.mapper;

import com.bjpowernode.crm.pojo.Value;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ValueMapper {

    List getRelValue(String[] id);

    void delForce(String[] id);

    List getAll();

    void changeOrderNo(@Param("id") String id, @Param("orderNo") String orderNo);

    void save(Value value);

    Value get(String id);

    void edit(Value value);

    void del(String[] id);
}
