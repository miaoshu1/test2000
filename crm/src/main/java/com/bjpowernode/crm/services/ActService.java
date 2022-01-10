package com.bjpowernode.crm.services;

import com.bjpowernode.crm.pojo.Activity;
import com.bjpowernode.crm.pojo.ActivityRemark;

import java.util.List;
import java.util.Map;

public interface ActService {
    List getAll(Map conditions);

    void save(Activity activity);

    Activity get(String id);

    void edit(Activity activity);

    void delete(String[] ids);

    void saveList(List data);

    List getRemarks(String actId);

    void saveRemark(ActivityRemark activityRemark);

    void editRemark(ActivityRemark activityRemark);

    void delRemark(String id);
}
