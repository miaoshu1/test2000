package com.bjpowernode.crm.web.listener;

import com.bjpowernode.crm.pojo.Value;
import com.bjpowernode.crm.services.ValueService;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.*;

//监听服务器启动，加载数据缓存
@WebListener
public class LoadCache implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        WebApplicationContext factory = ContextLoader.getCurrentWebApplicationContext();
        ValueService valueService = factory.getBean(ValueService.class);

        // 所有的字典值
        List<Value> values = valueService.getAll();
        // 需求：根据字典类型进行分组，不同的类型对应不同的集合
        // Map<String(字典类型), List(该类型对应的集合)>
        /*
            typeId  text

            source  在线商场
            source  公开媒介
            source  外部介绍

            stage   07成交
            stage   01资质审查
            stage   08丢失的线索
         */

        Map<String,List> map = new HashMap<>();
        for (Value value : values) {
            String typeId = value.getTypeId();//字典类型
            List list = map.get(typeId);
            if (list == null){
                list = new ArrayList();
                map.put(typeId,list);
            }
            list.add(value);
        }

        sce.getServletContext().setAttribute("dicCacheMap",map);


        System.out.println("读取阶段和可能性的对应关系");
        ResourceBundle resourceBundle = ResourceBundle.getBundle("stage2posii");
        Enumeration<String> keys = resourceBundle.getKeys();
        Map posiiMap = new HashMap();

        while (keys.hasMoreElements()){
            String key = keys.nextElement();
            String value = resourceBundle.getString(key);
            posiiMap.put(key,value);
        }
        sce.getServletContext().setAttribute("posiiMap",posiiMap);


    }
}
