package com.bjpowernode.crm.mapper;

import com.bjpowernode.crm.pojo.Activity;

import java.util.List;
import java.util.Map;

public interface ActMapper {
    List getAll(Map conditions);

    void save(Activity activity);

    Activity get(String id);

    void edit(Activity activity);

    void delete(String[] ids);

    void saveList(List data);
}
