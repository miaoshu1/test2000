package com.bjpowernode.crm.web.controlleradvice;


import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@ControllerAdvice // 对控制器的增强处理
public class MyExceptionHandler {

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Map exception(Exception e) {
        return new HashMap(){{
            put("success", false);
            put("msg", e.getMessage());
        }};
    }

}
