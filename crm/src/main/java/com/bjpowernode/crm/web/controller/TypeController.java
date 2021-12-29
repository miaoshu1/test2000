package com.bjpowernode.crm.web.controller;

import com.bjpowernode.crm.pojo.Type;
import com.bjpowernode.crm.services.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("type")
public class TypeController {
    @Autowired
    private TypeService typeService;

    @RequestMapping("index.html")
    public ModelAndView index(ModelAndView mv){
        List types = typeService.getAll();
        mv.addObject("types",types);
        mv.setViewName("settings/dictionary/type/index");
        return mv;
    }

    @RequestMapping("types.json")
    @ResponseBody
    public List types(){
        return typeService.getAll();
    }

    @RequestMapping("check.do")
    @ResponseBody
    public Map checkDo(String id){
        return new HashMap(){{
            put("repeat",typeService.getRepeat(id));
        }};
    }

    @RequestMapping("save.do")
    public String saveDo(Type type){
        typeService.save(type);
        return "redirect:index.html";
    }

    @RequestMapping("edit.html")
    public ModelAndView edit(ModelAndView mv,String id){
        Type type = typeService.get(id);
        mv.addObject("type",type);
        mv.setViewName("settings/dictionary/type/edit");
        return mv;
    }

    @RequestMapping("edit.do")
    public String editDo(Type type){

        typeService.edit(type);

        return "redirect:index.html";
    }

    @RequestMapping("checkDel.do")
    @ResponseBody
    public List checkDel(String[] id){
        return typeService.getRelValue(id);
    }

    @RequestMapping("del.do")
    public String delDo(String[] id){
        typeService.delete(id);
        return "redirect:index.html";
    }

    @RequestMapping("delForce.do")
    public String delForce(String[] id){
        typeService.delForce(id);
        return "redirect:index.html";
    }
}
