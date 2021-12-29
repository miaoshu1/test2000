package com.bjpowernode.crm.web.controller;

import com.bjpowernode.crm.mapper.TypeMapper;
import com.bjpowernode.crm.pojo.Value;
import com.bjpowernode.crm.services.ValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("value")
public class ValueController {

    @Autowired
    private ValueService valueService;

    @RequestMapping("index.html")
    public ModelAndView index(ModelAndView mv){
        List values = valueService.getAll();

        mv.addObject("values",values);
        mv.setViewName("/settings/dictionary/value/index");
        return mv;
    }

    @RequestMapping("changeOrderNo.do")
    @ResponseBody
    public Map changeOrderNo(String id, String orderNo){
        valueService.changeOrderNo(id,orderNo);
        return new HashMap(){{
           put("success",true);
        }};
    }
    @RequestMapping("changeOrderNos.do")
    @ResponseBody
    public Map changeOrderNos(String[] ids){
        valueService.changeOrderNos(ids);
        return new HashMap(){{
            put("success",true);
        }};
    }

    @RequestMapping("save.do")
    public String save(Value value){
        valueService.save(value);
        return "redirect:index.html";
    }

    @RequestMapping("edit.html")
    public ModelAndView edit(ModelAndView mv,String id){
        Value value = valueService.get(id);
        mv.addObject("value",value);
        mv.setViewName("/settings/dictionary/value/edit");
        return mv;
    }

    @RequestMapping("edit.do")
    public String editDo(Value value){
        valueService.edit(value);
        return "redirect:index.html";
    }

    @RequestMapping("del.do")
    public String delDo(String[] id){
        valueService.del(id);
        return "redirect:index.html";
    }
}
