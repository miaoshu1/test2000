package com.bjpowernode.crm.mapper;

import com.bjpowernode.crm.pojo.ActivityRemark;

import java.util.List;

public interface ActRemarkMapper {
    List getRemarks(String actId);

    void saveRemark(ActivityRemark activityRemark);

    void editRemark(ActivityRemark activityRemark);

    void delRemark(String id);
}
