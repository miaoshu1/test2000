package com.bjpowernode.crm.services;

import com.bjpowernode.crm.mapper.ActMapper;
import com.bjpowernode.crm.pojo.Activity;
import com.bjpowernode.crm.utils.DateTimeUtil;
import com.bjpowernode.crm.utils.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ActServiceImpl implements ActService{

    @Autowired
    ActMapper actMapper;

    @Override
    public List getAll(Map conditions) {
        return actMapper.getAll(conditions);
    }

    @Override
    public void save(Activity activity) {
        activity.setId(UUIDUtil.getUUID());
        activity.setCreateTime(DateTimeUtil.getSysTime());
        actMapper.save(activity);
    }

    @Override
    public Activity get(String id) {
        return actMapper.get(id);
    }

    @Override
    public void edit(Activity activity) {
        activity.setEditTime(DateTimeUtil.getSysTime());
        actMapper.edit(activity);
    }

    @Override
    public void delete(String[] ids) {
        actMapper.delete(ids);
    }

    @Override
    public void saveList(List data) {
        actMapper.saveList(data);
    }
}
