package com.bjpowernode.crm.web.interceptor;

import com.bjpowernode.crm.constants.Constants;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        Object user = request.getSession().getAttribute(Constants.LOGIN_USER);

        if (user == null){
            System.out.println("必须登陆才能访-问,强制跳转到登陆页面");
            response.sendRedirect("/");
            return false;
        }

        return true;
    }
}
