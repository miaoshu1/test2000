package com.bjpowernode.crm.services;

import com.bjpowernode.crm.mapper.ClueActivityMapper;
import com.bjpowernode.crm.mapper.ClueMapper;
import com.bjpowernode.crm.pojo.ClueActivity;
import com.bjpowernode.crm.pojo.Page;
import com.bjpowernode.crm.utils.UUIDUtil;
import org.apache.ibatis.transaction.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class ClueServiceImpl implements ClueService{

    @Autowired
    private ClueMapper clueMapper;

    @Autowired
    private ClueActivityMapper clueActivityMapper;

    @Override
    public void getPage(Map search, Page page) {
        /*
            private Integer totalRows;// 总记录数
            private Integer totalPages;// 总页数
            private List data;
         */
        // 查询记录数
        Integer totalRows = clueMapper.getCount(search);
        //计算总页数
        Integer totalPages = (totalRows - 1) / page.getRowsPerPage() + 1;
        /*
            ... limit start, length
            ... limit 0, 10 第1页
            ... limit 10, 10 第2页
            ... limit 20, 10 第3页
                ...
            ... limit (n-1)*10, 10 第n页
         */
        int start = (page.getCurrentPage() - 1) * page.getRowsPerPage();
        List data = clueMapper.getPageData(search,start,page.getRowsPerPage());

        page.setTotalRows(totalRows);
        page.setTotalPages(totalPages);
        page.setData(data);


    }

    @Override
    public List<ClueActivity> getClueActivities(String clueId) {
        return clueActivityMapper.getClueActivities(clueId);
    }

    @Override
    public void rel(String clueId, String[] actIds) {
        clueActivityMapper.delByClueId(clueId);//先清除关联
        if (actIds != null && actIds.length > 0){
            List data = new ArrayList();
            for (String actId : actIds) {
                ClueActivity clueActivity = new ClueActivity();
                clueActivity.setId(UUIDUtil.getUUID());
                clueActivity.setClueId(clueId);
                clueActivity.setActivityId(actId);
                data.add(clueActivity);
            }
            clueActivityMapper.saveList(data);

        }
    }

    public void convert(String clueId, Boolean createTran, Transaction transaction) {
        // 查询线索相关数据:线索、线索备注、线索和市场活动的关系

        // 添加客户：数据从线索中提取

        // 将线索备注备份到客户备注中

        // 添加联系人：数据从线索中提取

        // 将线索备注备份到联系人备注中

        // 将线索和市场活动的关系  备份到 联系人和市场活动的关系中 需要把线索id换成联系人的id

        if (createTran) {
            // 添加交易信息，部分数据来自于页面填写，部分数据来自于线索

            // 添加交易历史
        }

        // 删除线索相关数据：先删关联表、再删线索表
    }
}
