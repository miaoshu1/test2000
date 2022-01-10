package com.bjpowernode.crm.web.controller;

import com.bjpowernode.crm.constants.Constants;
import com.bjpowernode.crm.pojo.ClueActivity;
import com.bjpowernode.crm.pojo.Page;
import com.bjpowernode.crm.services.ClueService;
import org.apache.ibatis.transaction.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("clue")
public class ClueController {

    @Autowired
    private ClueService clueService;

    @GetMapping("page.json")
    public Page page(@RequestParam Map search,Page page){
        clueService.getPage(search,page);

        return page;
    }

    @GetMapping("clueActivities.json")
    public List<ClueActivity> getClueActivities(String clueId){
        return clueService.getClueActivities(clueId);
    }

    @PostMapping("rel.do")
    public Map rel(String clueId,String[] actIds){
        clueService.rel(clueId,actIds);

        return Constants.Result.SUC_WITH_MSG;
    }

    @PostMapping("convert.do")
    public Map convert(String clueId, Boolean createTran, Transaction transaction) {
        clueService.convert(clueId, createTran, transaction);
        return Constants.Result.SUC_WITH_MSG;
    }
}
