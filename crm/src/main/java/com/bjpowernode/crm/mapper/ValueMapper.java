package com.bjpowernode.crm.mapper;

import java.util.List;

public interface ValueMapper {

    List getRelValue(String[] id);

    void delForce(String[] id);
}
