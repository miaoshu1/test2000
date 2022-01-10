package com.bjpowernode.crm.services;

import com.bjpowernode.crm.pojo.ClueActivity;
import com.bjpowernode.crm.pojo.Page;
import org.apache.ibatis.transaction.Transaction;

import java.util.List;
import java.util.Map;

public interface ClueService {
    void getPage(Map search, Page page);

    List<ClueActivity> getClueActivities(String clueId);

    void rel(String clueId, String[] actIds);

    void convert(String clueId, Boolean createTran, Transaction transaction);
}
