package com.bjpowernode.crm.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

//该类负责页面的跳转
@Controller
public class ViewController {

    @RequestMapping("/")
    public String root(){
        return "login";
    }

    @RequestMapping("/workbench/index.html")
    public String page001(){
        return "workbench/index";
    }
}
