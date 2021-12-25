package com.bjpowernode.crm.web.controller;

import com.bjpowernode.crm.constants.Constants;
import com.bjpowernode.crm.pojo.User;
import com.bjpowernode.crm.services.UserService;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.util.Base64;

//该类负责页面的跳转
@Controller
public class ViewController {

    @Autowired
    private UserService userService;

    @Autowired(required = false)
    private HttpServletResponse response;

    @Autowired(required = false)
    private HttpServletRequest request;

    @Autowired(required = false)
    private HttpSession session;

    @RequestMapping("/")
    public String root(@CookieValue(value = Constants.CookieNames.USER_NAME,required = false) String username,
                       @CookieValue(value = Constants.CookieNames.USER_PWD,required = false) String password) throws UnsupportedEncodingException {

        String ip = request.getRemoteAddr();//客户端的ip地址
        //if (username != null && !username.equals("") && password != null && !password.equals("")) {
        // 判断所有字符串都不为null或""或空白字符
        if (StringUtils.isNoneBlank(username,password)){
            username = new String(Base64.getDecoder().decode(username),"UTF-8");//真正的用户
            password = new String(Base64.getDecoder().decode(password),"UTF-8");// md5加密的密码

            User user = userService.getUserForAuto(username, password, ip);

            if (user != null){
                session.setAttribute(Constants.LOGIN_USER,user);
                return "redirect:/workbench/index.html";
            }

        }

        return "login";
    }

    /*@RequestMapping("/workbench/index.html")
    public String page001() {
        return "workbench/index";
    }

    @RequestMapping("/workbench/main/index.html")
    public String page002() {
        return "workbench/main/index";
    }

    @RequestMapping("/settings/index.html")
    public String page003() {
        return "settings/index";
    }*/

    // /*.html根目录下的html，例如：/index.html、/xxx.html，但是不能匹配 /user/index.html
    // /**/*.html所有以.html结尾的路径
    @RequestMapping("/**/*.html")
    public String pager(){
        // "/setting/index.html"
        String uri = request.getRequestURI();
        //  "/settings/index.html" ===> "settings/index"
        return uri.substring(1,uri.lastIndexOf(".html"));
    }
}
