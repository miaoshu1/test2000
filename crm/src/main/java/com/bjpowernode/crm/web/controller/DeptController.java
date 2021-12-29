package com.bjpowernode.crm.web.controller;

import com.bjpowernode.crm.constants.Constants;
import com.bjpowernode.crm.pojo.Dept;
import com.bjpowernode.crm.services.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("dept")
public class DeptController {

    @Autowired
    private DeptService deptService;

    @RequestMapping("depts.json")
    public List depts(){
        return deptService.getAll();
    }

    @PostMapping("save.do")
    public Map save(Dept dept){
        deptService.save(dept);
        return Constants.Result.SUC_WITH_MSG;
    }

    @GetMapping("dept.json")
    public Dept dept(String id){
        Dept dept = deptService.get(id);
        return dept;
    }
    @PutMapping("edit.do")
    public Map edit(Dept dept){
        deptService.edit(dept);
        return Constants.Result.SUC_WITH_MSG;
    }

    @DeleteMapping("del.do")
    public Map del(String[] ids){
        deptService.del(ids);
        return Constants.Result.SUC_WITH_MSG;
    }
}
