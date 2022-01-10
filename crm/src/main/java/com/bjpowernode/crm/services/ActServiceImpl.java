package com.bjpowernode.crm.services;

import com.bjpowernode.crm.mapper.ActMapper;
import com.bjpowernode.crm.mapper.ActRemarkMapper;
import com.bjpowernode.crm.pojo.Activity;
import com.bjpowernode.crm.pojo.ActivityRemark;
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

    @Autowired
    ActRemarkMapper actRemarkMapper;

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

    @Override
    public List getRemarks(String actId) {
        return actRemarkMapper.getRemarks(actId);
    }

    @Override
    public void saveRemark(ActivityRemark activityRemark) {
        activityRemark.setId(UUIDUtil.getUUID());
        activityRemark.setNoteTime(DateTimeUtil.getSysTime());
        actRemarkMapper.saveRemark(activityRemark);
    }

    @Override
    public void editRemark(ActivityRemark activityRemark) {
        activityRemark.setEditTime(DateTimeUtil.getSysTime());
        actRemarkMapper.editRemark(activityRemark);
    }

    @Override
    public void delRemark(String id) {
        actRemarkMapper.delRemark(id);
    }
}
