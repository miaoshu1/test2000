package com.bjpowernode.crm.web.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("cache")
public class CacheController {

    @GetMapping("{typeId}")
    public List getOptions(@PathVariable String typeId, HttpSession session){
        Map dicCacheMap = (Map)session.getServletContext().getAttribute("dicCacheMap");
        return (List) dicCacheMap.get(typeId);

    }
}
