package com.bjpowernode.crm.mapper;

import com.bjpowernode.crm.pojo.ClueActivity;

import java.util.List;

public interface ClueActivityMapper {
    List<ClueActivity> getClueActivities(String clueId);

    void delByClueId(String clueId);

    void saveList(List data);
}
