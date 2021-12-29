package com.bjpowernode.crm.web.interceptor;

import com.bjpowernode.crm.constants.Constants;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;

public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        Object user = request.getSession().getAttribute(Constants.LOGIN_USER);

        if (user == null){
            System.out.println("必须登陆才能访-问,强制跳转到登陆页面");

            String uri = request.getRequestURI();
            String queryString = request.getQueryString();//获取查询字符串
            if (StringUtils.isNoneBlank(queryString)){
                uri = uri + "?" + queryString;
            }
            System.out.println(uri);
            URLEncoder.encode(uri,"UTF-8");

            response.sendRedirect("/?redirectUrl="+uri);
            return false;
        }

        return true;
    }
}
